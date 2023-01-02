import 'package:firebase_auth_using_bloc_flutter/blocs/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

import './auth_events.dart';
import './auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(InitialState()) {
    on<EmailValidationEvent>((event, emit) {
      if (event.email == null || event.email.isEmpty) {
        emit(InvalidEmailState('Please enter some text'));
      }
      if (!EmailValidator.validate(event.email)) {
        emit(InvalidEmailState('Please enter a valid email address'));
      } else {
        emit(ValidEmailState(null));
      }
    });

    on<PasswordValidationEvent>((event, emil) {
      if (event.password == null || event.password.isEmpty) {
        emit(InvalidPasswordState('Please enter some text'));
      }
      if (event.password.length < 6) {
        emit(InvalidPasswordState(
            'Password must be at least 6 characters long'));
      } else {
        emit(ValidPasswordState(null));
      }
    });
    on<FormSavedEvent>((event, emit) async {
      final authRep = AuthRepository();
      final response = await authRep.signin(event.email, event.password);
      if (response) {
        emit(SuccessfulState());
        print('Log in successful');
      } else {
        print('Log in failed');
        emit(FailedState());
      }
    });
  }
}
