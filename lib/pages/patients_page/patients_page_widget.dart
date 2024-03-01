import '/backend/supabase/supabase.dart';
import '/components/transcript_list_component_widget.dart';
import '/components/update_patient_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'patients_page_model.dart';
export 'patients_page_model.dart';

class PatientsPageWidget extends StatefulWidget {
  const PatientsPageWidget({
    super.key,
    String? patientSymptoms,
    this.patientName,
    String? patientDiagnosis,
    String? patientDOB,
    required this.patientId,
    this.patientEdit,
  })  : patientSymptoms = patientSymptoms ?? 'symptoms',
        patientDiagnosis = patientDiagnosis ?? 'diagnosis',
        patientDOB = patientDOB ?? 'date of birth';

  final String patientSymptoms;
  final String? patientName;
  final String patientDiagnosis;
  final String patientDOB;
  final int? patientId;
  final bool? patientEdit;

  @override
  State<PatientsPageWidget> createState() => _PatientsPageWidgetState();
}

class _PatientsPageWidgetState extends State<PatientsPageWidget>
    with TickerProviderStateMixin {
  late PatientsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'iconOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 500.ms,
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.2, 1.2),
        ),
      ],
    ),
    'floatingActionButtonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.2, 1.2),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PatientsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().deleteTranscriptAction == true) {
        setState(() => _model.requestCompleter2 = null);
        await _model.waitForRequestCompleted2();
      } else {
        return;
      }

      setState(() {
        FFAppState().deleteTranscriptAction = false;
      });
    });

    _model.patientNameInputController ??= TextEditingController();
    _model.patientNameInputFocusNode ??= FocusNode();

    _model.diagnosisInputController ??= TextEditingController();
    _model.diagnosisInputFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<PatientRow>>(
      future: (_model.requestCompleter2 ??= Completer<List<PatientRow>>()
            ..complete(PatientTable().querySingleRow(
              queryFn: (q) => q,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingFour(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<PatientRow> patientsPagePatientRowList = snapshot.data!;
        final patientsPagePatientRow = patientsPagePatientRowList.isNotEmpty
            ? patientsPagePatientRowList.first
            : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            floatingActionButton: Align(
              alignment: const AlignmentDirectional(0.1, 1.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  var shouldSetState = false;
                  await requestPermission(microphonePermission);
                  if (!(await getPermissionStatus(microphonePermission))) {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: const Text('Permission Required'),
                          content: const Text('Microphone permission is required'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    await requestPermission(microphonePermission);
                    if (shouldSetState) setState(() {});
                    return;
                  }
                  if (!_model.isRecording) {
                    setState(() {
                      _model.isRecording = true;
                    });
                    _model.audioRecorder ??= AudioRecorder();
                    if (await _model.audioRecorder!.hasPermission()) {
                      final String path;
                      final AudioEncoder encoder;
                      if (kIsWeb) {
                        path = '';
                        encoder = AudioEncoder.opus;
                      } else {
                        final dir = await getApplicationDocumentsDirectory();
                        path =
                            '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
                        encoder = AudioEncoder.aacLc;
                      }
                      await _model.audioRecorder!.start(
                        RecordConfig(encoder: encoder),
                        path: path,
                      );
                    } else {
                      showSnackbar(
                        context,
                        'You have not provided permission to record audio.',
                      );
                    }
                  } else {
                    setState(() {
                      _model.isRecording = false;
                    });
                    _model.audioOutput = await _model.audioRecorder?.stop();
                    if (_model.audioOutput != null) {
                      _model.recordedFileBytes = FFUploadedFile(
                        name: 'recordedFileBytes.mp3',
                        bytes: await XFile(_model.audioOutput!).readAsBytes(),
                      );
                    }

                    shouldSetState = true;
                    unawaited(
                      () async {
                        await actions.transcribeAndUpload(
                          _model.audioOutput!,
                          widget.patientId!,
                          patientsPagePatientRow!.isNewPatient!,
                        );
                      }(),
                    );
                  }

                  setState(() => _model.requestCompleter1 = null);
                  await _model.waitForRequestCompleted1();
                  if (shouldSetState) setState(() {});
                },
                backgroundColor: const Color(0xFF2F2F2F),
                elevation: 5.0,
                label: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!_model.isRecording)
                      Icon(
                        Icons.circle,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 35.0,
                      ),
                    if (_model.isRecording)
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.stop,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 45.0,
                        ),
                      ),
                    if (_model.isRecording)
                      Icon(
                        Icons.pause,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 40.0,
                      ),
                  ],
                ),
              ).animateOnActionTrigger(
                animationsMap['floatingActionButtonOnActionTriggerAnimation']!,
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                  FFAppState().update(() {
                    FFAppState().isPatientEdit = false;
                  });
                },
              ),
              title: Text(
                'Patients/Transcripts',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.8,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child:
                                                FutureBuilder<List<PatientRow>>(
                                              future: (_model
                                                          .requestCompleter1 ??=
                                                      Completer<
                                                          List<PatientRow>>()
                                                        ..complete(
                                                            PatientTable()
                                                                .querySingleRow(
                                                          queryFn: (q) => q.eq(
                                                            'id',
                                                            widget.patientId,
                                                          ),
                                                        )))
                                                  .future,
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitFadingFour(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<PatientRow>
                                                    listViewPatientRowList =
                                                    snapshot.data!;
                                                final listViewPatientRow =
                                                    listViewPatientRowList
                                                            .isNotEmpty
                                                        ? listViewPatientRowList
                                                            .first
                                                        : null;
                                                return ListView(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Text(
                                                                  'Name: ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                      ),
                                                                ),
                                                              ),
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                FFAppState()
                                                                        .isPatientEdit ==
                                                                    false,
                                                                true,
                                                              ))
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewPatientRow
                                                                        ?.name,
                                                                    'name',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge,
                                                                ),
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                FFAppState()
                                                                    .isPatientEdit,
                                                                false,
                                                              ))
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          _model
                                                                              .patientNameInputController,
                                                                      focusNode:
                                                                          _model
                                                                              .patientNameInputFocusNode,
                                                                      autofocus:
                                                                          true,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Enter Name',
                                                                        labelStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        hintStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        errorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedErrorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                      validator: _model
                                                                          .patientNameInputControllerValidator
                                                                          .asValidator(
                                                                              context),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Text(
                                                                  'Diagnosis: ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                      ),
                                                                ),
                                                              ),
                                                              if (FFAppState()
                                                                      .isPatientEdit ==
                                                                  false)
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewPatientRow
                                                                        ?.diagnosis,
                                                                    'diagnosis',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                FFAppState()
                                                                    .isPatientEdit,
                                                                false,
                                                              ))
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          _model
                                                                              .diagnosisInputController,
                                                                      focusNode:
                                                                          _model
                                                                              .diagnosisInputFocusNode,
                                                                      autofocus:
                                                                          true,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Enter Diagnosis',
                                                                        labelStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        hintStyle:
                                                                            FlutterFlowTheme.of(context).labelMedium,
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        errorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedErrorBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                      validator: _model
                                                                          .diagnosisInputControllerValidator
                                                                          .asValidator(
                                                                              context),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Text(
                                                                  'Date of Birth: ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                      'yMMMd',
                                                                      listViewPatientRow
                                                                          ?.dateOfBirth),
                                                                  'date of birth',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (!valueOrDefault<bool>(
                                        FFAppState().isPatientEdit,
                                        false,
                                      ))
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: UpdatePatientWidget(
                                                      patiendID:
                                                          widget.patientId!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                        ).animateOnActionTrigger(
                                          animationsMap[
                                              'iconOnActionTriggerAnimation']!,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.67,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: wrapWithModel(
                      model: _model.transcriptListComponentModel,
                      updateCallback: () => setState(() {}),
                      child: TranscriptListComponentWidget(
                        patientId: widget.patientId!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
