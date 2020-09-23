
import 'package:flutter_sound/flutter_sound.dart';

class ActiveCodec {
  static final ActiveCodec _self = ActiveCodec._internal();

  Codec _codec = Codec.aacADTS;
  bool _encoderSupported = false;
  bool _decoderSupported = false;
  FlutterSoundRecorder recorderModule;

  factory ActiveCodec() {
    return _self;
  }
  ActiveCodec._internal();

  void setCodec({bool withUI, Codec codec}) async {
     FlutterSoundPlayer player = FlutterSoundPlayer();
    if (withUI) {
      await player.openAudioSessionWithUI(focus: AudioFocus.requestFocusAndDuckOthers);
      _encoderSupported = await recorderModule.isEncoderSupported(codec);
      _decoderSupported = await player.isDecoderSupported(codec);
    } else {
      await player.openAudioSession(focus: AudioFocus.requestFocusAndDuckOthers);
      _encoderSupported = await recorderModule.isEncoderSupported(codec);
      _decoderSupported = await player.isDecoderSupported(codec);
    }
    _codec = codec;
  }

  bool get encoderSupported => _encoderSupported;

  bool get decoderSupported => _decoderSupported;

  Codec get codec => _codec;
}
