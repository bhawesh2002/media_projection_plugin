package com.example.media_projection_plugin

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class MediaProjectionPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {

    private var activity: Activity? = null
    private var context: Context? = null

    private lateinit var channel: MethodChannel

    private var mediaProjectionManager: MediaProjectionManager? = null
    private var projectionRequest: String? = null
    private var pendingProjectionResult: Result? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "com.media_projection_plugin/media_plugin")
        channel.setMethodCallHandler(this)
        context = binding.applicationContext
        mediaProjectionManager = context?.getSystemService(
            Context.MEDIA_PROJECTION_SERVICE
        ) as? MediaProjectionManager

        if (mediaProjectionManager == null) {
            Log.e(TAG, "Failed to get MediaProjectionManager")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        if (pendingProjectionResult != null) {
            context?.stopService(Intent(context, MediaProjectionService::class.java))
        }
        channel.setMethodCallHandler(null)
        mediaProjectionManager = null
        projectionRequest = null
        pendingProjectionResult = null
        activity = null
        context = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "start_projection" -> {
                startProjection(call, result)
            }

            "stop_projection" -> {
                stopProjection(result)
            }

            else -> result.notImplemented()
        }
    }

    fun startProjection(call: MethodCall, result: Result) {
        if (!isHealthy(result)) {
            return
        }

        val arguments = call.arguments<Map<String, Any>>()!!

        projectionRequest = arguments["request"] as? String?
        if (projectionRequest == null) {
            result.error("INVALID_REQUEST", "Request parameter is required", null)
            return
        }
        pendingProjectionResult = result

        try {
            val intent = mediaProjectionManager?.createScreenCaptureIntent()
            activity?.startActivityForResult(intent, SCREEN_CAPTURE_REQUEST_CODE)
        } catch (e: Exception) {
            Log.e(TAG, "Error starting screen capture", e)
            pendingProjectionResult?.error(
                "START_ERROR",
                "Failed to start screen capture: ${e.message}",
                null
            )
            pendingProjectionResult = null
            projectionRequest = null
        }
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ): Boolean {
        if (requestCode == SCREEN_CAPTURE_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK && data != null) {
                try {
                    val serviceIntent = Intent(context, MediaProjectionService::class.java).apply {
                        action = MediaProjectionService.START_PROJECTION
                        putExtra("resultCode", resultCode)
                        putExtra("data", data)
                        putExtra("request", projectionRequest)
                    }
                    pendingProjectionResult?.success(true)

                    context?.startForegroundService(serviceIntent)

                } catch (e: Exception) {
                    Log.e(TAG, "Error starting service", e)
                    pendingProjectionResult?.error(
                        "SERVICE_ERROR",
                        "Failed to start recording service: ${e.message}",
                        null
                    )
                }

            } else {
                val message = when (resultCode) {
                    Activity.RESULT_CANCELED -> "User cancelled the request"
                    else -> "Permission denied with result code: $resultCode"
                }
                pendingProjectionResult?.error("PERMISSION_DENIED", message, null)
            }
            pendingProjectionResult = null
            projectionRequest = null
            return true
        }

        return false
    }

    private fun stopProjection(result: Result?) {
        try {
            val serviceIntent = Intent(context, MediaProjectionService::class.java).apply {
                action = MediaProjectionService.STOP_PROJECTION
            }
            context?.startService(serviceIntent)
            result?.success(true)

        } catch (e: Exception) {
            Log.e(TAG, "Error stopping projection", e)
            result?.error("STOP_ERROR", "Failed to stop projection: ${e.message}", null)
        }
    }

    fun isHealthy(result: Result): Boolean {
        if (activity == null) {
            result.error("NO_ACTIVITY", "Activity not available", null)
            return false
        }

        // Check if manager is available
        if (mediaProjectionManager == null) {
            result.error("NO_MANAGER", "MediaProjectionManager not available", null)
            return false
        }

        // Check if there's already a pending request
        if (pendingProjectionResult != null) {
            result.error("ALREADY_REQUESTING", "A projection request is already in progress", null)
            return false
        }
        return true
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
        if (pendingProjectionResult != null) {
            pendingProjectionResult?.error(
                "ACTIVITY_DETACHED",
                "Activity was detached before result could be returned",
                null
            )
            pendingProjectionResult = null
            projectionRequest = null
        }
        Log.d(TAG, "Detached from activity")
    }


    companion object {
        private const val SCREEN_CAPTURE_REQUEST_CODE = 1001
        private const val TAG = "MediaProjectionPlugin"

    }


}
