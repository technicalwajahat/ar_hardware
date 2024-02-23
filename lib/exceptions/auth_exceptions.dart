class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help');
      default:
        return const SignUpWithEmailAndPasswordFailure(
            "Invalid email or password");
    }
  }
}

class SignInWithEmailAndPasswordFailure {
  final String message;

  const SignInWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory SignInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignInWithEmailAndPasswordFailure(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return const SignInWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help');
      default:
        return const SignInWithEmailAndPasswordFailure(
            "Invalid email or password");
    }
  }
}
