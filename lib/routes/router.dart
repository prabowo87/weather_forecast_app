
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:weather_forecast_app/routes/router.gr.dart';

import '../main.dart';
// import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: WeatherRoute.page, initial: true),

    // MaterialRoute(page: DetailedWeatherScreen),
  ];
}