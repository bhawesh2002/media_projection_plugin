library;
// ignore_for_file: deprecated_member_use_from_same_package

enum VideoEncoder {
  /// Default video encoder
  ///
  /// This is the default video encoder that will be selected by the system.
  videoEncoderDefault(0),

  /// H.263 video codec
  ///
  /// An older video compression standard, part of the MPEG-4 family.
  /// **Note:** This codec is considered legacy and is rarely used in modern applications.
  /// Resolution: Up to CIF (352×288)
  /// Bit rate: Low (typically < 1 Mbps)
  /// Use case: Legacy compatibility, very low bitrate applications
  videoEncoderH263(1),

  /// H.264/AVC (Advanced Video Coding) video codec
  ///
  /// The most widely supported and commonly used video codec.
  /// Also known as MPEG-4 Part 10 or AVC.
  /// Provides excellent quality-to-compression ratio and broad compatibility.
  /// Resolution: SD to 4K
  /// Bit rate: 1-50 Mbps (varies by resolution)
  /// Use case: Universal video encoding, streaming, recording, most compatible option
  videoEncoderH264(2),

  /// MPEG-4 SP (Simple Profile) video codec
  ///
  /// MPEG-4 Part 2 Simple Profile, an older codec superseded by H.264.
  /// **Note:** This codec is considered legacy.
  /// Resolution: SD
  /// Bit rate: Low to medium
  /// Use case: Legacy compatibility
  videoEncoderMpeg4Sp(3),

  /// VP8 video codec
  ///
  /// Open-source video codec developed by Google.
  /// Part of the WebM container format.
  /// Resolution: SD to Full HD
  /// Bit rate: 1-20 Mbps
  /// Use case: Web streaming, open-source projects, WebRTC
  videoEncoderVp8(4),

  /// HEVC/H.265 (High Efficiency Video Coding) video codec
  ///
  /// Successor to H.264, provides better compression (50% smaller files at same quality).
  /// Also known as MPEG-H Part 2 or H.265.
  /// **Note:** Not all devices support HEVC encoding. Check device capabilities.
  /// Resolution: HD to 8K
  /// Bit rate: 0.5-100 Mbps (50% less than H.264 for same quality)
  /// Use case: 4K/8K video, modern devices, storage-efficient recording
  videoEncoderHevc(5),

  /// VP9 video codec
  ///
  /// Open-source successor to VP8, developed by Google.
  /// Provides better compression than VP8 and comparable to HEVC.
  /// Part of the WebM container format.
  /// **Note:** Support varies by device.
  /// Resolution: HD to 8K
  /// Bit rate: Similar to HEVC
  /// Use case: YouTube, web streaming, open-source projects
  videoEncoderVp9(6),

  /// Dolby Vision video codec
  ///
  /// HDR (High Dynamic Range) video format with enhanced color and brightness.
  /// Proprietary format by Dolby Laboratories.
  /// **Note:** Requires special hardware support, rarely available for encoding.
  /// Use case: Professional HDR video production, premium content
  videoEncoderDolbyVision(7),

  /// AV1 video codec
  ///
  /// Modern, royalty-free video codec developed by Alliance for Open Media.
  /// Provides better compression than HEVC/VP9 (30% improvement).
  /// **Note:** Hardware encoding support is limited on most devices as of 2024.
  /// Resolution: HD to 8K
  /// Bit rate: 30% less than HEVC for same quality
  /// Use case: Future-proof encoding, streaming platforms, open-source projects
  videoEncoderAv1(8);

  /// Creates a VideoEncoder enum with the specified value
  const VideoEncoder(this.val);

  /// The integer value of this video encoder
  final int val;

  /// Returns the VideoEncoder enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known video encoder.
  ///
  /// Example:
  /// ```dart
  /// final encoder = VideoEncoder.fromValue(2);
  /// print(encoder?.name); // videoEncoderH264
  /// ```
  static VideoEncoder? fromValue(int value) {
    try {
      return VideoEncoder.values.firstWhere((encoder) => encoder.val == value);
    } catch (e) {
      return null;
    }
  }

  /// Returns a human-readable description of the video encoder
  ///
  /// Example:
  /// ```dart
  /// print(VideoEncoder.videoEncoderH264.description);
  /// // Output: "H264"
  /// ```
  String get description {
    return name
        .replaceAll('videoEncoder', '')
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns the video encoder name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(VideoEncoder.videoEncoderHevc.toUpperSnakeCase());
  /// // Output: "VIDEO_ENCODER_HEVC"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns a user-friendly display name for the video encoder
  ///
  /// Example:
  /// ```dart
  /// print(VideoEncoder.videoEncoderH264.displayName);
  /// // Output: "H.264 (AVC)"
  /// ```
  String get displayName {
    switch (this) {
      case VideoEncoder.videoEncoderDefault:
        return 'Default';
      case VideoEncoder.videoEncoderH263:
        return 'H.263';
      case VideoEncoder.videoEncoderH264:
        return 'H.264 (AVC)';
      case VideoEncoder.videoEncoderMpeg4Sp:
        return 'MPEG-4 SP';
      case VideoEncoder.videoEncoderVp8:
        return 'VP8';
      case VideoEncoder.videoEncoderHevc:
        return 'H.265 (HEVC)';
      case VideoEncoder.videoEncoderVp9:
        return 'VP9';
      case VideoEncoder.videoEncoderDolbyVision:
        return 'Dolby Vision';
      case VideoEncoder.videoEncoderAv1:
        return 'AV1';
    }
  }

  /// Returns a short display name for the video encoder
  ///
  /// Example:
  /// ```dart
  /// print(VideoEncoder.videoEncoderH264.shortName);
  /// // Output: "H.264"
  /// ```
  String get shortName {
    switch (this) {
      case VideoEncoder.videoEncoderDefault:
        return 'Default';
      case VideoEncoder.videoEncoderH263:
        return 'H.263';
      case VideoEncoder.videoEncoderH264:
        return 'H.264';
      case VideoEncoder.videoEncoderMpeg4Sp:
        return 'MPEG-4';
      case VideoEncoder.videoEncoderVp8:
        return 'VP8';
      case VideoEncoder.videoEncoderHevc:
        return 'H.265';
      case VideoEncoder.videoEncoderVp9:
        return 'VP9';
      case VideoEncoder.videoEncoderDolbyVision:
        return 'Dolby Vision';
      case VideoEncoder.videoEncoderAv1:
        return 'AV1';
    }
  }

  /// Checks if this encoder is widely supported across devices
  ///
  /// Example:
  /// ```dart
  /// if (VideoEncoder.videoEncoderH264.isWidelySupported) {
  ///   print('This encoder works on almost all devices');
  /// }
  /// ```
  bool get isWidelySupported {
    return this == VideoEncoder.videoEncoderH264 ||
        this == VideoEncoder.videoEncoderDefault;
  }

  /// Checks if this encoder is considered legacy/deprecated
  ///
  /// Example:
  /// ```dart
  /// if (VideoEncoder.videoEncoderH263.isLegacy) {
  ///   print('Consider using a modern encoder');
  /// }
  /// ```
  bool get isLegacy {
    return this == VideoEncoder.videoEncoderH263 ||
        this == VideoEncoder.videoEncoderMpeg4Sp;
  }

  /// Checks if this encoder is modern and efficient
  ///
  /// Example:
  /// ```dart
  /// if (VideoEncoder.videoEncoderHevc.isModern) {
  ///   print('This encoder provides excellent compression');
  /// }
  /// ```
  bool get isModern {
    return this == VideoEncoder.videoEncoderHevc ||
        this == VideoEncoder.videoEncoderVp9 ||
        this == VideoEncoder.videoEncoderAv1;
  }

  /// Checks if this encoder is open-source/royalty-free
  ///
  /// Example:
  /// ```dart
  /// if (VideoEncoder.videoEncoderVp8.isOpenSource) {
  ///   print('This encoder has no licensing fees');
  /// }
  /// ```
  bool get isOpenSource {
    return this == VideoEncoder.videoEncoderVp8 ||
        this == VideoEncoder.videoEncoderVp9 ||
        this == VideoEncoder.videoEncoderAv1;
  }

  /// Checks if this encoder may have limited device support
  ///
  /// Example:
  /// ```dart
  /// if (VideoEncoder.videoEncoderHevc.hasLimitedSupport) {
  ///   print('Check device capabilities before using');
  /// }
  /// ```
  bool get hasLimitedSupport {
    return this == VideoEncoder.videoEncoderHevc ||
        this == VideoEncoder.videoEncoderVp9 ||
        this == VideoEncoder.videoEncoderDolbyVision ||
        this == VideoEncoder.videoEncoderAv1;
  }

  /// Returns typical bitrate for 1080p recording in bps
  ///
  /// Example:
  /// ```dart
  /// final bitrate = VideoEncoder.videoEncoderH264.typicalBitrate1080p;
  /// print('Recommended 1080p bitrate: ${bitrate / 1000000} Mbps');
  /// ```
  int get typicalBitrate1080p {
    switch (this) {
      case VideoEncoder.videoEncoderDefault:
        return 6 * 1024 * 1024; // 6 Mbps
      case VideoEncoder.videoEncoderH263:
        return 1 * 1024 * 1024; // 1 Mbps (not typically used for HD)
      case VideoEncoder.videoEncoderH264:
        return 6 * 1024 * 1024; // 6 Mbps
      case VideoEncoder.videoEncoderMpeg4Sp:
        return 2 * 1024 * 1024; // 2 Mbps (not typically used for HD)
      case VideoEncoder.videoEncoderVp8:
        return 6 * 1024 * 1024; // 6 Mbps
      case VideoEncoder.videoEncoderHevc:
        return 3 * 1024 * 1024; // 3 Mbps (better compression)
      case VideoEncoder.videoEncoderVp9:
        return 3 * 1024 * 1024; // 3 Mbps (better compression)
      case VideoEncoder.videoEncoderDolbyVision:
        return 10 * 1024 * 1024; // 10 Mbps
      case VideoEncoder.videoEncoderAv1:
        return 2 * 1024 * 1024; // 2 Mbps (best compression)
    }
  }

  /// Returns recommended encoders sorted by preference
  static List<VideoEncoder> getRecommendedEncoders() {
    return [
      VideoEncoder.videoEncoderH264, // Most compatible
      VideoEncoder.videoEncoderHevc, // Better compression
      VideoEncoder.videoEncoderVp9, // Open source alternative
      VideoEncoder.videoEncoderDefault,
    ];
  }

  /// Returns modern, high-efficiency encoders
  static List<VideoEncoder> getModernEncoders() {
    return VideoEncoder.values.where((e) => e.isModern).toList();
  }

  /// Returns open-source/royalty-free encoders
  static List<VideoEncoder> getOpenSourceEncoders() {
    return VideoEncoder.values.where((e) => e.isOpenSource).toList();
  }
}

/// Video source types for MediaRecorder in Android
enum VideoSource {
  /// Default video source
  ///
  /// This is the default video source that will be selected by the system.
  videoSourceDefault(0),

