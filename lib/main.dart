import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_game/bloc/app_initialize_bloc.dart';
import 'package:word_game/pages/index.dart';
import 'package:word_game/pages/login_page.dart';
import 'package:word_game/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(BlocProvider<AppInitializeBloc>(
      create: (context) {
        log("message");
        return AppInitializeBloc()..add(AppStarted());
      },
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Worena',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/bg.png'),
              ),
            ),
            child: BlocBuilder<AppInitializeBloc, AppInitializeState>(
              builder: (context, state) {
                if (state is AppInitializeLoading) {
                  return SplashScreenPage();
                }
                if (state is AppInitializeHomePage) {
                  return Index(title: 'Worena');
                }
                if (state is AppInitializeLoginPage) {
                  return LoginPage();
                }
                return SplashScreenPage();
              },
            ),
          ),
        ));
  }
}
