abstract class AuthEvents {}

/* 
  * FormValidationEvent: Event to validate the form
  * FormSavedEvent: Event to save the form

  * Note: We can also use a single event to validate and save the form

  * NOTE: While adding event, just look into the UI and see what user can do
*/

class EmailValidationEvent extends AuthEvents {
  final String email;

  EmailValidationEvent(this.email);
}

class PasswordValidationEvent extends AuthEvents {
  final String password;

  PasswordValidationEvent(this.password);
}

class FormSavedEvent extends AuthEvents {
  final String email;
  final String password;

  FormSavedEvent(this.email, this.password);
}
