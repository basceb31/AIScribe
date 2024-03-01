import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/create_patient_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'patients_model.dart';
export 'patients_model.dart';

class PatientsWidget extends StatefulWidget {
  const PatientsWidget({
    super.key,
    bool? updatePatientAction,
  }) : updatePatientAction = updatePatientAction ?? false;

  final bool updatePatientAction;

  @override
  State<PatientsWidget> createState() => _PatientsWidgetState();
}

class _PatientsWidgetState extends State<PatientsWidget> {
  late PatientsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PatientsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.updatePatientAction) {
        setState(() => _model.requestCompleter = null);
        await _model.waitForRequestCompleted();
      } else {
        return;
      }

      setState(() {
        FFAppState().updatedPatientAction = false;
      });
    });

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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        floatingActionButton: Align(
          alignment: const AlignmentDirectional(0.1, 1.0),
          child: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () => _model.unfocusNode.canRequestFocus
                        ? FocusScope.of(context)
                            .requestFocus(_model.unfocusNode)
                        : FocusScope.of(context).unfocus(),
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: const CreatePatientWidget(
                        patientName: '',
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));

              setState(() => _model.requestCompleter = null);
              await _model.waitForRequestCompleted();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Patient Added!',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  duration: const Duration(milliseconds: 3000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
            },
            backgroundColor: FlutterFlowTheme.of(context).secondary,
            elevation: 8.0,
            child: const Icon(
              Icons.person_add_alt,
              color: Colors.black,
              size: 24.0,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Patients',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signOut();
                  GoRouter.of(context).clearRedirectLocation();

                  context.goNamedAuth('Login', context.mounted);
                },
                text: 'Logout',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                  elevation: 3.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.85,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 0.0),
                    child: FutureBuilder<List<PatientRow>>(
                      future: (_model.requestCompleter ??=
                              Completer<List<PatientRow>>()
                                ..complete(PatientTable().queryRows(
                                  queryFn: (q) => q.order('created_at'),
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
                                color: FlutterFlowTheme.of(context).primary,
                                size: 50.0,
                              ),
                            ),
                          );
                        }
                        List<PatientRow> listViewPatientRowList =
                            snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewPatientRowList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewPatientRow =
                                listViewPatientRowList[listViewIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 8.0),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'PatientsPage',
                                      queryParameters: {
                                        'patientSymptoms': serializeParam(
                                          listViewPatientRow.symptoms,
                                          ParamType.String,
                                        ),
                                        'patientName': serializeParam(
                                          listViewPatientRow.name,
                                          ParamType.String,
                                        ),
                                        'patientDiagnosis': serializeParam(
                                          listViewPatientRow.diagnosis,
                                          ParamType.String,
                                        ),
                                        'patientDOB': serializeParam(
                                          valueOrDefault<String>(
                                            listViewPatientRow.dateOfBirth
                                                ?.toString(),
                                            'birthdate',
                                          ),
                                          ParamType.String,
                                        ),
                                        'patientId': serializeParam(
                                          listViewPatientRow.id,
                                          ParamType.int,
                                        ),
                                        'patientEdit': serializeParam(
                                          false,
                                          ParamType.bool,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      },
                                    );
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio: 0.5,
                                            children: [
                                              SlidableAction(
                                                label: 'View',
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                icon: Icons.remove_red_eye,
                                                onPressed: (_) async {
                                                  context.pushNamed(
                                                    'PatientsPage',
                                                    queryParameters: {
                                                      'patientSymptoms':
                                                          serializeParam(
                                                        listViewPatientRow
                                                            .symptoms,
                                                        ParamType.String,
                                                      ),
                                                      'patientName':
                                                          serializeParam(
                                                        listViewPatientRow.name,
                                                        ParamType.String,
                                                      ),
                                                      'patientDiagnosis':
                                                          serializeParam(
                                                        listViewPatientRow
                                                            .diagnosis,
                                                        ParamType.String,
                                                      ),
                                                      'patientDOB':
                                                          serializeParam(
                                                        dateTimeFormat(
                                                            'yMMMd',
                                                            listViewPatientRow
                                                                .dateOfBirth),
                                                        ParamType.String,
                                                      ),
                                                      'patientId':
                                                          serializeParam(
                                                        listViewPatientRow.id,
                                                        ParamType.int,
                                                      ),
                                                      'patientEdit':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          const TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .rightToLeft,
                                                      ),
                                                    },
                                                  );
                                                },
                                              ),
                                              SlidableAction(
                                                label: 'Delete\n',
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                icon:
                                                    Icons.delete_forever_sharp,
                                                onPressed: (_) async {
                                                  var shouldSetState = false;
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Delete Patient?'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: const Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    await PatientTable().delete(
                                                      matchingRows: (rows) =>
                                                          rows.eq(
                                                        'id',
                                                        listViewPatientRow.id,
                                                      ),
                                                    );
                                                    shouldSetState = true;
                                                  } else {
                                                    if (shouldSetState) {
                                                      setState(() {});
                                                    }
                                                    return;
                                                  }

                                                  setState(() => _model
                                                      .requestCompleter = null);
                                                  await _model
                                                      .waitForRequestCompleted();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Patient Deleted',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 3000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                  if (shouldSetState) {
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.person_outline_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                            title: Text(
                                              listViewPatientRow.name,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge,
                                            ),
                                            subtitle: Text(
                                              valueOrDefault<String>(
                                                listViewPatientRow.diagnosis,
                                                '-',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium,
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                            tileColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            dense: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
