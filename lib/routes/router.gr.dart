// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:weather_forecast_app/main.dart' as _i1;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    WeatherRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.WeatherScreen(),
      );
    },
    DetailedWeatherRoute.name: (routeData) {
      final args = routeData.argsAs<DetailedWeatherRouteArgs>();
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DetailedWeatherScreen(city: args.city),
      );
    },
  };
}

/// generated route for
/// [_i1.WeatherScreen]
class WeatherRoute extends _i2.PageRouteInfo<void> {
  const WeatherRoute({List<_i2.PageRouteInfo>? children})
      : super(
          WeatherRoute.name,
          initialChildren: children,
        );

  static const String name = 'WeatherRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}

/// generated route for
/// [_i1.DetailedWeatherScreen]
class DetailedWeatherRoute extends _i2.PageRouteInfo<DetailedWeatherRouteArgs> {
  DetailedWeatherRoute({
    required String city,
    List<_i2.PageRouteInfo>? children,
  }) : super(
          DetailedWeatherRoute.name,
          args: DetailedWeatherRouteArgs(city: city),
          initialChildren: children,
        );

  static const String name = 'DetailedWeatherRoute';

  static const _i2.PageInfo<DetailedWeatherRouteArgs> page =
      _i2.PageInfo<DetailedWeatherRouteArgs>(name);
}

class DetailedWeatherRouteArgs {
  const DetailedWeatherRouteArgs({required this.city});

  final String city;

  @override
  String toString() {
    return 'DetailedWeatherRouteArgs{city: $city}';
  }
}
