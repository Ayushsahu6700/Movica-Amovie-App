import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';

class trendingMovieState {
  List<MovieModel> trendingMovie;
  String code, message;
  trendingMovieState(
      {required this.code, required this.message, required this.trendingMovie});
}
