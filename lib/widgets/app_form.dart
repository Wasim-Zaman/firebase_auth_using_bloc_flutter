import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/auth_events.dart';
import '../blocs/auth_states.dart';
import '../blocs/auth_repository.dart';

class AppForm extends StatefulWidget {
  const AppForm({super.key});

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = <String, String>{
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _saveForm() async {
    /*
      * In order to save the form, we need to validate the form first
      * If the form is not valid, we don't need to save the form
      * So, we are using the validate() method to validate the form
      * If the form is valid, we are saving the form
    */
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    print('^^^^^^^^^^^^^ ${_authData['email']} ^^^^^^^^^^^');
    print('^^^^^^^^^^^^^ ${_authData['password']} ^^^^^^^^^^^');

    _formKey.currentState?.save();
    // final authRep = AuthRepository();
    // final response =
    //     await authRep.signin(_authData['email']!, _authData['password']!);
    // if (response) {
    //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Login Successful'),
    //     ),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Login Failed'),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthStates>(
              builder: (context, state) {
                return TextFormField(
                  onChanged: (value) {
                    // Email Changed Event
                    BlocProvider.of<AuthBloc>(context)
                        .add(EmailValidationEvent(value));
                    _authData['email'] = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_) {
                    if (state is InvalidEmailState) {
                      return state.message;
                    }
                  },
                  onSaved: (value) {
                    // Form Saved Event
                    _authData['email'] = value!;
                  },
                );
              },
            ),
            BlocBuilder<AuthBloc, AuthStates>(
              builder: (context, state) {
                return TextFormField(
                  onChanged: (value) {
                    // Email Changed Event
                    BlocProvider.of<AuthBloc>(context)
                        .add(PasswordValidationEvent(value));
                    _authData['password'] = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_) {
                    if (state is InvalidPasswordState) {
                      return state.message;
                    }
                  },
                  onSaved: (value) {
                    // Form Saved Event
                    _authData['password'] = value!;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthStates>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      BlocProvider.of<AuthBloc>(context).add(FormSavedEvent(
                          _authData['email']!, _authData['password']!));
                      print('%%%%%%%% ${_authData['email']!} %%%%%%%%');
                      print('%%%%%%%% ${_authData['password']!} %%%%%%%%');

                      if (state is SuccessfulState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Successful'),
                          ),
                        );
                      } else if (state is FailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Failed'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
