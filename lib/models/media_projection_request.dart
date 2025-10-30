import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:media_projection_plugin/enums.dart';

/// Configuration for media projection recording request
class MediaProjectionRequest {
  /// Whether to record audio only (no video)
  final bool audioOnly;

  /// Video recording configuration (ignored if audioOnly is true)
  final VideoRecordingProps videoRecordingProps;

  /// Audio recording configuration
  final AudioRecordingProps audioRecordingProps;

  /// Output directory path (null for cache directory)
  final String? outputPath;

  /// Output file name (null for auto-generated)
  final String? fileName;

  /// Maximum recording duration in milliseconds (null for unlimited)
  final int? maxDurationMs;

  /// Maximum file size in bytes (null for unlimited)
  final int? maxFileSizeBytes;

  MediaProjectionRequest({
    this.audioOnly = false,
    VideoRecordingProps? videoRecordingProps,
    AudioRecordingProps? audioRecordingProps,
    this.outputPath,
    this.fileName,
    this.maxDurationMs,
    this.maxFileSizeBytes,
  }) : videoRecordingProps = videoRecordingProps ?? VideoRecordingProps(),
       audioRecordingProps = audioRecordingProps ?? AudioRecordingProps() {
    // Validate configuration
    _validate();
  }

  void _validate() {
    // Validate file name
    if (fileName != null && fileName!.isEmpty) {
      throw ArgumentError('fileName cannot be empty');
    }

    // Validate duration
    if (maxDurationMs != null && maxDurationMs! <= 0) {
      throw ArgumentError('maxDurationMs must be positive');
    }

    // Validate file size
    if (maxFileSizeBytes != null && maxFileSizeBytes! <= 0) {
      throw ArgumentError('maxFileSizeBytes must be positive');
    }

    // Validate format compatibility
    if (!audioOnly) {
      // Video recording - ensure formats are compatible
      final videoFormat = videoRecordingProps.videoOpFormat;
      final audioFormat = audioRecordingProps.audioOpFormat;

      // They should be the same for video recording
      if (videoFormat != audioFormat) {
        throw ArgumentError(
          'Video and audio output formats must match for video recording. '
          'Got video: ${videoFormat.shortName}, audio: ${audioFormat.shortName}',
        );
      }

      // Ensure format supports video
      if (!videoFormat.supportsVideo) {
        throw ArgumentError(
          'Output format ${videoFormat.shortName} does not support video',
        );
      }
    } else {
      // Audio only - ensure format is audio-capable
      final audioFormat = audioRecordingProps.audioOpFormat;
      if (!audioFormat.isAudioOnly && !audioFormat.supportsVideo) {
        throw ArgumentError(
          'Output format ${audioFormat.shortName} is not suitable for audio recording',
        );
      }
    }
  }

  /// Converts to JSON for platform channel communication
  Map<String, dynamic> toJson() {
    return {
      'audioOnly': audioOnly,
      'videoRecordingProps': videoRecordingProps.toJson(),
      'audioRecordingProps': audioRecordingProps.toJson(),
      'outputPath': outputPath,
      'fileName': fileName,
      'maxDurationMs': maxDurationMs,
      'maxFileSizeBytes': maxFileSizeBytes,
    };
  }

  /// Converts to JSON string
  String toJsonString() => jsonEncode(toJson());

  /// Creates from JSON
  factory MediaProjectionRequest.fromJson(Map<String, dynamic> json) {
    return MediaProjectionRequest(
      audioOnly: json['audioOnly'] as bool? ?? false,
      videoRecordingProps: json['videoRecordingProps'] != null
          ? VideoRecordingProps.fromJson(
              json['videoRecordingProps'] as Map<String, dynamic>,
            )
          : null,
      audioRecordingProps: json['audioRecordingProps'] != null
          ? AudioRecordingProps.fromJson(
              json['audioRecordingProps'] as Map<String, dynamic>,
            )
          : null,
      outputPath: json['outputPath'] as String?,
      fileName: json['fileName'] as String?,
      maxDurationMs: json['maxDurationMs'] as int?,
      maxFileSizeBytes: json['maxFileSizeBytes'] as int?,
    );
  }