  /// Camera video source
  ///
  /// Using the deprecated `android.hardware.Camera` API as video source.
  ///
  /// **Note:** This uses the old Camera API (Camera1) which is deprecated.
  /// For new applications using Camera2 API, use [videoSourceSurface] instead.
  ///
  /// Use case: Legacy applications, compatibility with old Camera API
  videoSourceCamera(1),

  /// Surface video source
  ///
  /// Using a Surface as video source.
  ///
  /// This flag **must** be used when recording from an
  /// `android.hardware.camera2` API source or when using MediaProjection
  /// for screen recording.
  ///
  /// When using this video source type, use `MediaRecorder.getSurface()`
  /// to retrieve the surface created by MediaRecorder, then provide this
  /// surface to the video producer (Camera2, MediaProjection, etc.).
  ///
  /// Use case:
  /// - Screen recording with MediaProjection (most common for screen capture)
  /// - Camera recording with Camera2 API (modern camera apps)
  /// - Custom video sources that can render to a Surface
  videoSourceSurface(2);

  /// Creates a VideoSource enum with the specified value
  const VideoSource(this.val);

  /// The integer value of this video source
  final int val;

  /// Returns the VideoSource enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known video source.
  ///
  /// Example:
  /// ```dart
  /// final source = VideoSource.fromValue(2);
  /// print(source?.name); // videoSourceSurface
  /// ```
  static VideoSource? fromValue(int value) {
    try {
      return VideoSource.values.firstWhere((source) => source.val == value);
    } catch (e) {
      return null;
    }
  }

  /// Returns a human-readable description of the video source
  ///
  /// Example:
  /// ```dart
  /// print(VideoSource.videoSourceSurface.description);
  /// // Output: "SURFACE"
  /// ```
  String get description {
    return name
        .replaceAll('videoSource', '')
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns the video source name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(VideoSource.videoSourceSurface.toUpperSnakeCase());
  /// // Output: "VIDEO_SOURCE_SURFACE"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns a user-friendly display name for the video source
  ///
  /// Example:
  /// ```dart
  /// print(VideoSource.videoSourceSurface.displayName);
  /// // Output: "Surface (Screen/Camera2)"
  /// ```
  String get displayName {
    switch (this) {
      case VideoSource.videoSourceDefault:
        return 'Default';
      case VideoSource.videoSourceCamera:
        return 'Camera (Legacy)';
      case VideoSource.videoSourceSurface:
        return 'Surface (Screen/Camera2)';
    }
  }

  /// Returns a short display name for the video source
  ///
  /// Example:
  /// ```dart
  /// print(VideoSource.videoSourceSurface.shortName);
  /// // Output: "Surface"
  /// ```
  String get shortName {
    switch (this) {
      case VideoSource.videoSourceDefault:
        return 'Default';
      case VideoSource.videoSourceCamera:
        return 'Camera';
      case VideoSource.videoSourceSurface:
        return 'Surface';
    }
  }

  /// Checks if this video source is deprecated
  ///
  /// Example:
  /// ```dart
  /// if (VideoSource.videoSourceCamera.isDeprecated) {
  ///   print('Consider using Surface instead');
  /// }
  /// ```
  bool get isDeprecated {
    return this == VideoSource.videoSourceCamera;
  }

  /// Checks if this video source is recommended for modern applications
  ///
  /// Example:
  /// ```dart
  /// if (VideoSource.videoSourceSurface.isRecommended) {
  ///   print('This is the preferred video source');
  /// }
  /// ```
  bool get isRecommended {
    return this == VideoSource.videoSourceSurface;
  }

  /// Checks if this video source is suitable for screen recording
  ///
  /// Example:
  /// ```dart
  /// if (VideoSource.videoSourceSurface.isForScreenRecording) {
  ///   print('Use this for MediaProjection screen capture');
  /// }
  /// ```
  bool get isForScreenRecording {
    return this == VideoSource.videoSourceSurface;
  }

  /// Checks if this video source is suitable for Camera2 API
  ///
  /// Example:
  /// ```dart
  /// if (VideoSource.videoSourceSurface.isForCamera2) {
  ///   print('Use this with Camera2 API');
  /// }
  /// ```
  bool get isForCamera2 {
    return this == VideoSource.videoSourceSurface;
  }
}

/// Audio source types for MediaRecorder in Android
enum AudioSource {
  /// Default audio source
  ///
  /// This is the default audio source that can be used for general audio recording.
  audioSourceDefault(0),

