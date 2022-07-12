import 'package:movica/models/trendingMoviesModel.dart';

import '../models/castMode.dart';
import '../models/movieModel.dart';

class castState {
  List<CastModel> cast;
  String code, message;
  castState({required this.code, required this.message, required this.cast});
}
