import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';
import 'getVideoState.dart';

class getVideoCubit extends Cubit<getVideoState> {
  getVideoCubit() : super(getVideoState(code: "10", message: "", key: ''));
  getList(int id) async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/movie/${id.toString()}/videos?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US",
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

      String video = responseBody!["results"][0]['key'];

      emit(getVideoState(code: "00", message: "", key: video));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(getVideoState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            key: ''));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(getVideoState(code: "10", message: 'catched', key: ''));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(getVideoState(
            code: "10", message: 'check your connection', key: ''));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(getVideoState(
            code: "10", message: 'unable to connect to the server', key: ''));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(getVideoState(
            code: "10", message: 'Something went wrong', key: ''));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