  /// Microphone audio source
  ///
  /// This source captures audio from the device's microphone.
  audioSourceMic(1),

  /// Voice call uplink (Tx) audio source.
  ///
  /// Capturing from `VOICE_UPLINK` source requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  audioSourceVoiceUplink(2),

  /// Voice call downlink (Rx) audio source.
  ///
  /// Capturing from `VOICE_DOWNLINK` source requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  audioSourceVoiceDownlink(3),

  /// Voice call uplink + downlink audio source
  ///
  /// Capturing from `VOICE_CALL` source requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  audioSourceVoiceCall(4),

  /// Microphone audio source tuned for video recording, with the same orientation
  /// as the camera if available.
  ///
  /// This source is optimized for recording audio along with video capture.
  audioSourceCamcorder(5),

  /// Microphone audio source tuned for voice recognition.
  ///
  /// This source is optimized for speech recognition applications.
  audioSourceVoiceRecognition(6),

  /// Microphone audio source tuned for voice communications such as VoIP.
  ///
  /// It will for instance take advantage of echo cancellation or automatic gain control
  /// if available.
  audioSourceVoiceCommunication(7),

  /// Audio source for a submix of audio streams to be presented remotely.
  ///
  /// An application can use this audio source to capture a mix of audio streams
  /// that should be transmitted to a remote receiver such as a Wifi display.
  /// While recording is active, these audio streams are redirected to the remote
  /// submix instead of being played on the device speaker or headset.
  ///
  /// Certain streams are excluded from the remote submix, including
  /// `STREAM_RING`, `STREAM_ALARM`, and `STREAM_NOTIFICATION`.
  /// These streams will continue to be presented locally as usual.
  ///
  /// Capturing the remote submix audio requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  audioSourceRemoteSubmix(8),

  /// Microphone audio source tuned for unprocessed (raw) sound if available,
  /// behaves like [audioSourceDefault] otherwise.
  ///
  /// This source provides raw, unprocessed audio data when available.
  audioSourceUnprocessed(9),

  /// Source for capturing audio meant to be processed in real time and played back
  /// for live performance (e.g. karaoke).
  ///
  /// The capture path will minimize latency and coupling with playback path.
  audioSourceVoicePerformance(10),

  /// Source for an echo canceller to capture the reference signal to be cancelled.
  ///
  /// The echo reference signal will be captured as close as possible to the DAC in order
  /// to include all post processing applied to the playback path.
  ///
  /// Capturing the echo reference requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  ///
  /// **Note:** This is a system API and not available to third-party applications.
  audioSourceEchoReference(1997),

  /// Audio source for capturing broadcast radio tuner output.
  ///
  /// Capturing the radio tuner output requires the
  /// `android.Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  ///
  /// **Note:** This is a system API and not available to third-party applications.
  audioSourceRadioTuner(1998),

  /// Audio source for preemptible, low-priority software hotword detection.
  ///
  /// It presents the same gain and pre-processing tuning as [audioSourceVoiceRecognition].
  ///
  /// An application should use this audio source when it wishes to do
  /// always-on software hotword detection, while gracefully giving in to any other application
  /// that might want to read from the microphone.
  ///
  /// Requires the `android.Manifest.permission.CAPTURE_AUDIO_HOTWORD` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  ///
  /// **Note:** This is a system API and not available to third-party applications.
  audioSourceHotword(1999),

  /// Microphone audio source for ultrasound sound if available,
  /// behaves like [audioSourceDefault] otherwise.
  ///
  /// Requires the `android.Manifest.permission.ACCESS_ULTRASOUND` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  ///
  /// **Note:** This is a system API and not available to third-party applications.
  audioSourceUltrasound(2000);

  /// Creates an AudioSource enum with the specified value
  const AudioSource(this.val);

  /// The integer value of this audio source
  final int val;

  /// Invalid audio source constant
  static const int audioSourceInvalid = -1;

  /// Returns the AudioSource enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known audio source.
  ///
  /// Example:
  /// ```dart
  /// final source = AudioSource.fromValue(1);
  /// print(source?.name); // audioSourceMic
  /// ```
  static AudioSource? fromValue(int value) {
    try {
      return AudioSource.values.firstWhere((source) => source.val == value);
    } catch (e) {
      return null;
    }
  }

  /// Checks if this audio source is a system-only source that requires
  /// special permissions not available to third-party apps
  ///
  /// Example:
  /// ```dart
  /// if (AudioSource.audioSourceVoiceCall.isSystemOnly) {
  ///   print('This source requires system permissions');
  /// }
  /// ```
  bool get isSystemOnly {
    return this == AudioSource.audioSourceVoiceUplink ||
        this == AudioSource.audioSourceVoiceDownlink ||
        this == AudioSource.audioSourceVoiceCall ||
        this == AudioSource.audioSourceRemoteSubmix ||
        this == AudioSource.audioSourceEchoReference ||
        this == AudioSource.audioSourceRadioTuner ||
        this == AudioSource.audioSourceHotword ||
        this == AudioSource.audioSourceUltrasound;
  }

  /// Checks if this audio source is available for third-party applications
  ///
  /// Example:
  /// ```dart
  /// final availableSources = AudioSource.values
  ///     .where((source) => source.isAvailableForThirdParty)
  ///     .toList();
  /// ```
  bool get isAvailableForThirdParty => !isSystemOnly;

  /// Returns a human-readable description of the audio source
  ///
  /// Example:
  /// ```dart
  /// print(AudioSource.audioSourceMic.description);
  /// // Output: "MIC"
  /// ```
  String get description {
    return name
        .replaceAll('audioSource', '')
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns the audio source name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(AudioSource.audioSourceVoiceCommunication.toUpperSnakeCase());
  /// // Output: "AUDIO_SOURCE_VOICE_COMMUNICATION"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns all audio sources that are available for third-party applications
  ///
  /// Example:
  /// ```dart
  /// final availableSources = AudioSource.getAvailableSources();
  /// print('Available sources: ${availableSources.length}');
  /// ```
  static List<AudioSource> getAvailableSources() {
    return AudioSource.values
        .where((source) => source.isAvailableForThirdParty)
        .toList();
  }

  /// Returns all audio sources that require system permissions
  ///
  /// Example:
  /// ```dart
  /// final systemSources = AudioSource.getSystemOnlySources();
  /// ```
  static List<AudioSource> getSystemOnlySources() {
    return AudioSource.values.where((source) => source.isSystemOnly).toList();
  }

  /// Returns a user-friendly display name for the audio source
  ///
  /// Example:
  /// ```dart
  /// print(AudioSource.audioSourceMic.displayName);
  /// // Output: "Microphone"
  /// ```
  String get displayName {
    switch (this) {
      case AudioSource.audioSourceDefault:
        return 'Default';
      case AudioSource.audioSourceMic:
        return 'Microphone';
      case AudioSource.audioSourceVoiceUplink:
        return 'Voice Call Uplink';
      case AudioSource.audioSourceVoiceDownlink:
        return 'Voice Call Downlink';
      case AudioSource.audioSourceVoiceCall:
        return 'Voice Call';
      case AudioSource.audioSourceCamcorder:
        return 'Camcorder';
      case AudioSource.audioSourceVoiceRecognition:
        return 'Voice Recognition';
      case AudioSource.audioSourceVoiceCommunication:
        return 'Voice Communication';
      case AudioSource.audioSourceRemoteSubmix:
        return 'Remote Submix';
      case AudioSource.audioSourceUnprocessed:
        return 'Unprocessed';
      case AudioSource.audioSourceVoicePerformance:
        return 'Voice Performance';
      case AudioSource.audioSourceEchoReference:
        return 'Echo Reference';
      case AudioSource.audioSourceRadioTuner:
        return 'Radio Tuner';
      case AudioSource.audioSourceHotword:
        return 'Hotword Detection';
      case AudioSource.audioSourceUltrasound:
        return 'Ultrasound';
    }
  }
}

/// Audio encoder types for MediaRecorder in Android
enum AudioEncoder {
  /// Default audio encoder
  ///
  /// This is the default audio encoder that will be selected by the system.
  audioEncoderDefault(0),

