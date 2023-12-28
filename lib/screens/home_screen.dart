import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skystream/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/images/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/images/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/images/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/images/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/images/5.png');
      case == 800:
        return Image.asset('assets/images/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/images/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: BlocConsumer(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<WeatherBloc>()
                      .add(FetchWeather(position: state.position));
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(3, -0.3),
                        child: Container(
                          height: 280,
                          width: 300,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 79, 141, 255),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 300,
                          width: 600,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 21, 13, 4),
                          ),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              'SkyStream 👋',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            getWeatherIcon(state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                DateFormat('EEEE dd •')
                                    .add_jm()
                                    .format(state.weather.date!),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/11.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunset',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/13.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Max',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} °C",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/14.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Min',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} °C",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
