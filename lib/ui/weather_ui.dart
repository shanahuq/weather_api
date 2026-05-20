import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:weather_api/bloc/weather_bloc/bloc/weather_list_bloc.dart';

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  @override
  void initState() {
    super.initState();

    context.read<WeatherListBloc>().add(FetchWeatherListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1B3B5A), Color(0xff287299), Color(0xff4FC3F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: BlocBuilder<WeatherListBloc, WeatherListState>(
            builder: (context, state) {
              /// LOADING
              if (state is WeatherListBlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              /// ERROR
              if (state is WeatherListBlocError) {
                return Center(
                  child: Text(
                    'Something Went Wrong',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              /// LOADED
              if (state is WeatherListBlocLoaded) {
                final weather = state.weatherModel;

                final weatherData = weather.weather?.first;

                final icon = weatherData?.icon ?? "01d";

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),

                    child: Column(
                      children: [
                        SizedBox(height: 20.h),

                        /// LOCATION
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.white),

                            SizedBox(width: 5.w),

                            Text(
                              weather.name ?? "Unknown",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        /// DATE
                        Text(
                          "Today's Weather",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.sp,
                          ),
                        ),

                        SizedBox(height: 25.h),

                        /// WEATHER ICON
                        Image.network(
                          "assets/images (14).jpg",
                          width: 180.w,
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),

                        /// TEMPERATURE
                        Text(
                          "${weather.main?.temp?.toStringAsFixed(1) ?? "--"}°C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 65.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        /// DESCRIPTION
                        Text(
                          weatherData?.description?.toUpperCase() ?? "NO DATA",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),

                        SizedBox(height: 35.h),

                        /// MAIN DETAILS CARD
                        Container(
                          width: double.infinity,

                          padding: EdgeInsets.all(22.w),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(30.r),
                          ),

                          child: Column(
                            children: [
                              weatherTile(
                                Icons.thermostat,
                                "Feels Like",
                                "${weather.main?.feelsLike?.toStringAsFixed(1) ?? "--"} °C",
                              ),

                              divider(),

                              weatherTile(
                                Icons.water_drop,
                                "Humidity",
                                "${weather.main?.humidity?.toString() ?? "--"} %",
                              ),

                              divider(),

                              weatherTile(
                                Icons.air,
                                "Wind Speed",
                                "${weather.wind?.speed?.toString() ?? "--"} m/s",
                              ),

                              divider(),

                              weatherTile(
                                Icons.arrow_downward,
                                "Min Temp",
                                "${weather.main?.tempMin?.toStringAsFixed(1) ?? "--"} °C",
                              ),

                              divider(),

                              weatherTile(
                                Icons.arrow_upward,
                                "Max Temp",
                                "${weather.main?.tempMax?.toStringAsFixed(1) ?? "--"} °C",
                              ),

                              divider(),

                              weatherTile(
                                Icons.compress,
                                "Pressure",
                                "${weather.main?.pressure?.toString() ?? "--"} hPa",
                              ),

                              divider(),

                              weatherTile(
                                Icons.visibility,
                                "Visibility",
                                "${weather.visibility?.toString() ?? "--"} m",
                              ),

                              divider(),

                              weatherTile(
                                Icons.cloud,
                                "Cloudiness",
                                "${weather.clouds?.all?.toString() ?? "--"} %",
                              ),

                              divider(),

                              weatherTile(
                                Icons.public,
                                "Country",
                                weather.sys?.country ?? "--",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(color: Colors.white.withOpacity(0.2)),
    );
  }

  Widget weatherTile(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 22.sp),

        SizedBox(width: 12.w),

        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