  /// AMR (Narrowband) audio codec
  ///
  /// Adaptive Multi-Rate narrowband codec, typically used for speech encoding.
  /// Sample rate: 8 kHz
  /// Bit rate: 4.75-12.2 kbps
  /// Use case: Voice recording, phone calls
  audioEncoderAmrNb(1),

  /// AMR (Wideband) audio codec
  ///
  /// Adaptive Multi-Rate wideband codec, provides better quality than AMR-NB.
  /// Sample rate: 16 kHz
  /// Bit rate: 6.6-23.85 kbps
  /// Use case: Higher quality voice recording
  audioEncoderAmrWb(2),

  /// AAC Low Complexity (AAC-LC) audio codec
  ///
  /// Advanced Audio Coding - Low Complexity profile.
  /// This is the most common AAC profile and provides good quality at moderate bitrates.
  /// Sample rate: 8-96 kHz (typically 44.1 or 48 kHz)
  /// Bit rate: 64-320 kbps (typically 128-192 kbps)
  /// Use case: Music, high-quality audio recording, video soundtracks
  audioEncoderAac(3),

  /// High Efficiency AAC (HE-AAC) audio codec
  ///
  /// Also known as AAC+, provides better quality than AAC-LC at low bitrates.
  /// Uses Spectral Band Replication (SBR) for efficiency.
  /// Sample rate: 16-48 kHz
  /// Bit rate: 16-128 kbps
  /// Use case: Streaming audio, low-bitrate applications
  audioEncoderHeAac(4),

  /// Enhanced Low Delay AAC (AAC-ELD) audio codec
  ///
  /// Optimized for low-delay, real-time communication.
  /// Sample rate: 16-48 kHz
  /// Bit rate: 16-320 kbps
  /// Use case: VoIP, video conferencing, real-time communication
  audioEncoderAacEld(5),

  /// Ogg Vorbis audio codec
  ///
  /// Open-source, patent-free audio codec.
  /// **Note:** Support is optional and may not be available on all devices.
  /// Sample rate: 8-192 kHz (typically 44.1 or 48 kHz)
  /// Bit rate: 45-500 kbps (variable bitrate)
  /// Use case: Open-source projects, gaming audio
  audioEncoderVorbis(6),

  /// Opus audio codec
  ///
  /// Modern, versatile audio codec that works well across a wide range of bitrates.
  /// Standardized by IETF (RFC 6716).
  /// Sample rate: 8-48 kHz (internally 48 kHz)
  /// Bit rate: 6-510 kbps (adaptive)
  /// Use case: VoIP, streaming, music, universal audio encoding
  audioEncoderOpus(7);

  /// Creates an AudioEncoder enum with the specified value
  const AudioEncoder(this.val);

  /// The integer value of this audio encoder
  final int val;

  /// Returns the AudioEncoder enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known audio encoder.
  ///
  /// Example:
  /// ```dart
  /// final encoder = AudioEncoder.fromValue(3);
  /// print(encoder?.name); // audioEncoderAac
  /// ```
  static AudioEncoder? fromValue(int value) {
    try {
      return AudioEncoder.values.firstWhere((encoder) => encoder.val == value);
    } catch (e) {
      return null;
    }
  }

