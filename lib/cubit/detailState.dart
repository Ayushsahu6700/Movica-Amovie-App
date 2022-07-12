import 'package:movica/models/genreModel.dart';

import '../models/detailModel.dart';

class detailState {
  DetailModel? detail;
  List<GenreModel> genre;
  String code, message;
  detailState(
      {required this.code,
      required this.message,
      required this.detail,
      required this.genre});
}
