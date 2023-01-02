abstract class AuthEvents {}

/* 
  * FormValidationEvent: Event to validate the form
  * FormSavedEvent: Event to save the form

  * Note: We can also use a single event to validate and save the form

  * NOTE: While adding event, just look into the UI and see what user can do
*/
class FormValidationEvent extends AuthEvents {
  final String email;
  final String password;

  FormValidationEvent(this.email, this.password);
}

class FormSavedEvent extends AuthEvents {
  final String email;
  final String password;

  FormSavedEvent(this.email, this.password);
}