  /// Returns a human-readable description of the audio encoder
  ///
  /// Example:
  /// ```dart
  /// print(AudioEncoder.audioEncoderAac.description);
  /// // Output: "AAC"
  /// ```
  String get description {
    return name
        .replaceAll('audioEncoder', '')
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns the audio encoder name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(AudioEncoder.audioEncoderAacEld.toUpperSnakeCase());
  /// // Output: "AUDIO_ENCODER_AAC_ELD"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns a user-friendly display name for the audio encoder
  ///
  /// Example:
  /// ```dart
  /// print(AudioEncoder.audioEncoderAac.displayName);
  /// // Output: "AAC (Advanced Audio Coding)"
  /// ```
  String get displayName {
    switch (this) {
      case AudioEncoder.audioEncoderDefault:
        return 'Default';
      case AudioEncoder.audioEncoderAmrNb:
        return 'AMR-NB (Narrowband)';
      case AudioEncoder.audioEncoderAmrWb:
        return 'AMR-WB (Wideband)';
      case AudioEncoder.audioEncoderAac:
        return 'AAC (Advanced Audio Coding)';
      case AudioEncoder.audioEncoderHeAac:
        return 'HE-AAC (High Efficiency AAC)';
      case AudioEncoder.audioEncoderAacEld:
        return 'AAC-ELD (Enhanced Low Delay)';
      case AudioEncoder.audioEncoderVorbis:
        return 'Vorbis';
      case AudioEncoder.audioEncoderOpus:
        return 'Opus';
    }
  }

  /// Returns a short display name for the audio encoder
  ///
  /// Example:
  /// ```dart
  /// print(AudioEncoder.audioEncoderAac.shortName);
  /// // Output: "AAC"
  /// ```
  String get shortName {
    switch (this) {
      case AudioEncoder.audioEncoderDefault:
        return 'Default';
      case AudioEncoder.audioEncoderAmrNb:
        return 'AMR-NB';
      case AudioEncoder.audioEncoderAmrWb:
        return 'AMR-WB';
      case AudioEncoder.audioEncoderAac:
        return 'AAC';
      case AudioEncoder.audioEncoderHeAac:
        return 'HE-AAC';
      case AudioEncoder.audioEncoderAacEld:
        return 'AAC-ELD';
      case AudioEncoder.audioEncoderVorbis:
        return 'Vorbis';
      case AudioEncoder.audioEncoderOpus:
        return 'Opus';
    }
  }

  /// Checks if this encoder is recommended for music/high-quality audio
  ///
  /// Example:
  /// ```dart
  /// if (AudioEncoder.audioEncoderAac.isGoodForMusic) {
  ///   print('This encoder is suitable for music');
  /// }
  /// ```
  bool get isGoodForMusic {
    return this == AudioEncoder.audioEncoderAac ||
        this == AudioEncoder.audioEncoderOpus ||
        this == AudioEncoder.audioEncoderVorbis;
  }

  /// Checks if this encoder is recommended for voice/speech
  ///
  /// Example:
  /// ```dart
  /// if (AudioEncoder.audioEncoderAmrNb.isGoodForVoice) {
  ///   print('This encoder is optimized for voice');
  /// }
  /// ```
  bool get isGoodForVoice {
    return this == AudioEncoder.audioEncoderAmrNb ||
        this == AudioEncoder.audioEncoderAmrWb ||
        this == AudioEncoder.audioEncoderAacEld;
  }

  /// Checks if this encoder is recommended for streaming
  ///
  /// Example:
  /// ```dart
  /// if (AudioEncoder.audioEncoderHeAac.isGoodForStreaming) {
  ///   print('This encoder is suitable for streaming');
  /// }
  /// ```
  bool get isGoodForStreaming {
    return this == AudioEncoder.audioEncoderHeAac ||
        this == AudioEncoder.audioEncoderOpus ||
        this == AudioEncoder.audioEncoderAac;
  }

  /// Checks if this encoder support is optional (may not be available on all devices)
  ///
  /// Example:
  /// ```dart
  /// if (AudioEncoder.audioEncoderVorbis.hasOptionalSupport) {
  ///   print('This encoder may not be available on all devices');
  /// }
  /// ```
  bool get hasOptionalSupport {
    return this == AudioEncoder.audioEncoderVorbis;
  }

  /// Returns typical bitrate range for this encoder in bps
  ///
  /// Example:
  /// ```dart
  /// final range = AudioEncoder.audioEncoderAac.typicalBitrateRange;
  /// print('Typical bitrate: ${range.start / 1024} - ${range.end / 1024} kbps');
  /// ```
  ({int start, int end}) get typicalBitrateRange {
    switch (this) {
      case AudioEncoder.audioEncoderDefault:
        return (start: 64000, end: 128000);
      case AudioEncoder.audioEncoderAmrNb:
        return (start: 4750, end: 12200);
      case AudioEncoder.audioEncoderAmrWb:
        return (start: 6600, end: 23850);
      case AudioEncoder.audioEncoderAac:
        return (start: 64000, end: 320000);
      case AudioEncoder.audioEncoderHeAac:
        return (start: 16000, end: 128000);
      case AudioEncoder.audioEncoderAacEld:
        return (start: 16000, end: 320000);
      case AudioEncoder.audioEncoderVorbis:
        return (start: 45000, end: 500000);
      case AudioEncoder.audioEncoderOpus:
        return (start: 6000, end: 510000);
    }
  }

  /// Returns recommended bitrate for this encoder in bps
  ///
  /// Example:
  /// ```dart
  /// final bitrate = AudioEncoder.audioEncoderAac.recommendedBitrate;
  /// print('Recommended bitrate: ${bitrate / 1024} kbps');
  /// ```
  int get recommendedBitrate {
    switch (this) {
      case AudioEncoder.audioEncoderDefault:
        return 128000; // 128 kbps
      case AudioEncoder.audioEncoderAmrNb:
        return 12200; // 12.2 kbps
      case AudioEncoder.audioEncoderAmrWb:
        return 23850; // 23.85 kbps
      case AudioEncoder.audioEncoderAac:
        return 128000; // 128 kbps
      case AudioEncoder.audioEncoderHeAac:
        return 64000; // 64 kbps
      case AudioEncoder.audioEncoderAacEld:
        return 64000; // 64 kbps
      case AudioEncoder.audioEncoderVorbis:
        return 128000; // 128 kbps
      case AudioEncoder.audioEncoderOpus:
        return 128000; // 128 kbps
    }
  }

  /// Returns recommended sample rate for this encoder in Hz
  ///
  /// Example:
  /// ```dart
  /// final sampleRate = AudioEncoder.audioEncoderAac.recommendedSampleRate;
  /// print('Recommended sample rate: ${sampleRate / 1000} kHz');
  /// ```
  int get recommendedSampleRate {
    switch (this) {
      case AudioEncoder.audioEncoderDefault:
        return 44100; // 44.1 kHz
      case AudioEncoder.audioEncoderAmrNb:
        return 8000; // 8 kHz
      case AudioEncoder.audioEncoderAmrWb:
        return 16000; // 16 kHz
      case AudioEncoder.audioEncoderAac:
        return 44100; // 44.1 kHz
      case AudioEncoder.audioEncoderHeAac:
        return 44100; // 44.1 kHz
      case AudioEncoder.audioEncoderAacEld:
        return 48000; // 48 kHz
      case AudioEncoder.audioEncoderVorbis:
        return 44100; // 44.1 kHz
      case AudioEncoder.audioEncoderOpus:
        return 48000; // 48 kHz
    }
  }

  /// Returns encoders suitable for music/high-quality audio
  static List<AudioEncoder> getMusicEncoders() {
    return AudioEncoder.values.where((e) => e.isGoodForMusic).toList();
  }

  /// Returns encoders suitable for voice/speech
  static List<AudioEncoder> getVoiceEncoders() {
    return AudioEncoder.values.where((e) => e.isGoodForVoice).toList();
  }

  /// Returns encoders suitable for streaming
  static List<AudioEncoder> getStreamingEncoders() {
    return AudioEncoder.values.where((e) => e.isGoodForStreaming).toList();
  }
}

/// Output format types for MediaRecorder in Android
enum OutputFormat {
  /// Default output format
  ///
  /// This is the default output format that will be selected by the system.
  outputFormatDefault(0),

  /// 3GPP media file format
  ///
  /// A multimedia container format defined by the Third Generation Partnership Project (3GPP).
  /// Commonly used for mobile phones and 3G networks.
  /// File extension: `.3gp`
  /// Supports: H.263, H.264, AMR-NB, AMR-WB, AAC
  /// Use case: Mobile video, video calls, legacy mobile applications
  outputFormatThreeGpp(1),

  /// MPEG-4 media file format
  ///
  /// The most common and widely supported video container format.
  /// File extension: `.mp4`
  /// Supports: H.264, H.265, AAC, MP3
  /// Use case: Universal video format, screen recording, video sharing, streaming
  outputFormatMpeg4(2),

  /// AMR NB (Narrowband) file format
  ///
  /// Audio-only format for AMR-NB codec.
  /// File extension: `.amr`
  /// Supports: AMR-NB audio only
  /// Sample rate: 8 kHz
  /// Use case: Voice recording, phone calls
  ///
  /// **Note:** This is the same as [outputFormatRawAmr], which is deprecated.
  outputFormatAmrNb(3),

  /// AMR NB file format (deprecated name)
  ///
  /// This is identical to [outputFormatAmrNb] and is kept for backward compatibility.
  /// **Deprecated:** Use [outputFormatAmrNb] instead.
  @Deprecated('Use outputFormatAmrNb instead')
  outputFormatRawAmr(3),

  /// AMR WB (Wideband) file format
  ///
  /// Audio-only format for AMR-WB codec.
  /// File extension: `.awb`
  /// Supports: AMR-WB audio only
  /// Sample rate: 16 kHz
  /// Use case: High-quality voice recording
  outputFormatAmrWb(4),

  /// AAC ADIF (Audio Data Interchange Format) file format
  ///
  /// Audio-only AAC format with ADIF header.
  /// File extension: `.aac`
  /// Supports: AAC audio only
  /// **Note:** ADIF can only be played from the beginning, not suitable for streaming.
  /// Use case: Audio-only recording where streaming is not required
  ///
  /// **Hidden API:** This format is not commonly used in public APIs.
  outputFormatAacAdif(5),

  /// AAC ADTS (Audio Data Transport Stream) file format
  ///
  /// Audio-only AAC format with ADTS framing.
  /// File extension: `.aac`
  /// Supports: AAC audio only
  /// Each frame has its own header, allowing seeking and streaming.
  /// Use case: Audio-only recording, audio streaming, audio podcasts
  outputFormatAacAdts(6),

  /// RTP/AVP streaming format
  ///
  /// Real-time Transport Protocol / Audio Video Profile.
  /// Limited to a single stream, used for real-time streaming over network.
  /// Use case: Real-time video/audio streaming, VoIP
  ///
  /// **Hidden API:** This format is typically used by system components.
  outputFormatRtpAvp(7),

  /// MPEG-2 TS (Transport Stream) format
  ///
  /// H.264/AAC data encapsulated in MPEG-2 Transport Stream.
  /// File extension: `.ts`, `.m2ts`
  /// Supports: H.264 video, AAC audio
  /// Use case: Broadcasting, streaming, DVB, IPTV
  outputFormatMpeg2Ts(8),

