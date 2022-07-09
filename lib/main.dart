import 'package:cryptobloc/repositories/crypto_repository.dart';
import 'package:cryptobloc/screens/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/crypto/crypto_bloc.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CryptoRepository(),
      child: MaterialApp(
        title: 'Flutter Crypto Bloc App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.tealAccent,
        ),
        home: BlocProvider(
          create: (context) =>
          CryptoBloc(
            cryptoRepository: context.read<CryptoRepository>(),
          )
            ..add(AppStarted()),
          child: HomeScreen(),
        ),
      ),
    );
  }
}