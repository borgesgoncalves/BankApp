import 'package:appbank/repositories/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var saldo = context.watch<Saldo>().saldo;

    return Scaffold(
      appBar: AppBar(
          title: Text(
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              'Bem vindo!'),
          backgroundColor: Colors.orange.shade700),
      body: SizedBox(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  'Saldo Atual'),
              Text(
                  style: TextStyle(fontSize: 20),
                  saldo.toStringAsFixed(2).replaceAll('.', ','))
            ],
          ),
        ),
      )),
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
            backgroundColor: Colors.orange.shade400,
            splashColor: Colors.orange.shade900,
            child: Text(
                style: TextStyle(fontSize: 20, color: Colors.white),
                'Transferir'),
            onPressed: () {
              Navigator.of(context).pushNamed('/Transferencia');
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: "Cotação")
        ],
        onTap: (value) {
          if (value == 1) {
            Navigator.of(context).pushNamed('/Cotacao');
          }
        },
      ),
    );
  }
}
