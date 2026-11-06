import '../../fs/fs.dart';
import 'view_model.dart';

/*
  SignUp
    - FN, LN, Email, Password
  SignIn
    - Email, Password
    - Token & User
  Forgot Password
    - Email
  Verify Email
    - Resend Verify Email
  Logout
*/

abstract class SignUpRequest {
  String get fn;

  String get ln;

  String get email;

  String get password;
}

abstract class AuthTokens {
  String get accessToken;

  String get refreshToken;
}

abstract class AuthState {
  AuthTokens? get tokens;
}

abstract class AppUser {}

abstract class AuthViewModel extends AppBaseViewModel {
  bool get isLoggedIn;

  bool get emailVerified;

  Future<void> register(SignUpRequest data);

  Future<void> login({required String email, required String password});

  Future<void> logout();

  Future<void> forgotPassword();

  Future<void> sendEmailVerification();

  Future<void> verifyEmail({String otp});

  Future<void> refreshUser();

  Future<void> updateUser(AppUser user);

  Future<void> addProfilePicture(AppFile fie);
}
