import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movica/cubit/personState.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/personModel.dart';

class personCubit extends Cubit<personState> {
  personCubit() : super(personState(code: "10", message: "", persons: []));
  getList() async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/trending/person/week?api_key=a2f16e775a1170487f03e87709bb6ef8",
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
      print("person cubit");
      List<PersonModel> persons = [];
      responseBody!["results"].forEach((element) {
        PersonModel person = PersonModel.fromJson(element);
        persons.add(person);
      });

      emit(personState(code: "00", message: "", persons: persons));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(personState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            persons: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(personState(code: "10", message: 'catched', persons: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(personState(
            code: "10", message: 'check your connection', persons: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(personState(
            code: "10",
            message: 'unable to connect to the server',
            persons: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(personState(
            code: "10", message: 'Something went wrong', persons: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
