import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'patients_transcript_widget.dart' show PatientsTranscriptWidget;
import 'package:flutter/material.dart';

class PatientsTranscriptModel
    extends FlutterFlowModel<PatientsTranscriptWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Query Rows] action in PatientsTranscript widget.
  List<PatientTranscriptRow>? transcript;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for notesTextField widget.
  FocusNode? notesTextFieldFocusNode1;
  TextEditingController? notesTextFieldController1;
  String? Function(BuildContext, String?)? notesTextFieldController1Validator;
  // State field(s) for transcriptTextField widget.
  FocusNode? transcriptTextFieldFocusNode;
  TextEditingController? transcriptTextFieldController;
  String? Function(BuildContext, String?)?
      transcriptTextFieldControllerValidator;
  // State field(s) for notesTextField widget.
  FocusNode? notesTextFieldFocusNode2;
  TextEditingController? notesTextFieldController2;
  String? Function(BuildContext, String?)? notesTextFieldController2Validator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    notesTextFieldFocusNode1?.dispose();
    notesTextFieldController1?.dispose();

    transcriptTextFieldFocusNode?.dispose();
    transcriptTextFieldController?.dispose();

    notesTextFieldFocusNode2?.dispose();
    notesTextFieldController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
