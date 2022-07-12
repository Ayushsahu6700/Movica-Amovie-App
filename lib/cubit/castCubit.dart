import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../models/castMode.dart';
import '../models/movieModel.dart';
import 'castState.dart';

class castCubit extends Cubit<castState> {
  castCubit() : super(castState(code: "10", message: "", cast: []));
  getList(int id) async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/movie/${id.toString()}/credits?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US",
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );

      // print(response.data);
      print("Status code---------------------${response.statusCode}");
      String responseString = response.data.toString();
      print(responseString);
      Map? responseBody = response.data;

      List<CastModel> cast = [];
      responseBody!["cast"].forEach((element) {
        CastModel movie = CastModel.fromJson(element);
        cast.add(movie);
      });

      emit(castState(code: "00", message: "", cast: cast));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(castState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            cast: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(castState(code: "10", message: 'catched', cast: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(castState(code: "10", message: 'check your connection', cast: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(castState(
            code: "10", message: 'unable to connect to the server', cast: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(castState(code: "10", message: 'Something went wrong', cast: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
