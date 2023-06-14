import 'package:json_annotation/json_annotation.dart';
part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  Map<String, dynamic> coord;
  List<Map<String, dynamic>> weather;
  String base;
  Map<String, dynamic> main;
  int visibility;
  Map<String, dynamic> wind;
  Map<String, dynamic> clouds;
  int dt;
  Map<String, dynamic> sys;
  int timezone;
  int id;
  String name;
  int cod;
  String dt_txt;

  WeatherData({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.dt_txt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}