  /// WebM container format
  ///
  /// Open-source media container format developed by Google.
  /// File extension: `.webm`
  /// Supports: VP8, VP9, AV1 video; Vorbis, Opus audio
  /// Use case: Web streaming, YouTube, open-source projects
  outputFormatWebm(9),

  /// HEIF (High Efficiency Image File Format) container
  ///
  /// Container format that can store HEVC/H.265 video and HEIC images.
  /// File extension: `.heif`, `.heic`
  /// Supports: HEVC/H.265 video, HEIC images
  /// Use case: High-efficiency image sequences, modern photo/video applications
  ///
  /// **Hidden API:** Not commonly used for video recording in public APIs.
  outputFormatHeif(10),

  /// Ogg container format
  ///
  /// Open-source container format.
  /// File extension: `.ogg`, `.oga`
  /// Supports: Opus, Vorbis audio
  /// Use case: Audio recording with Opus/Vorbis, open-source audio projects
  outputFormatOgg(11);

  /// Creates an OutputFormat enum with the specified value
  const OutputFormat(this.val);

  /// The integer value of this output format
  final int val;

  /// Returns the OutputFormat enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known output format.
  ///
  /// Example:
  /// ```dart
  /// final format = OutputFormat.fromValue(2);
  /// print(format?.name); // outputFormatMpeg4
  /// ```
  static OutputFormat? fromValue(int value) {
    try {
      return OutputFormat.values.firstWhere((format) => format.val == value);
    } catch (e) {
      return null;
    }
  }

  /// Returns a human-readable description of the output format
  ///
  /// Example:
  /// ```dart
  /// print(OutputFormat.outputFormatMpeg4.description);
  /// // Output: "MPEG_4"
  /// ```
  String get description {
    return name
        .replaceAll('outputFormat', '')
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns the output format name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(OutputFormat.outputFormatMpeg4.toUpperSnakeCase());
  /// // Output: "OUTPUT_FORMAT_MPEG_4"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }

  /// Returns a user-friendly display name for the output format
  ///
  /// Example:
  /// ```dart
  /// print(OutputFormat.outputFormatMpeg4.displayName);
  /// // Output: "MP4 (MPEG-4)"
  /// ```
  String get displayName {
    switch (this) {
      case OutputFormat.outputFormatDefault:
        return 'Default';
      case OutputFormat.outputFormatThreeGpp:
        return '3GP (3GPP)';
      case OutputFormat.outputFormatMpeg4:
        return 'MP4 (MPEG-4)';
      case OutputFormat.outputFormatAmrNb:
        return 'AMR-NB';
      case OutputFormat.outputFormatRawAmr:
        return 'AMR-NB (Legacy)';
      case OutputFormat.outputFormatAmrWb:
        return 'AMR-WB';
      case OutputFormat.outputFormatAacAdif:
        return 'AAC (ADIF)';
      case OutputFormat.outputFormatAacAdts:
        return 'AAC (ADTS)';
      case OutputFormat.outputFormatRtpAvp:
        return 'RTP/AVP Stream';
      case OutputFormat.outputFormatMpeg2Ts:
        return 'MPEG-2 TS';
      case OutputFormat.outputFormatWebm:
        return 'WebM';
      case OutputFormat.outputFormatHeif:
        return 'HEIF/HEIC';
      case OutputFormat.outputFormatOgg:
        return 'Ogg';
    }
  }

  /// Returns the typical file extension for this output format
  ///
  /// Example:
  /// ```dart
  /// print(OutputFormat.outputFormatMpeg4.fileExtension);
  /// // Output: ".mp4"
  /// ```
  String get fileExtension {
    switch (this) {
      case OutputFormat.outputFormatDefault:
        return '.mp4'; // Default to MP4
      case OutputFormat.outputFormatThreeGpp:
        return '.3gp';
      case OutputFormat.outputFormatMpeg4:
        return '.mp4';
      case OutputFormat.outputFormatAmrNb:
      case OutputFormat.outputFormatRawAmr:
        return '.amr';
      case OutputFormat.outputFormatAmrWb:
        return '.awb';
      case OutputFormat.outputFormatAacAdif:
      case OutputFormat.outputFormatAacAdts:
        return '.aac';
      case OutputFormat.outputFormatRtpAvp:
        return ''; // Streaming, no file
      case OutputFormat.outputFormatMpeg2Ts:
        return '.ts';
      case OutputFormat.outputFormatWebm:
        return '.webm';
      case OutputFormat.outputFormatHeif:
        return '.heif';
      case OutputFormat.outputFormatOgg:
        return '.ogg';
    }
  }

  /// Returns a short display name for the output format
  ///
  /// Example:
  /// ```dart
  /// print(OutputFormat.outputFormatMpeg4.shortName);
  /// // Output: "MP4"
  /// ```
  String get shortName {
    switch (this) {
      case OutputFormat.outputFormatDefault:
        return 'Default';
      case OutputFormat.outputFormatThreeGpp:
        return '3GP';
      case OutputFormat.outputFormatMpeg4:
        return 'MP4';
      case OutputFormat.outputFormatAmrNb:
      case OutputFormat.outputFormatRawAmr:
        return 'AMR-NB';
      case OutputFormat.outputFormatAmrWb:
        return 'AMR-WB';
      case OutputFormat.outputFormatAacAdif:
        return 'AAC-ADIF';
      case OutputFormat.outputFormatAacAdts:
        return 'AAC-ADTS';
      case OutputFormat.outputFormatRtpAvp:
        return 'RTP';
      case OutputFormat.outputFormatMpeg2Ts:
        return 'MPEG-TS';
      case OutputFormat.outputFormatWebm:
        return 'WebM';
      case OutputFormat.outputFormatHeif:
        return 'HEIF';
      case OutputFormat.outputFormatOgg:
        return 'Ogg';
    }
  }

  /// Checks if this format is audio-only
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatAacAdts.isAudioOnly) {
  ///   print('This format only supports audio');
  /// }
  /// ```
  bool get isAudioOnly {
    return this == OutputFormat.outputFormatAmrNb ||
        this == OutputFormat.outputFormatRawAmr ||
        this == OutputFormat.outputFormatAmrWb ||
        this == OutputFormat.outputFormatAacAdif ||
        this == OutputFormat.outputFormatAacAdts ||
        this == OutputFormat.outputFormatOgg;
  }

  /// Checks if this format supports video
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatMpeg4.supportsVideo) {
  ///   print('This format can contain video');
  /// }
  /// ```
  bool get supportsVideo {
    return !isAudioOnly && this != OutputFormat.outputFormatRtpAvp;
  }

  /// Checks if this format is widely supported across devices and platforms
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatMpeg4.isWidelySupported) {
  ///   print('This format works everywhere');
  /// }
  /// ```
  bool get isWidelySupported {
    return this == OutputFormat.outputFormatMpeg4 ||
        this == OutputFormat.outputFormatThreeGpp ||
        this == OutputFormat.outputFormatDefault;
  }

  /// Checks if this format is open-source/royalty-free
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatWebm.isOpenSource) {
  ///   print('This format has no licensing fees');
  /// }
  /// ```
  bool get isOpenSource {
    return this == OutputFormat.outputFormatWebm ||
        this == OutputFormat.outputFormatOgg;
  }

  /// Checks if this format is hidden/system API
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatRtpAvp.isHiddenApi) {
  ///   print('This format is not commonly available');
  /// }
  /// ```
  bool get isHiddenApi {
    return this == OutputFormat.outputFormatAacAdif ||
        this == OutputFormat.outputFormatRtpAvp ||
        this == OutputFormat.outputFormatHeif;
  }

  /// Checks if this format is suitable for streaming
  ///
  /// Example:
  /// ```dart
  /// if (OutputFormat.outputFormatMpeg4.isSuitableForStreaming) {
  ///   print('This format works well for streaming');
  /// }
  /// ```
  bool get isSuitableForStreaming {
    return this == OutputFormat.outputFormatMpeg4 ||
        this == OutputFormat.outputFormatWebm ||
        this == OutputFormat.outputFormatMpeg2Ts ||
        this == OutputFormat.outputFormatAacAdts ||
        this == OutputFormat.outputFormatRtpAvp;
  }

  /// Returns compatible video encoders for this output format
  ///
  /// Example:
  /// ```dart
  /// final encoders = OutputFormat.outputFormatMpeg4.compatibleVideoEncoders;
  /// print('Compatible encoders: ${encoders.map((e) => e.shortName).join(", ")}');
  /// ```
  List<VideoEncoder> get compatibleVideoEncoders {
    switch (this) {
      case OutputFormat.outputFormatDefault:
      case OutputFormat.outputFormatMpeg4:
        return [
          VideoEncoder.videoEncoderH264,
          VideoEncoder.videoEncoderHevc,
          VideoEncoder.videoEncoderH263,
          VideoEncoder.videoEncoderMpeg4Sp,
        ];
      case OutputFormat.outputFormatThreeGpp:
        return [VideoEncoder.videoEncoderH263, VideoEncoder.videoEncoderH264];
      case OutputFormat.outputFormatWebm:
        return [
          VideoEncoder.videoEncoderVp8,
          VideoEncoder.videoEncoderVp9,
          VideoEncoder.videoEncoderAv1,
        ];
      case OutputFormat.outputFormatMpeg2Ts:
        return [VideoEncoder.videoEncoderH264];
      case OutputFormat.outputFormatHeif:
        return [VideoEncoder.videoEncoderHevc];
      default:
        return []; // Audio-only or streaming formats
    }
  }

  /// Returns compatible audio encoders for this output format
  ///
  /// Example:
  /// ```dart
  /// final encoders = OutputFormat.outputFormatMpeg4.compatibleAudioEncoders;
  /// print('Compatible encoders: ${encoders.map((e) => e.shortName).join(", ")}');
  /// ```
  List<AudioEncoder> get compatibleAudioEncoders {
    switch (this) {
      case OutputFormat.outputFormatDefault:
      case OutputFormat.outputFormatMpeg4:
        return [
          AudioEncoder.audioEncoderAac,
          AudioEncoder.audioEncoderHeAac,
          AudioEncoder.audioEncoderAacEld,
        ];
      case OutputFormat.outputFormatThreeGpp:
        return [
          AudioEncoder.audioEncoderAmrNb,
          AudioEncoder.audioEncoderAmrWb,
          AudioEncoder.audioEncoderAac,
        ];
      case OutputFormat.outputFormatAmrNb:
      case OutputFormat.outputFormatRawAmr:
        return [AudioEncoder.audioEncoderAmrNb];
      case OutputFormat.outputFormatAmrWb:
        return [AudioEncoder.audioEncoderAmrWb];
      case OutputFormat.outputFormatAacAdif:
      case OutputFormat.outputFormatAacAdts:
        return [
          AudioEncoder.audioEncoderAac,
          AudioEncoder.audioEncoderHeAac,
          AudioEncoder.audioEncoderAacEld,
        ];
      case OutputFormat.outputFormatWebm:
        return [AudioEncoder.audioEncoderVorbis, AudioEncoder.audioEncoderOpus];
      case OutputFormat.outputFormatMpeg2Ts:
        return [AudioEncoder.audioEncoderAac];
      case OutputFormat.outputFormatOgg:
        return [AudioEncoder.audioEncoderOpus, AudioEncoder.audioEncoderVorbis];
      default:
        return [];
    }
  }

  /// Returns recommended formats for video recording
  static List<OutputFormat> getVideoFormats() {
    return OutputFormat.values.where((f) => f.supportsVideo).toList();
  }

  /// Returns recommended formats for audio-only recording
  static List<OutputFormat> getAudioFormats() {
    return OutputFormat.values.where((f) => f.isAudioOnly).toList();
  }

  /// Returns widely supported formats
  static List<OutputFormat> getWidelySupportedFormats() {
    return OutputFormat.values.where((f) => f.isWidelySupported).toList();
  }

  /// Returns open-source formats
  static List<OutputFormat> getOpenSourceFormats() {
    return OutputFormat.values.where((f) => f.isOpenSource).toList();
  }
}

/// Virtual Display Flags for configuring VirtualDisplay behavior in Android
enum DisplayManagerFlags {
  /// Virtual display flag: Create a public display.
  ///
  /// ## Public virtual displays
  /// When this flag is set, the virtual display is public.
  /// A public virtual display behaves just like most any other display that is connected
  /// to the system such as an external or wireless display. Applications can open
  /// windows on the display and the system may mirror the contents of other displays
  /// onto it.
  ///
  /// Creating a public virtual display that isn't restricted to own-content only implicitly
  /// creates an auto-mirroring display.
  ///
  /// ## Private virtual displays
  /// When this flag is not set, the virtual display is private as defined by the
  /// `Display.FLAG_PRIVATE` display flag.
  /// A private virtual display belongs to the application that created it. Only the owner of a
  /// private virtual display and the apps that are already on that display are allowed to place
  /// windows upon it.
  virtualDisplayFlagPublic(1 << 0),

