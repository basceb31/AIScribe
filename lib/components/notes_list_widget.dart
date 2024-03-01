import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_list_model.dart';
export 'notes_list_model.dart';

class NotesListWidget extends StatefulWidget {
  const NotesListWidget({
    super.key,
    this.notes,
  });

  final String? notes;

  @override
  State<NotesListWidget> createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  late NotesListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotesListModel());

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

    return Text(
      valueOrDefault<String>(
        widget.notes,
        'transcript',
      ),
      style: FlutterFlowTheme.of(context).bodyMedium,
    );
  }
}
