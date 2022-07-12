import '../models/detailModel.dart';
import '../models/screenModel.dart';

class getImageState {
  ScreenModel? image;
  String code, message;
  getImageState(
      {required this.code, required this.message, required this.image});
}
