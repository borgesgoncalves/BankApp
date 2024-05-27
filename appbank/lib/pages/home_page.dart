import 'package:appbank/repositories/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var saldo = context.watch<Saldo>().saldo;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Home')),
      body: SizedBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Conta'),
          Text(saldo.toStringAsFixed(2).replaceAll('.', ','))
        ],
      )),
      floatingActionButton: FloatingActionButton.large(
          child: Text('Transferir'),
          onPressed: () {
            Navigator.of(context).pushNamed('/Transferencia');
          }),
    );
  }
}
