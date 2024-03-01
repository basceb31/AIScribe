import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_patient_model.dart';
export 'create_patient_model.dart';

class CreatePatientWidget extends StatefulWidget {
  const CreatePatientWidget({
    super.key,
    String? patientName,
  }) : patientName = patientName ?? 'patient name';

  final String patientName;

  @override
  State<CreatePatientWidget> createState() => _CreatePatientWidgetState();
}

class _CreatePatientWidgetState extends State<CreatePatientWidget> {
  late CreatePatientModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreatePatientModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
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
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
          child: TextFormField(
            controller: _model.textController1,
            focusNode: _model.textFieldFocusNode1,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Patient Name',
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
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
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
            validator: _model.textController1Validator.asValidator(context),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet<bool>(
                          context: context,
                          builder: (context) {
                            return ScrollConfiguration(
                              behavior: const MaterialScrollBehavior().copyWith(
                                dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.stylus,
                                  PointerDeviceKind.unknown
                                },
                              ),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  minimumDate: DateTime(1900),
                                  initialDateTime:
                                      (_model.datePicked ?? DateTime.now()),
                                  maximumDate:
                                      (_model.datePicked ?? DateTime.now()),
                                  use24hFormat: false,
                                  onDateTimeChanged: (newDateTime) =>
                                      safeSetState(() {
                                    _model.datePicked = newDateTime;
                                  }),
                                ),
                              ),
                            );
                          });
                      setState(() {
                        _model.textController2?.text = valueOrDefault<String>(
                          dateTimeFormat('yMMMd', _model.datePicked),
                          '00/00/0000',
                        );
                      });
                    },
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: TextFormField(
                        controller: _model.textController2,
                        focusNode: _model.textFieldFocusNode2,
                        autofocus: true,
                        readOnly: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Birthdate',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                        validator: _model.textController2Validator
                            .asValidator(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 20.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              _model.createPatient = await PatientTable().insert({
                'name': _model.textController1.text,
                'diagnosis': '- - ',
                'date_of_birth': supaSerialize<DateTime>(_model.datePicked),
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ' Patient Created',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  duration: const Duration(milliseconds: 3000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );

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
                    'Add Patient',
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
