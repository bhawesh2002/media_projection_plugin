package com.example.media_projection_plugin

import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Rect
import android.hardware.display.VirtualDisplay
import android.media.MediaRecorder
import android.media.projection.MediaProjection
import android.os.Build
import android.os.IBinder
import android.util.DisplayMetrics
import android.view.WindowManager
import java.io.File
import java.time.LocalDateTime

class MediaProjectionService : Service() {

    private var mediaProjection: MediaProjection? = null
    private var mediaRecorder: MediaRecorder? = null
    private var virtualDisplay: VirtualDisplay? = null

    override fun onBind(intent: Intent?): IBinder? {
        TODO()
    }

    private fun getScreenSize(): Pair<Int, Int> {
        val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
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
        mediaRecorder?.apply {
            setAudioSource(request.audioRecordingProps.audioSource)
            setVideoSource(request.videoRecordingProps.videoSource)
            setOutputFormat(if (request.audioOnly) request.audioRecordingProps.audioOpFormat else request.videoRecordingProps.videoOpFormat)

            val screenSize by lazy { getScreenSize() }
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

            setOutputFile(
                File(
                    cacheDir,
                    request.fileName ?: "output_${LocalDateTime.now()}.mp4"
                )
            )

            request.maxDurationMs?.let { setMaxDuration(it) }
            request.maxFileSizeBytes?.let { setMaxFileSize(it) }

            try {
                prepare()
            } catch (e: Exception) {
                throw e
            }
        }
    }

    fun startProjection(request: MediaProjectionRequest) {
        // It's important to create a new MediaRecorder instance here
        mediaRecorder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            MediaRecorder(this)
        } else {
            @Suppress("DEPRECATION")
            MediaRecorder()
        }

        configureMediaRecorder(request = request)
        mediaRecorder?.start()
    }

    fun stopProjection() {
        mediaRecorder?.stop()
        mediaRecorder?.release()
        mediaRecorder = null
        mediaProjection?.stop()
        mediaProjection = null
        virtualDisplay?.release()
        virtualDisplay = null
    }
}
