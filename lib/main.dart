import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:auto_route/auto_route.dart';
import 'package:weather_forecast_app/routes/router.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'bloc/weather_bloc.dart';
import 'constants/constants.dart';
import 'routes/router.gr.dart';
void main() {
  runApp(WeatherForecastApp());
}

class WeatherForecastApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
      title: 'Weather Forecast App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: AutoRouterDelegate(_appRouter),
    routeInformationParser: _appRouter.defaultRouteParser(),
      // routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
@RoutePage()
class WeatherScreen extends StatefulWidget implements AutoRouteWrapper{
  @override
  _WeatherScreenState createState() => _WeatherScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    // TODO: implement wrappedRoute
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child:  this, // this as the child Important!
    );

  }
}
class _WeatherScreenState_ extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App Forecast"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(),

              ),
            ),
            Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(_cityController.text));
                    }
                     //AutoRouter.of(context).push(DetailedWeatherRoute(city: _cityController.text));
                    // BlocProvider.of<WeatherBloc>(context,listen: false).add(FetchWeatherEvent(_cityController.text));

                  },
                  child: Text("Get Weather"),
                )
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else  if (state is WeatherLoadedState) {
                  final weatherData = state.weatherData;
                  return Flexible(
                    child: Column(
                      children: [

                        Text(
                          '${weatherData.name}',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${weatherData.main['temp'].toString()}",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                } else if (state is WeatherErrorState) {
                  return Center(
                    child: Text('Error: ${state.error}'),
                  );
                }
                return Container();
              }
            ),



          ],
        ),
      ),
    );
  }
}
class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent('ponorogo'));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body:Container(
          padding: EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.fromARGB(255, 65, 89, 224),
                Color.fromARGB(255, 83, 92, 215),
                Color.fromARGB(255, 86, 88, 177),
                Color(0xfff39060),
                Color(0xffffb56b),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              children: [
                AnimSearchBar(
                  rtl: true,
                  width:400,
                  color: Color(0xffffb56b),
                  textController: _cityController,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22,
                  ),
                  onSuffixTap: () async {

                    if (_cityController.text.isNotEmpty) {
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(_cityController.text));
                    }
                    FocusScope.of(context).unfocus();
                    _cityController.clear();

                  },
                  style:f14RblackLetterSpacing2,
                  onSubmitted: (String ) {
                    if (String.isNotEmpty) {
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(String));
                    }
                    FocusScope.of(context).unfocus();
                    _cityController.clear();
                  },
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoadingState) {
                      return Center(
                          child: CircularProgressIndicator(),
                      );
                    }else  if (state is WeatherLoadedState) {
                      final weatherData = state.weatherData;
                      final weatherDataList = state.weatherDataList;
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${weatherData.name}',
                              style: f24Rwhitebold,
                            ),
                            height25,
                            Image.network('https://openweathermap.org/img/wn/${weatherData.weather.length>0 ? weatherData.weather[0]['icon']+'.png':''}'),
                            height25,
                            Text(
                              '${weatherData.weather.length>0 ? weatherData.weather[0]['description']:"-"}',
                              style: f16PW,
                            ),
                            height25,
                            Text(
                              "${weatherData.main['temp'].toString()}°C",
                              style: f42Rwhitebold,
                            ),
                            Expanded(
                                child: Card(
                                    color: Colors.lightBlueAccent,
                                    shadowColor: Colors.lightBlue,
                                    elevation: 5,

                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,

                                        itemCount: weatherDataList.length,
                                        itemBuilder: (context, index) {
                                          final forecastItem = weatherDataList[index];
                                          if (index==0){
                                            return Column(
                                              children: [
                                                Text('5 - Day Forecast',style: f14PWBold,),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        '${forecastItem.dt_txt}',
                                                        style: f12PW,
                                                      ),
                                                       flex:0,
                                                    ),
                                                    Flexible(
                                                      child: Image.network('https://openweathermap.org/img/wn/${forecastItem.weather.length>0 ? forecastItem.weather[0]['icon']+'.png':''}'),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${forecastItem.main['temp_min']} °C',
                                                        style: f12PW,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(10.0),
                                                      decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: <Color>[
                                                            Colors.red,
                                                            Color(0xfff39060),
                                                            Color(0xffffb56b),
                                                          ],
                                                        ),
                                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                                      ),
                                                      width: 50.0,
                                                      height: 5.0,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${forecastItem.main['temp_max']} °C',
                                                        style: f12PW,
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                )
                                              ],
                                            );
                                          }else{
                                            return Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${forecastItem.dt_txt}',
                                                    style: f12PW,

                                                  ),
                                                  flex:0,
                                                ),
                                                Flexible(
                                                  child: Image.network('https://openweathermap.org/img/wn/${forecastItem.weather.length>0 ? forecastItem.weather[0]['icon']+'.png':''}'),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${forecastItem.main['temp_min']} °C',
                                                    style: f12PW,
                                                  ),

                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: <Color>[
                                                        Colors.red,
                                                        Color(0xfff39060),
                                                        Color(0xffffb56b),
                                                      ],
                                                    ),
                                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                                  ),
                                                  width: 50.0,
                                                  height: 5.0,

                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${forecastItem.main['temp_max']} °C',
                                                    style: f12PW,
                                                  ),
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            );
                                          }


                                        },
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                      );
                    } else if (state is WeatherErrorState) {
                      return Center(
                        child: Text('Error: ${state.error}'),
                      );
                    }
                    return Container();
                  }
                )

              ],
            ),
          ),
        )
    );
  }
}

@RoutePage()
class DetailedWeatherScreen extends StatelessWidget {
  final String city;

  DetailedWeatherScreen( {required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Weather'),
      ),
      body: Center(
        child: Text('City: $city'),
      ),
    );
  }
}
