import 'package:ckuck_norris/joke.dart';
import 'package:dio/dio.dart';

class RandomJokesService {
  RandomJokesService._();

  static Future<Joke> loadJoke() async {
    var response = await Dio().get("https://api.chucknorris.io/jokes/random");

    var responseMap = response.data as Map<String, dynamic>;

    return Joke.fromMap(responseMap);
  }
}
