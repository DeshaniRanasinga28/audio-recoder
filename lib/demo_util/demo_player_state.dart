
import 'dart:async';


class PlayerState {
  static final PlayerState _self = PlayerState._internal();

  bool _hushOthers = false;

  factory PlayerState() {
    return _self;
  }

  PlayerState._internal();

  bool get hushOthers => _hushOthers;

  Future<void> setHush({bool hushOthers}) async {
    _hushOthers = hushOthers;
  }
}
