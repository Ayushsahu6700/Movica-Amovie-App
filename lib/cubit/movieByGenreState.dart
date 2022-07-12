import '../models/movieModel.dart';

class movieByGenreState {
  List<MovieModel> movieByGenre;
  String code, message;
  movieByGenreState(
      {required this.code, required this.message, required this.movieByGenre});
}
