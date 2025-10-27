package com.example.media_projection_plugin

import android.media.MediaRecorder
import android.media.projection.MediaProjection

/**
 * @param audioOnly If `true`  MediaProjection will capture audio only. Enabling will ignore the `videoRecordingProps`.
 */
class MediaProjectionRequest(
    val audioOnly: Boolean = false,
    val videoRecordingProps: VideoRecordingProps = VideoRecordingProps(),
    val audioRecordingProps: AudioRecordingProps = AudioRecordingProps(),
    var outputPath: String?,
    val fileName: String?,
    val exitCallback: MediaProjection.Callback?,
    val maxDurationMs: Int?,
    val maxFileSizeBytes: Long?,
)


class VideoRecordingProps(
    val videoSource: Int = MediaRecorder.VideoSource.SURFACE,
    val videoEncoder: Int = MediaRecorder.VideoEncoder.DEFAULT,
    var screenWidth: Int? = null,
    var screenHeight: Int? = null,
    val videoOpFormat: Int = MediaRecorder.OutputFormat.MPEG_4,
    val dpi: Int = 320,
    val videoBitrate: Int = 6 * 1024 * 1024, // 6 Mbps
    val fps: Int = 30,
)

class AudioRecordingProps(
    val audioSource: Int = MediaRecorder.AudioSource.DEFAULT,
    val audioEncoder: Int = MediaRecorder.AudioEncoder.DEFAULT,
    val audioBitrate: Int = 128 * 1024, // 128 kbps
    val audioOpFormat: Int = MediaRecorder.OutputFormat.AAC_ADTS,
    val audioChannels: Int = 1,
    val audioSamplingRate: Int = 44100, // 44.1 kHz
)
