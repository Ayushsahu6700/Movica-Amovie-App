import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';

class nowPlayingMovieState {
  List<MovieModel> nowPlayingMovie;
  String code, message;
  nowPlayingMovieState(
      {required this.code,
      required this.message,
      required this.nowPlayingMovie});
}
