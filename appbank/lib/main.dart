import 'dart:js';

import 'package:appbank/pages/cotacao.dart';
import 'package:appbank/pages/home_page.dart';
import 'package:appbank/pages/login_page.dart';
import 'package:appbank/pages/transferencia.dart';
import 'package:appbank/repositories/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => Saldo(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Bank',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: Login(),
        routes: {
          '/Transferencia': (context) => Transferencia(),
          '/Home': (context) => Home(),
          '/Cotacao': (context) => TelaCota()
        });
  }
}
