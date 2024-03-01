import '/flutter_flow/flutter_flow_util.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/material.dart';

class SignupModel extends FlutterFlowModel<SignupWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for EmailAddressField widget.
  FocusNode? emailAddressFieldFocusNode;
  TextEditingController? emailAddressFieldController;
  String? Function(BuildContext, String?)? emailAddressFieldControllerValidator;
  String? _emailAddressFieldControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required.';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for PasswordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldControllerValidator;
  String? _passwordFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  // State field(s) for ConfirmPasswordField widget.
  FocusNode? confirmPasswordFieldFocusNode;
  TextEditingController? confirmPasswordFieldController;
  late bool confirmPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordFieldControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    emailAddressFieldControllerValidator =
        _emailAddressFieldControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldControllerValidator = _passwordFieldControllerValidator;
    confirmPasswordFieldVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressFieldFocusNode?.dispose();
    emailAddressFieldController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldController?.dispose();

    confirmPasswordFieldFocusNode?.dispose();
    confirmPasswordFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
