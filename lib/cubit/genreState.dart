import '../models/genreModel.dart';

class genreState {
  List<GenreModel> genre;
  String code, message;
  genreState({required this.code, required this.message, required this.genre});
}
