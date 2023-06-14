import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../models/weather_data.dart';

// Define the WeatherBloc events
abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;

  FetchWeatherEvent(this.cityName);
}

// Define the WeatherBloc states
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherData weatherData;
  final List<WeatherData> weatherDataList;

  WeatherLoadedState(this.weatherData,this.weatherDataList);
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}

// Define the WeatherBloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();

      try {
        final weatherData = await _fetchWeatherData(event.cityName);
        List<WeatherData> weatherDataList = await _fetchWeatherDataList(event.cityName);
        yield WeatherLoadedState(weatherData,weatherDataList);
      } catch (error) {
        yield WeatherErrorState(error.toString());
      }
    }
  }

  Future<WeatherData> _fetchWeatherData(String cityName) async {
    try{
      final response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=2b955a8361013bacfb050d4b42b35dd4');

      final json = response.data;
      final WeatherData weather = WeatherData.fromJson(json);
      return weather;
    }on DioError catch (error) {
      if (error.response != null) {
        // DioError with a response (e.g., 4xx or 5xx status code)
        throw Exception('${error.response?.data['message']}');
      } else {
        // DioError without a response (e.g., network error)
        throw Exception('Failed to fetch weather data. Error: ${error.message}');
      }
    }




  }
  Future<List<WeatherData>> _fetchWeatherDataList(String cityName) async {
    try{
      final response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=2b955a8361013bacfb050d4b42b35dd4');

      final json = response.data;
      final List<WeatherData> weather = json['list'].map<WeatherData>((i) => WeatherData.fromJson(i))
          .toList();
      List<WeatherData> weatherList=[] ;
      String date_text='';
      for (var element in weather) {
        final int millis = (element.dt as int) * 1000;
        var dt = DateTime.fromMillisecondsSinceEpoch(millis);
        String d12 = DateFormat('dd-MM-yyyy').format(dt);
        if (date_text!=d12){
          date_text=d12;
          element.dt_txt=date_text;
          if (weatherList.length<6)
            weatherList.add(element);
          else break;
        }
      };
      return weatherList;
    }on DioError catch (error) {
      if (error.response != null) {
        // DioError with a response (e.g., 4xx or 5xx status code)
        throw Exception('${error.response?.data['message']}');
      } else {
        // DioError without a response (e.g., network error)
        throw Exception('Failed to fetch weather data. Error: ${error.message}');
      }
    }


  }
}