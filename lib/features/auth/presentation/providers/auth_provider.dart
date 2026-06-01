import 'package:flutter/foundation.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.authRepository,
  });

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository authRepository;

  AuthStatus status = AuthStatus.initial;
  UserEntity? currentUser;
  String? errorMessage;

  Future<void> checkAuthStatus() async {
    status = AuthStatus.loading;
    notifyListeners();

    currentUser = await authRepository.getCurrentUser();
    status = currentUser != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    status = AuthStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await loginUseCase(email: email, password: password);
      status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (error) {
      status = AuthStatus.error;
      errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    status = AuthStatus.loading;
    notifyListeners();

    await logoutUseCase();
    currentUser = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
