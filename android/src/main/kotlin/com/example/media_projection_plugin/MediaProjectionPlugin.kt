package com.example.media_projection_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class MediaProjectionPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    private val mediaProjectionService: MediaProjectionService = MediaProjectionService()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "com.media_projection_plugin/media_plugin")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {
            "start_projection" -> {
                try {
                    val arguments = call.arguments<Map<String, Any>>()!!
                    val request:String = arguments["request"] as String
                    mediaProjectionService.startProjection(request = MediaProjectionRequest.fromJson(
                        request,
                    ))
                    result.success(true)
                }catch (e: Exception){
                    result.error("PROJECTION_START_ERROR", e.toString(), e)
                }
            }
            "stop_projection" -> {
                try {
                    mediaProjectionService.stopProjection()
                    result.success(true)
                }catch (e: Exception){
                    result.error("PROJECTION_STOP_ERROR", e.toString(), e)
                }

            }

            else -> result.notImplemented()
        }
    }
}
