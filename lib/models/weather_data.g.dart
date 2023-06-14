
part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherFromJson(Map<String, dynamic> json) {
  return WeatherData(
    coord: json['coord']!=null ? json['coord'] :  {"lon": 111.462,
      "lat": -7.8685} as Map<String, dynamic> ,
    weather: json['weather']!=null ? (json['weather'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList() : [] ,
    base: json['base']!=null ? json['base'] : '' as String,
    main: json['main']?? json['main']  as Map<String, dynamic>,
    visibility: json['visibility']??json['visibility'] as int,
    wind: json['wind']??json['visibility'] as Map<String, dynamic>,
    clouds: json['clouds']??json['visibility'] as Map<String, dynamic>,
    dt: json['dt']??json['visibility'] as int,
    sys: json['sys']??json['visibility'] as Map<String, dynamic>,
    timezone: json['timezone']!=null ? json['timezone'] : 0 as int,
    id: json['id']!=null ? json['id'] : 0 as int,
    name: json['name']!=null ? json['name'] :'' as String,
    cod: json['cod']!=null ? json['cod'] : 0 as int,
    dt_txt: json['dt_txt']!=null ? json['dt_txt'] : '' as String,
  );
}

Map<String, dynamic> _$WeatherToJson(WeatherData instance) => <String, dynamic>{
  'coord': instance.coord,
  'weather': instance.weather,
  'base': instance.base,
  'main': instance.main,
  'visibility': instance.visibility,
  'wind': instance.wind,
  'clouds': instance.clouds,
  'dt': instance.dt,
  'sys': instance.sys,
  'timezone': instance.timezone,
  'id': instance.id,
  'name': instance.name,
  'cod': instance.cod,
  'dt_txt': instance.dt_txt,
};