  /// Creates from JSON string
  factory MediaProjectionRequest.fromJsonString(String jsonString) {
    return MediaProjectionRequest.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  /// Creates a copy with modified fields
  MediaProjectionRequest copyWith({
    bool? audioOnly,
    VideoRecordingProps? videoRecordingProps,
    AudioRecordingProps? audioRecordingProps,
    String? outputPath,
    String? fileName,
    int? maxDurationMs,
    int? maxFileSizeBytes,
  }) {
    return MediaProjectionRequest(
      audioOnly: audioOnly ?? this.audioOnly,
      videoRecordingProps: videoRecordingProps ?? this.videoRecordingProps,
      audioRecordingProps: audioRecordingProps ?? this.audioRecordingProps,
      outputPath: outputPath ?? this.outputPath,
      fileName: fileName ?? this.fileName,
      maxDurationMs: maxDurationMs ?? this.maxDurationMs,
      maxFileSizeBytes: maxFileSizeBytes ?? this.maxFileSizeBytes,
    );
  }

  @override
  String toString() {
    return 'MediaProjectionRequest('
        'audioOnly: $audioOnly, '
        'videoRecordingProps: $videoRecordingProps, '
        'audioRecordingProps: $audioRecordingProps, '
        'outputPath: $outputPath, '
        'fileName: $fileName, '
        'maxDurationMs: $maxDurationMs, '
        'maxFileSizeBytes: $maxFileSizeBytes)';
  }
}

/// Audio recording configuration
class AudioRecordingProps {
  /// Audio source
  final AudioSource audioSource;

  /// Audio encoder
  final AudioEncoder audioEncoder;

  /// Audio bitrate in bits per second
  final int audioBitrate;

  /// Audio output format
  final OutputFormat audioOpFormat;

  /// Number of audio channels (1 = mono, 2 = stereo)
  final int audioChannels;

  /// Audio sampling rate in Hz
  final int audioSamplingRate;

  AudioRecordingProps({
    this.audioSource = AudioSource.audioSourceDefault,
    this.audioEncoder = AudioEncoder.audioEncoderAac,
    int? audioBitrate,
    this.audioOpFormat = OutputFormat.outputFormatMpeg4,
    this.audioChannels = 2,
    int? audioSamplingRate,
  }) : audioBitrate = audioBitrate ?? audioEncoder.recommendedBitrate,
       audioSamplingRate =
           audioSamplingRate ?? audioEncoder.recommendedSampleRate {
    _validate();
  }

  void _validate() {
    // Validate bitrate
    if (audioBitrate <= 0) {
      throw ArgumentError('audioBitrate must be positive');
    }

    // Validate channels
    if (audioChannels < 1 || audioChannels > 2) {
      throw ArgumentError('audioChannels must be 1 (mono) or 2 (stereo)');
    }

    // Validate sample rate
    if (audioSamplingRate <= 0) {
      throw ArgumentError('audioSamplingRate must be positive');
    }

    // Validate encoder compatibility with format
    if (!audioOpFormat.compatibleAudioEncoders.contains(audioEncoder)) {
      throw ArgumentError(
        'Audio encoder ${audioEncoder.shortName} is not compatible with '
        'output format ${audioOpFormat.shortName}',
      );
    }

    // Check if source is available
    if (audioSource.isSystemOnly) {
      debugPrint(
        'Warning: ${audioSource.displayName} requires system permissions '
        'and may not be available',
      );
    }
  }

