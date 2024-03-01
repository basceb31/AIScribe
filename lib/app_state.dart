import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _isPatientEdit = false;
  bool get isPatientEdit => _isPatientEdit;
  set isPatientEdit(bool value) {
    _isPatientEdit = value;
  }

  bool _isTranscriptEdit = false;
  bool get isTranscriptEdit => _isTranscriptEdit;
  set isTranscriptEdit(bool value) {
    _isTranscriptEdit = value;
  }

  bool _updatedPatientAction = false;
  bool get updatedPatientAction => _updatedPatientAction;
  set updatedPatientAction(bool value) {
    _updatedPatientAction = value;
  }

  bool _deleteTranscriptAction = false;
  bool get deleteTranscriptAction => _deleteTranscriptAction;
  set deleteTranscriptAction(bool value) {
    _deleteTranscriptAction = value;
  }
}
