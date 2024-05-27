import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double saldo;

  Saldo({this.saldo = 100.00});

  void subtrair({
    required double valor,
  }) async {
    if (valor <= saldo) {
      saldo = saldo - valor;
      notifyListeners();
    }
  }
}
