package com.example.media_projection_plugin

import android.hardware.display.DisplayManager
import android.media.MediaRecorder
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

@OptIn(InternalSerializationApi::class)
@Serializable
data class MediaProjectionRequest(
    val audioOnly: Boolean = false,
    val videoRecordingProps: VideoRecordingProps = VideoRecordingProps(),
    val audioRecordingProps: AudioRecordingProps = AudioRecordingProps(),
    val outputPath: String? = null,
    val fileName: String? = null,
    val maxDurationMs: Int? = null,
    val maxFileSizeBytes: Long? = null,
) {
    companion object {
        fun fromJson(json: String): MediaProjectionRequest {
            return Json.decodeFromString(json)
        }
    }
}
@OptIn(InternalSerializationApi::class)
@Serializable
data class VideoRecordingProps(
    val videoSource: Int = MediaRecorder.VideoSource.SURFACE,
    val videoEncoder: Int = MediaRecorder.VideoEncoder.DEFAULT,
    val screenWidth: Int? = null,
    val screenHeight: Int? = null,
    val videoOpFormat: Int = MediaRecorder.OutputFormat.MPEG_4,
    val dpi: Int = 320,
    val videoBitrate: Int = 6 * 1024 * 1024, // 6 Mbps
    val fps: Int = 30,
    val flag: Int = DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR
){
    companion object {
        @OptIn(InternalSerializationApi::class)
        fun fromJson(json: String): VideoRecordingProps {
            return Json.decodeFromString(json)
        }
    }
}
@OptIn(InternalSerializationApi::class)
@Serializable
data class AudioRecordingProps(
    val audioSource: Int = MediaRecorder.AudioSource.DEFAULT,
    val audioEncoder: Int = MediaRecorder.AudioEncoder.DEFAULT,
    val audioBitrate: Int = 128 * 1024, // 128 kbps
    val audioOpFormat: Int = MediaRecorder.OutputFormat.AAC_ADTS,
    val audioChannels: Int = 1,
    val audioSamplingRate: Int = 44100, // 44.1 kHz
){
    companion object {
        @OptIn(InternalSerializationApi::class)
        fun fromJson(json: String): AudioRecordingProps {
            return Json.decodeFromString(json)
        }
    }

}