  /// Converts to JSON for platform channel communication
  Map<String, dynamic> toJson() {
    return {
      'audioSource': audioSource.val,
      'audioEncoder': audioEncoder.val,
      'audioBitrate': audioBitrate,
      'audioOpFormat': audioOpFormat.val,
      'audioChannels': audioChannels,
      'audioSamplingRate': audioSamplingRate,
    };
  }

  /// Creates from JSON
  factory AudioRecordingProps.fromJson(Map<String, dynamic> json) {
    return AudioRecordingProps(
      audioSource:
          AudioSource.fromValue(json['audioSource'] as int) ??
          AudioSource.audioSourceDefault,
      audioEncoder:
          AudioEncoder.fromValue(json['audioEncoder'] as int) ??
          AudioEncoder.audioEncoderAac,
      audioBitrate: json['audioBitrate'] as int?,
      audioOpFormat:
          OutputFormat.fromValue(json['audioOpFormat'] as int) ??
          OutputFormat.outputFormatMpeg4,
      audioChannels: json['audioChannels'] as int? ?? 2,
      audioSamplingRate: json['audioSamplingRate'] as int?,
    );
  }

  /// Creates a copy with modified fields
  AudioRecordingProps copyWith({
    AudioSource? audioSource,
    AudioEncoder? audioEncoder,
    int? audioBitrate,
    OutputFormat? audioOpFormat,
    int? audioChannels,
    int? audioSamplingRate,
  }) {
    return AudioRecordingProps(
      audioSource: audioSource ?? this.audioSource,
      audioEncoder: audioEncoder ?? this.audioEncoder,
      audioBitrate: audioBitrate ?? this.audioBitrate,
      audioOpFormat: audioOpFormat ?? this.audioOpFormat,
      audioChannels: audioChannels ?? this.audioChannels,
      audioSamplingRate: audioSamplingRate ?? this.audioSamplingRate,
    );
  }

  @override
  String toString() {
    return 'AudioRecordingProps('
        'source: ${audioSource.displayName}, '
        'encoder: ${audioEncoder.shortName}, '
        'bitrate: ${audioBitrate ~/ 1024}kbps, '
        'format: ${audioOpFormat.shortName}, '
        'channels: $audioChannels, '
        'sampleRate: ${audioSamplingRate}Hz)';
  }
}

/// Video recording configuration
class VideoRecordingProps {
  /// Video source
  final VideoSource videoSource;

  /// Video encoder
  final VideoEncoder videoEncoder;

  /// Screen width in pixels (null for auto-detect)
  final int? screenWidth;

  /// Screen height in pixels (null for auto-detect)
  final int? screenHeight;

  /// Video output format
  final OutputFormat videoOpFormat;

  /// Display DPI
  final int dpi;

  /// Video bitrate in bits per second
  final int videoBitrate;

  /// Frames per second
  final int fps;

  /// Virtual display flags
  final DisplayManagerFlags flags;

  VideoRecordingProps({
    this.videoSource = VideoSource.videoSourceSurface,
    this.videoEncoder = VideoEncoder.videoEncoderH264,
    this.screenWidth,
    this.screenHeight,
    this.videoOpFormat = OutputFormat.outputFormatMpeg4,
    this.dpi = 320,
    int? videoBitrate,
    this.fps = 30,
    this.flags = DisplayManagerFlags.virtualDisplayFlagAutoMirror,
  }) : videoBitrate = videoBitrate ?? videoEncoder.typicalBitrate1080p {
    _validate();
  }

