import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'update_patient_model.dart';
export 'update_patient_model.dart';

class UpdatePatientWidget extends StatefulWidget {
  const UpdatePatientWidget({
    super.key,
    required this.patiendID,
  });

  final int? patiendID;

  @override
  State<UpdatePatientWidget> createState() => _UpdatePatientWidgetState();
}

class _UpdatePatientWidgetState extends State<UpdatePatientWidget> {
  late UpdatePatientModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdatePatientModel());

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<PatientRow>>(
          future: PatientTable().querySingleRow(
            queryFn: (q) => q.eq(
              'id',
              widget.patiendID,
            ),
          ),
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
            List<PatientRow> listViewPatientRowList = snapshot.data!;
            final listViewPatientRow = listViewPatientRowList.isNotEmpty
                ? listViewPatientRowList.first
                : null;
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    'Patient Name',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 20.0),
                  child: TextFormField(
                    controller: _model.textController1 ??=
                        TextEditingController(
                      text: listViewPatientRow?.name,
                    ),
                    focusNode: _model.textFieldFocusNode1,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    validator:
                        _model.textController1Validator.asValidator(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                  child: Text(
                    'Patient Diagnosis',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 20.0),
                  child: TextFormField(
                    controller: _model.textController2 ??=
                        TextEditingController(
                      text: listViewPatientRow?.diagnosis,
                    ),
                    focusNode: _model.textFieldFocusNode2,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    validator:
                        _model.textController2Validator.asValidator(context),
                  ),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              _model.updatedUser = await PatientTable().update(
                data: {
                  'name': _model.textController1.text,
                  'diagnosis': _model.textController2.text,
                },
                matchingRows: (rows) => rows.eq(
                  'id',
                  widget.patiendID,
                ),
                returnRows: true,
              );
              FFAppState().update(() {});
              Navigator.pop(context);
              FFAppState().update(() {
                FFAppState().updatedPatientAction = true;
              });

              context.pushNamed('Patients');

              setState(() {});
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Update Patient',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