  /// Virtual display flag: Create a presentation display.
  ///
  /// ## Presentation virtual displays
  /// When this flag is set, the virtual display is registered as a presentation
  /// display in the `DISPLAY_CATEGORY_PRESENTATION` presentation display category.
  /// Applications may automatically project their content to presentation displays
  /// to provide richer second screen experiences.
  ///
  /// ## Non-presentation virtual displays
  /// When this flag is not set, the virtual display is not registered as a presentation
  /// display. Applications can still project their content on the display but they
  /// will typically not do so automatically.
  virtualDisplayFlagPresentation(1 << 1),

  /// Virtual display flag: Create a secure display.
  ///
  /// ## Secure virtual displays
  /// When this flag is set, the virtual display is considered secure as defined
  /// by the `Display.FLAG_SECURE` display flag. The caller promises to take
  /// reasonable measures, such as over-the-air encryption, to prevent the contents
  /// of the display from being intercepted or recorded on a persistent medium.
  ///
  /// Creating a secure virtual display requires the `CAPTURE_SECURE_VIDEO_OUTPUT` permission.
  /// This permission is reserved for use by system components and is not available to
  /// third-party applications.
  ///
  /// ## Non-secure virtual displays
  /// When this flag is not set, the virtual display is considered unsecure.
  /// The content of secure windows will be blanked if shown on this display.
  virtualDisplayFlagSecure(1 << 2),

  /// Virtual display flag: Only show this display's own content; do not mirror
  /// the content of another display.
  ///
  /// This flag is used in conjunction with [virtualDisplayFlagPublic].
  /// Ordinarily public virtual displays will automatically mirror the content of the
  /// default display if they have no windows of their own. When this flag is
  /// specified, the virtual display will only ever show its own content and
  /// will be blanked instead if it has no windows.
  ///
  /// This flag is mutually exclusive with [virtualDisplayFlagAutoMirror]. If both
  /// flags are specified then the own-content only behavior will be applied.
  ///
  /// This behavior of this flag is implied whenever neither [virtualDisplayFlagPublic]
  /// nor [virtualDisplayFlagAutoMirror] have been set.
  virtualDisplayFlagOwnContentOnly(1 << 3),

