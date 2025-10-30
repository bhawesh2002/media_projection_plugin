package com.example.media_projection_plugin

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Rect
import android.hardware.display.VirtualDisplay
import android.media.MediaRecorder
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.IBinder
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import androidx.core.app.NotificationCompat
import java.io.File
import java.io.IOException
import java.time.LocalDateTime

class MediaProjectionService : Service() {

    private lateinit var mediaProjectionManager: MediaProjectionManager
    private var mediaProjection: MediaProjection? = null
    private var virtualDisplay: VirtualDisplay? = null
    private val mediaRecorder by lazy {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            MediaRecorder(applicationContext)
        } else {
            @Suppress("DEPRECATION")
            MediaRecorder()
        }
    }

    private var isRecording = false

    override fun onCreate() {
        super.onCreate()
        mediaProjectionManager =
            getSystemService(MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        createNotification()
    }


    private fun getScreenSize(): Pair<Int, Int> {
        val windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val windowMetrics = windowManager.currentWindowMetrics
            val bounds: Rect = windowMetrics.bounds
            Pair(bounds.width(), bounds.height())
        } else {
            val displayMetrics = DisplayMetrics()
            @Suppress("DEPRECATION")
            windowManager.defaultDisplay.getMetrics(displayMetrics)
            Pair(displayMetrics.widthPixels, displayMetrics.heightPixels)
        }
    }

    private fun configureMediaRecorder(request: MediaProjectionRequest) {
        mediaRecorder.apply {
            try {
                if (request.audioOnly) {
                    setAudioSource(request.audioRecordingProps.audioSource)
                    setOutputFormat(request.audioRecordingProps.audioOpFormat)
                    setAudioEncoder(request.audioRecordingProps.audioEncoder)
                    setAudioEncodingBitRate(request.audioRecordingProps.audioBitrate)
                    setAudioChannels(request.audioRecordingProps.audioChannels)
                    setAudioSamplingRate(request.audioRecordingProps.audioSamplingRate)
                } else {
                    setAudioSource(request.audioRecordingProps.audioSource)
                    setVideoSource(request.videoRecordingProps.videoSource)
                    setOutputFormat(request.videoRecordingProps.videoOpFormat)

                    val screenSize = getScreenSize()
                    setVideoSize(
                        request.videoRecordingProps.screenWidth ?: screenSize.first,
                        request.videoRecordingProps.screenHeight ?: screenSize.second
                    )
                    setVideoFrameRate(request.videoRecordingProps.fps)
                    setVideoEncoder(request.videoRecordingProps.videoEncoder)
                    setVideoEncodingBitRate(request.videoRecordingProps.videoBitrate)

                    setAudioEncoder(request.audioRecordingProps.audioEncoder)
                    setAudioEncodingBitRate(request.audioRecordingProps.audioBitrate)
                    setAudioChannels(request.audioRecordingProps.audioChannels)
                    setAudioSamplingRate(request.audioRecordingProps.audioSamplingRate)
                }

                val outputFile = if (request.outputPath != null) {
                    File(request.outputPath, request.fileName ?: "recording_${getTimestamp()}.mp4")
                } else {
                    File(cacheDir, request.fileName ?: "recording_${getTimestamp()}.mp4")
                }

                outputFile.parentFile?.mkdirs()
                setOutputFile(outputFile.absolutePath)

                request.maxDurationMs?.let { setMaxDuration(it) }
                request.maxFileSizeBytes?.let { setMaxFileSize(it) }

                setOnInfoListener { _, what, extra ->
                    when (what) {
                        MediaRecorder.MEDIA_RECORDER_INFO_MAX_DURATION_REACHED -> {
                            Log.d(TAG, "Max duration reached")
                            stopProjection()
                            stopSelf()
                        }

                        MediaRecorder.MEDIA_RECORDER_INFO_MAX_FILESIZE_REACHED -> {
                            Log.d(TAG, "Max file size reached")
                            stopProjection()
                            stopSelf()
                        }
                    }
                }

                setOnErrorListener { _, what, extra ->
                    Log.e(TAG, "MediaRecorder error: what=$what, extra=$extra")
                    stopProjection()
                    stopSelf()
                }
            } catch (e: Exception) {
                Log.d(TAG, "Error while configuring media recorder", e)
            }

        }
        try {
            mediaRecorder.prepare()
        } catch (e: Exception) {
            Log.d(TAG, "Error in preparing media recorder", e)
        }

    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            START_PROJECTION -> {
                val resultCode = intent.getIntExtra("resultCode", -1)
                val data: Intent? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra("data", Intent::class.java)
                } else {
                    @Suppress("DEPRECATION")
                    intent.getParcelableExtra("data")
                }
                if (resultCode == -1 || data == null) {
                    Log.e(TAG, "Invalid result code or data")
                    stopSelf()
                    return START_NOT_STICKY
                }

                val requestJson = intent.getStringExtra("request")
                val projectionRequest = try {
                    requestJson?.let {
                        MediaProjectionRequest.fromJson(it)
                    } ?: MediaProjectionRequest()

                } catch (e: Exception) {
                    Log.e(TAG, "Failed to parse projection request", e)
                    stopSelf()
                    return START_NOT_STICKY
                }

                startForeground(NOTIFICATION_ID, createNotification())
                startProjection(resultCode, data, projectionRequest)
            }

            STOP_PROJECTION -> {
                stopProjection()
                stopSelf()
            }
        }
        return START_STICKY
    }

    fun startProjection(resultCode: Int, data: Intent, request: MediaProjectionRequest) {
        try {
            mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)
            if (mediaProjection == null) {
                Log.e(TAG, "Failed to get MediaProjection")
                stopSelf()
                return
            }

            mediaProjection?.registerCallback(object : MediaProjection.Callback() {
                override fun onStop() {
                    Log.d(TAG, "MediaProjection stopped")
                    stopProjection()
                    stopSelf()
                }
            }, null)

            configureMediaRecorder(request = request)

            virtualDisplay = createVirtualDisplay(request.videoRecordingProps)
            if (virtualDisplay == null) {
                Log.e(TAG, "Failed to create VirtualDisplay")
                stopProjection()
                stopSelf()
                return
            }

            mediaRecorder.start()
            isRecording = true
            Log.d(TAG, "Recording Started Successfully")
        } catch (e: IOException) {
            Log.e(TAG, "IOException during recording setup", e)
            stopProjection()
            stopSelf()
        } catch (e: Exception) {
            Log.e(TAG, "Exception during recording setup", e)
            stopProjection()
            stopSelf()
        }

    }

    private fun createVirtualDisplay(videoProps: VideoRecordingProps): VirtualDisplay? {
        val (width, height) = getScreenSize()
        return mediaProjection?.createVirtualDisplay(
            "Screen",
            videoProps.screenWidth ?: width,
            videoProps.screenHeight ?: height,
            videoProps.dpi,
            videoProps.flag,
            mediaRecorder.surface,
            null,
            null
        )
    }

    fun stopProjection() {
        try {
            if (isRecording) {
                mediaRecorder.apply {
                    try {
                        stop()
                    } catch (e: RuntimeException) {
                        Log.e(TAG, "Error stopping MediaRecorder", e)
                    }
                    reset()
                    release()
                }
                isRecording = false
            }
            virtualDisplay?.release()
            virtualDisplay = null

            mediaProjection?.stop()
            mediaProjection = null
            Log.d(TAG, "Projection stopped successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Error during stopProjection", e)
        }
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID,
            "Screen Recording",
            NotificationManager.IMPORTANCE_LOW
        ).apply {
            description = "Showed when recording is in progress"
        }
        val notificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(channel)
    }

    private fun createNotification(): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Screen Recording")
            .setContentText("Recording in progress...")
            .setSmallIcon(android.R.drawable.ic_media_play)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setOngoing(true)
            .build()
    }


    private fun getTimestamp(): String {
        return LocalDateTime.now().toString().replace(":", "-")
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onDestroy() {
        Log.d(TAG, "Service destroyed")
        stopProjection()
        stopForeground(true)
        super.onDestroy()
    }

    companion object {
        const val START_PROJECTION: String = "start_projection"
        const val STOP_PROJECTION: String = "stop_projection"
        private const val NOTIFICATION_ID = 1
        private const val CHANNEL_ID = "media_projection_channel"
        const val TAG: String = "MediaProjectionService"
    }
}
