package com.example.media_projection_plugin

import kotlin.time.Duration
import android.media.MediaRecorder
import android.media.projection.MediaProjection
import java.io.File

/**
 * @param audioOnly If `true`  MediaProjecton will capture audio only. Enabling will ignore the `videoRecordingProps`.
 */
class MediaProjectionRequest(
    val audioOnly: Boolean = false,
    val videoRecordingProps:VideoRecordingProps  = VideoRecordingProps(),
    val audioRecordingProps: AudioRecordingProps = AudioRecordingProps(),
    var outputPath: String?,
    val fileName: String?,
    val exitCallback: MediaProjection.Callback?,
    val stopDuration: Duration,
)


class VideoRecordingProps(
    val videoSource: Int = MediaRecorder.VideoSource.SURFACE,
    val videoEncoder: Int = MediaRecorder.VideoEncoder.DEFAULT,
    var screenWidth: Int? = null,
    var screenHeight: Int? = null,
    val videoOpFormat: Int = MediaRecorder.OutputFormat.MPEG_4,
    val dpi: Int = 320,
    val videoBitrate: Int = 320,
)

class AudioRecordingProps(
    val audioSource: Int = MediaRecorder.AudioSource.DEFAULT,
    val audioEncoder: Int = MediaRecorder.AudioEncoder.DEFAULT,
    val audioBitrate: Int = 320,
    val audioOpFormat: Int = MediaRecorder.OutputFormat.AAC_ADTS,
)