  /// Virtual display flag: Allows content to be mirrored on private displays when no content is
  /// being shown.
  ///
  /// This flag is mutually exclusive with [virtualDisplayFlagOwnContentOnly].
  /// If both flags are specified then the own-content only behavior will be applied.
  ///
  /// The behavior of this flag is implied whenever [virtualDisplayFlagPublic] is set
  /// and [virtualDisplayFlagOwnContentOnly] has not been set. This flag is only
  /// required to override the default behavior when creating a private display.
  ///
  /// Creating an auto-mirroring virtual display requires the `CAPTURE_VIDEO_OUTPUT`
  /// or `CAPTURE_SECURE_VIDEO_OUTPUT` permission.
  /// These permissions are reserved for use by system components and are not available to
  /// third-party applications.
  ///
  /// Alternatively, an appropriate `MediaProjection` may be used to create an
  /// auto-mirroring virtual display.
  virtualDisplayFlagAutoMirror(1 << 4),

  /// Virtual display flag: Allows content to be displayed on private virtual displays when
  /// keyguard is shown but is insecure.
  ///
  /// This might be used in a case when the content of a virtual display is captured and sent to an
  /// external hardware display that is not visible to the system directly. This flag will allow
  /// the continued display of content while other displays will be covered by a keyguard which
  /// doesn't require providing credentials to unlock.
  ///
  /// This flag can only be applied to private displays as defined by the
  /// `Display.FLAG_PRIVATE` display flag. It is mutually exclusive with
  /// [virtualDisplayFlagPublic].
  virtualDisplayFlagCanShowWithInsecureKeyguard(1 << 5),

  /// Virtual display flag: Specifies that the virtual display can be associated with a
  /// touchpad device that matches its uniqueId.
  virtualDisplayFlagSupportsTouch(1 << 6),

  /// Virtual display flag: Indicates that the orientation of this display device is coupled to
  /// the orientation of its associated logical display.
  ///
  /// The flag should not be set when the physical display is mounted in a fixed orientation
  /// such as on a desk. Without this flag, display manager will apply a coordinate transformation
  /// such as a scale and translation to letterbox or pillarbox format under the assumption that
  /// the physical orientation of the display is invariant. With this flag set, the content will
  /// rotate to fill in the space of the display, as it does on the internal device display.
  virtualDisplayFlagRotatesWithContent(1 << 7),

  /// Virtual display flag: Indicates that the contents will be destroyed once
  /// the display is removed.
  ///
  /// Public virtual displays without this flag will move their content to main display
  /// stack once they're removed. Private virtual displays will always destroy their
  /// content on removal even without this flag.
  virtualDisplayFlagDestroyContentOnRemoval(1 << 8),

  /// Virtual display flag: Indicates that the display should support system decorations. Virtual
  /// displays without this flag shouldn't show home, navigation bar or wallpaper.
  ///
  /// This flag doesn't work without [virtualDisplayFlagTrusted]
  virtualDisplayFlagShouldShowSystemDecorations(1 << 9),

  /// Virtual display flags: Indicates that the display is trusted to show system decorations and
  /// receive inputs without users' touch.
  virtualDisplayFlagTrusted(1 << 10),

  /// Virtual display flags: Indicates that the display should not be a part of the default
  /// DisplayGroup and instead be part of a new DisplayGroup.
  virtualDisplayFlagOwnDisplayGroup(1 << 11),

  /// Virtual display flags: Indicates that the virtual display should always be unlocked and not
  /// have keyguard displayed on it. Only valid for virtual displays that aren't in the default
  /// display group.
  virtualDisplayFlagAlwaysUnlocked(1 << 12),

  /// Virtual display flags: Indicates that the display should not play sound effects or perform
  /// haptic feedback when the user touches the screen.
  virtualDisplayFlagTouchFeedbackDisabled(1 << 13),

  /// Virtual display flags: Indicates that the display maintains its own focus and touch mode.
  ///
  /// This flag is similar to `config_perDisplayFocusEnabled` in behavior, but only applies to the
  /// specific display instead of system-wide to all displays.
  ///
  /// Note: The display must be trusted in order to have its own focus.
  virtualDisplayFlagOwnFocus(1 << 14),

  /// Virtual display flags: Indicates that the display should not become the top focused display
  /// by stealing the top focus from another display.
  virtualDisplayFlagStealTopFocusDisabled(1 << 16);

  /// Creates a DisplayManagerFlags enum with the specified value
  const DisplayManagerFlags(this.val);

  /// The integer value of this flag
  final int val;

  /// Combines multiple flags using bitwise OR
  ///
  /// Example:
  /// ```dart
  /// final combinedFlags = DisplayManagerFlags.combineFlags([
  ///   DisplayManagerFlags.virtualDisplayFlagAutoMirror,
  ///   DisplayManagerFlags.virtualDisplayFlagPresentation,
  /// ]);
  /// ```
  static int combineFlags(List<DisplayManagerFlags> flags) {
    return flags.fold(0, (previous, flag) => previous | flag.val);
  }

  /// Returns the OutputFormat enum from an integer value
  ///
  /// Returns `null` if the value doesn't match any known output format.
  ///
  /// Example:
  /// ```dart
  /// final format = DisplayManagerFlags.fromValue(2);
  /// print(format?.name); // virtualDisplayFlagSecure
  /// ```

  static DisplayManagerFlags? fromValue(int value) {
    try {
      return DisplayManagerFlags.values.firstWhere(
        (format) => format.val == value,
      );
    } catch (e) {
      return null;
    }
  }

  /// Checks if a flag value contains this specific flag
  ///
  /// Example:
  /// ```dart
  /// final flags = DisplayManagerFlags.virtualDisplayFlagAutoMirror.val;
  /// if (DisplayManagerFlags.virtualDisplayFlagAutoMirror.isSetIn(flags)) {
  ///   print('Auto mirror is enabled');
  /// }
  /// ```
  bool isSetIn(int flags) {
    return (flags & val) != 0;
  }

  /// Returns a list of all flags that are set in the given flag value
  ///
  /// Example:
  /// ```dart
  /// final flags = DisplayManagerFlags.virtualDisplayFlagAutoMirror.val |
  ///               DisplayManagerFlags.virtualDisplayFlagPresentation.val;
  /// final setFlags = DisplayManagerFlags.getSetFlags(flags);
  /// print(setFlags); // [virtualDisplayFlagAutoMirror, virtualDisplayFlagPresentation]
  /// ```
  static List<DisplayManagerFlags> getSetFlags(int flags) {
    return DisplayManagerFlags.values
        .where((flag) => (flags & flag.val) != 0)
        .toList();
  }

  /// Returns a human-readable description of the flag(s)
  ///
  /// Example:
  /// ```dart
  /// final flags = DisplayManagerFlags.virtualDisplayFlagAutoMirror.val |
  ///               DisplayManagerFlags.virtualDisplayFlagPresentation.val;
  /// print(DisplayManagerFlags.getFlagDescription(flags));
  /// // Output: "AUTO_MIRROR | PRESENTATION"
  /// ```
  static String getFlagDescription(int flags) {
    final setFlags = getSetFlags(flags);
    if (setFlags.isEmpty) return 'NONE';

    return setFlags
        .map(
          (flag) => flag.name
              .replaceAll('virtualDisplayFlag', '')
              .replaceAllMapped(
                RegExp(r'[A-Z]'),
                (match) => '_${match.group(0)}',
              )
              .toUpperCase()
              .substring(1),
        )
        .join(' | ');
  }

  /// Returns the flag name in UPPER_SNAKE_CASE format
  ///
  /// Example:
  /// ```dart
  /// print(DisplayManagerFlags.virtualDisplayFlagAutoMirror.toUpperSnakeCase());
  /// // Output: "VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR"
  /// ```
  String toUpperSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase()
        .substring(1);
  }
}
