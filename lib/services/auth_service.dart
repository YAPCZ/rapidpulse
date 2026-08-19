import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rapidpulse_my/model/user_model.dart' as app;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for handling authentication logic with Supabase.
class AuthService {
AuthService._();

/// Singleton instance of [AuthService].
static final AuthService instance = AuthService._();

SupabaseClient get _client => Supabase.instance.client;

/// Converts a Supabase [User] object to the application's internal [app.User] model.
app.User userFromAuthUser(User authUser) {
  final metadata = authUser.userMetadata ?? {};

  final googleName =
      metadata['full_name'] as String? ??
          metadata['name'] as String?;

  return app.User(
    username: metadata['username'] as String? ??
        googleName ??
        authUser.email?.split('@').first ??
        'User',
    email: authUser.email ?? '',
    phone: metadata['phone'] as String? ?? '',
  );
}

/// Retrieves the currently authenticated user, if any.
Future<app.User?> getCurrentUser() async {
  final authUser = _client.auth.currentUser;
  if (authUser == null) return null;
  return userFromAuthUser(authUser);
}

/// Signs in a user using email and password.
Future<app.User> signInWithEmail({
  required String email,
  required String password,
  }) async {
  final response = await _client.auth.signInWithPassword(
  email: email.trim(),
  password: password,
  );

  if (response.user == null) {
    throw const AuthException('Login failed. Please try again.');
  }

  final user = userFromAuthUser(response.user!);
  return user;

}

/// Registers a new user with email, password, and additional metadata.
Future<SignUpResult> signUp({
  required String username,
  required String email,
  required String phone,
  required String password,
  }) async {
  final response = await _client.auth.signUp(
  email: email.trim(),
  password: password,
  data: {
  'name': username.trim(),
  'phone_number': phone.trim(),
  },
  );

  if (response.user == null) {
    throw const AuthException('Sign up failed. Please try again.');
  }

  final user = userFromAuthUser(response.user!);

  if (response.session != null) {
    return SignUpResult(user: user, emailConfirmationRequired: false);
  }

  return SignUpResult(user: user, emailConfirmationRequired: true);

}

/// Initiates Google OAuth sign-in flow.
Future<void> signInWithGoogle() async {
  await _client.auth.signInWithOAuth(
  OAuthProvider.google,
  redirectTo: kIsWeb
  ? null
  : 'myflutterapp://login-callback/',
  authScreenLaunchMode: kIsWeb
  ? LaunchMode.platformDefault
  : LaunchMode.externalApplication,
  );
}

/// Sends a password reset email to the specified address.
Future<void> resetPassword(String email) async {
  try {
  await _client.auth.resetPasswordForEmail(email.trim());
  } on AuthException {
  rethrow;
  } catch (error) {
  throw AuthException(error.toString());
  }
}

/// Verifies an OTP token and updates the user's password.
/// Used during the password recovery flow.
Future<void> verifyOtpAndSetPassword({
  required String email,
  required String token,
  required String newPassword,
  }) async {
  try {
  // 1. Verify token with OtpType.recovery to create temporary local session
  final AuthResponse response = await _client.auth.verifyOTP(
  email: email.trim(),
  token: token.trim(),
  type: OtpType.recovery,
  );

  if (response.session == null) {
      throw const AuthException('Verification failed: Code invalid or expired.');
    }

    // 2. Perform the update password update operation
    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  } on AuthException {
    rethrow;
  } catch (error) {
    throw AuthException(error.toString());
  }
}

/// Signs out the current user.
Future<void> signOut() async {
await _client.auth.signOut();
}
}

class SignUpResult {
const SignUpResult({
required this.user,
required this.emailConfirmationRequired,
});

final app.User user;
final bool emailConfirmationRequired;
}