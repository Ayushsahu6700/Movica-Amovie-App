import '../models/personModel.dart';

class personState {
  List<PersonModel> persons;
  String code, message;
  personState(
      {required this.code, required this.message, required this.persons});
}
