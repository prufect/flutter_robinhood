import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_robinhood/repositories/crypto_respository.dart';
import 'package:flutter_robinhood/screens/home_screen.dart';
import 'package:flutter_robinhood/screens/nav_screen.dart';
import 'package:flutter_robinhood/styles/styles.dart';

import 'blocs/crypto/crypto_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoBloc>(
      create: (_) => CryptoBloc(
        cryptoRepository: CryptoRepository(),
      )..add(AppStarted()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Styles.color_background,
          accentColor: Colors.tealAccent,
          fontFamily: Styles.fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NavScreen(),
      ),
    );
  }
}
