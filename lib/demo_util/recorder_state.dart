
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:flutter_sound/src/util/log.dart';
import 'package:flutter_sound_demo/demo_util/temp_file.dart';
import 'demo_active_codec.dart';

class UtilRecorder {
  static final UtilRecorder _self = UtilRecorder._internal();


  FlutterSoundRecorder recorderModule;
  FlutterSoundRecorder recorderModule_2;

  factory UtilRecorder() {
    return _self;
  }

  UtilRecorder._internal()  {
    recorderModule = FlutterSoundRecorder();
  }


  bool get isRecording => recorderModule != null && recorderModule.isRecording;
  bool get isPaused => recorderModule != null && recorderModule.isPaused;

  void init() async {
    await recorderModule.openAudioSession(focus: AudioFocus.requestFocusAndDuckOthers);
    ActiveCodec().recorderModule = recorderModule;
  }

  void reset() async {
    if (UtilRecorder().isRecording) await UtilRecorder().stopRecorder();
  }

  Stream<RecordingDisposition> dispositionStream(
      {Duration interval = const Duration(milliseconds: 10)}) {
    return recorderModule.dispositionStream(
      /* TODO interval: interval*/
    );
  }


  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
    } on Object catch (err) {
      Log.d('stopRecorder error: $err');
      rethrow;
    }
  }


  void startRecorder(BuildContext context) async {
    try {
      /// TODO put this back iin

      var track = Track(trackPath: await tempFile(), codec: ActiveCodec().codec);
      await recorderModule.startRecorder(toFile: track.trackPath);

      Log.d('startRecorder: $track');

    } on RecorderException catch (err) {
      Log.d('startRecorder error: $err');

      var error = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to start recording: $err'));
      Scaffold.of(context).showSnackBar(error);

      stopRecorder();
    }
  }

  void pauseResumeRecorder() {
    assert(recorderModule.isRecording || recorderModule.isPaused);
    if (recorderModule.isPaused) {
      {
        recorderModule.resumeRecorder();
      }
    } else {
      recorderModule.pauseRecorder();
    }
  }
}
