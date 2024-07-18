import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:pingolearn_task_app/models/user_model.dart';
import 'package:pingolearn_task_app/services/auth_service.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/loading_widget_provider.dart';

class FirebaseAuthProvider extends ChangeNotifier with LoadingWidgetProvider {
  final AuthenticationService _authService = AuthenticationService();
  UserModel? _user;

  UserModel? get user => _user;

  Stream<UserModel?> get userStream => _authService.user;

  /// sign in
  Future<void> _login(
      String email, String password, BuildContext context) async {
    updateLoadingState(true);
    _user = await _authService.loginUser(
        email: email, password: password, context: context);
    notifyListeners();
    updateLoadingState(false);
  }

  /// Signup
  Future<void> _signUp(
      String name, String email, String password, BuildContext context) async {
    updateLoadingState(true);
    _user = await _authService.signupNewUser(
        name: name, email: email, password: password, context: context);
    notifyListeners();
    updateLoadingState(false);
  }

  Future<void> Function(String email, String password, BuildContext context)
      get login => _login;

  Future<void> Function(
          String name, String email, String password, BuildContext context)
      get signup => _signUp;
}
