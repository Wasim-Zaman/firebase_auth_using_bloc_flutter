abstract class AuthStates {}

// One state can be for initial state
class InitialState extends AuthStates {}

// One state can be for invalid data
class InvalidEmailState extends AuthStates {
  final message;
  InvalidEmailState(this.message);
}

class InvalidPasswordState extends AuthStates {
  final message;
  InvalidPasswordState(this.message);
}

// One state can be for valid data
class ValidEmailState extends AuthStates {
  final message;
  ValidEmailState(this.message);
}

class ValidPasswordState extends AuthStates {
  final message;
  ValidPasswordState(this.message);
}

// One state can be for error
class ErrorState extends AuthStates {}

// One state can be for loading
class LoadingState extends AuthStates {}

class SuccessfulState extends AuthStates {}

class FailedState extends AuthStates {}
