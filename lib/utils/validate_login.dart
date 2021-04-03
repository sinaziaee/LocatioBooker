class FieldValidator{
  static String validateEmail(String value){
    if(value.isEmpty || value.length == 0){
      return 'No Email Entered';
    }

    if(!value.contains("@")){
      return 'Bad Email Format';
    }

    return 'Successful';
  }
}