  void _validate() {
    // Validate dimensions
    if (screenWidth != null && screenWidth! <= 0) {
      throw ArgumentError('screenWidth must be positive');
    }
    if (screenHeight != null && screenHeight! <= 0) {
      throw ArgumentError('screenHeight must be positive');
    }

    // Validate DPI
    if (dpi <= 0) {
      throw ArgumentError('dpi must be positive');
    }

    // Validate bitrate
    if (videoBitrate <= 0) {
      throw ArgumentError('videoBitrate must be positive');
    }

    // Validate FPS
    if (fps <= 0 || fps > 120) {
      throw ArgumentError('fps must be between 1 and 120');
    }

    // Validate encoder compatibility with format
    if (!videoOpFormat.compatibleVideoEncoders.contains(videoEncoder)) {
      throw ArgumentError(
        'Video encoder ${videoEncoder.shortName} is not compatible with '
        'output format ${videoOpFormat.shortName}',
      );
    }

    // Validate format supports video
    if (!videoOpFormat.supportsVideo) {
      throw ArgumentError(
        'Output format ${videoOpFormat.shortName} does not support video',
      );
    }

    // Check encoder support
    if (videoEncoder.hasLimitedSupport) {
      debugPrint(
        'Warning: ${videoEncoder.displayName} may not be available on all devices',
      );
    }

    // Validate video source for screen recording
    if (!videoSource.isForScreenRecording) {
      debugPrint(
        'Warning: ${videoSource.displayName} is not recommended for screen recording',
      );
    }
  }

  /// Converts to JSON for platform channel communicationx
  Map<String, dynamic> toJson() {
    return {
      'videoSource': videoSource.val,
      'videoEncoder': videoEncoder.val,
      'screenWidth': screenWidth,
      'screenHeight': screenHeight,
      'videoOpFormat': videoOpFormat.val,
      'dpi': dpi,
      'videoBitrate': videoBitrate,
      'fps': fps,
      'flag': flags.val,
    };
  }

  /// Creates from JSON
  factory VideoRecordingProps.fromJson(Map<String, dynamic> json) {
    return VideoRecordingProps(
      videoSource:
          VideoSource.fromValue(json['videoSource'] as int) ??
          VideoSource.videoSourceSurface,
      videoEncoder:
          VideoEncoder.fromValue(json['videoEncoder'] as int) ??
          VideoEncoder.videoEncoderH264,
      screenWidth: json['screenWidth'] as int?,
      screenHeight: json['screenHeight'] as int?,
      videoOpFormat:
          OutputFormat.fromValue(json['videoOpFormat'] as int) ??
          OutputFormat.outputFormatMpeg4,
      dpi: json['dpi'] as int? ?? 320,
      videoBitrate: json['videoBitrate'] as int?,
      fps: json['fps'] as int? ?? 30,
      flags:
          DisplayManagerFlags.fromValue(json['flag'] as int) ??
          DisplayManagerFlags.virtualDisplayFlagAutoMirror,
    );
  }

  /// Creates a copy with modified fields
  VideoRecordingProps copyWith({
    VideoSource? videoSource,
    VideoEncoder? videoEncoder,
    int? screenWidth,
    int? screenHeight,
    OutputFormat? videoOpFormat,
    int? dpi,
    int? videoBitrate,
    int? fps,
    DisplayManagerFlags? flags,
  }) {
    return VideoRecordingProps(
      videoSource: videoSource ?? this.videoSource,
      videoEncoder: videoEncoder ?? this.videoEncoder,
      screenWidth: screenWidth ?? this.screenWidth,
      screenHeight: screenHeight ?? this.screenHeight,
      videoOpFormat: videoOpFormat ?? this.videoOpFormat,
      dpi: dpi ?? this.dpi,
      videoBitrate: videoBitrate ?? this.videoBitrate,
      fps: fps ?? this.fps,
      flags: flags ?? this.flags,
    );
  }

  @override
  String toString() {
    return 'VideoRecordingProps('
        'source: ${videoSource.shortName}, '
        'encoder: ${videoEncoder.shortName}, '
        'resolution: ${screenWidth ?? "auto"}x${screenHeight ?? "auto"}, '
        'format: ${videoOpFormat.shortName}, '
        'bitrate: ${videoBitrate ~/ 1024 ~/ 1024}Mbps, '
        'fps: $fps, '
        'dpi: $dpi)';
  }
}
