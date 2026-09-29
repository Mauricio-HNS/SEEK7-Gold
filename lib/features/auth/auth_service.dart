class AuthService {
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    // Backend authentication will be connected here.
    return email.trim().isNotEmpty && password.isNotEmpty;
  }

  Future<void> signOut() async {
    // Clear session/token when backend authentication is connected.
  }
}
