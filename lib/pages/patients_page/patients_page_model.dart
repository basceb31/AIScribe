import '/backend/supabase/supabase.dart';
import '/components/transcript_list_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'patients_page_widget.dart' show PatientsPageWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class PatientsPageModel extends FlutterFlowModel<PatientsPageWidget> {
  ///  Local state fields for this page.

  bool isRecording = false;

  bool isPaused = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  Completer<List<PatientRow>>? requestCompleter2;
  // State field(s) for patientNameInput widget.
  FocusNode? patientNameInputFocusNode;
  TextEditingController? patientNameInputController;
  String? Function(BuildContext, String?)? patientNameInputControllerValidator;
  // State field(s) for diagnosisInput widget.
  FocusNode? diagnosisInputFocusNode;
  TextEditingController? diagnosisInputController;
  String? Function(BuildContext, String?)? diagnosisInputControllerValidator;
  // Model for transcriptListComponent component.
  late TranscriptListComponentModel transcriptListComponentModel;
  AudioRecorder? audioRecorder;
  String? audioOutput;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  Completer<List<PatientRow>>? requestCompleter1;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    transcriptListComponentModel =
        createModel(context, () => TranscriptListComponentModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    patientNameInputFocusNode?.dispose();
    patientNameInputController?.dispose();

    diagnosisInputFocusNode?.dispose();
    diagnosisInputController?.dispose();

    transcriptListComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
