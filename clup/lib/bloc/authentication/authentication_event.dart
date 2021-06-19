abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String username;
  final String password;
  Login(this.username, this.password);
}

class Logout extends AuthenticationEvent {}
