import 'package:appbank/repositories/saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Transferencia extends StatefulWidget {
  const Transferencia({super.key});

  @override
  State<Transferencia> createState() => _TransferenciaState();
}

class _TransferenciaState extends State<Transferencia> {
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  final _conta = TextEditingController();

  finalizar() {
    if (_form.currentState!.validate()) {
      String valorTexto = _valor.text;
      double valorDouble = double.parse(valorTexto);
      context.read<Saldo>().subtrair(valor: valorDouble);
      _showConfirmationCard(_conta.text, _valor.text);
    }
  }

  void _showConfirmationCard(String conta, String valor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Transferência concluída\ncom sucesso',
              style: TextStyle(color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, 
            height: MediaQuery.of(context).size.height * 0.1, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Número da Conta: $conta',
                  style: TextStyle(fontSize: 18), 
                ),
                SizedBox(height: 10), 
                Text(
                  'Valor transferido: R\$ $valor',
                  style: TextStyle(fontSize: 18), 
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Share.share('Transferência concluída!\nNúmero da Conta: $conta\nValor Transferido: R\$ $valor');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.orange, 
              ),
              child: Text('Compartilhar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Transferência')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _conta,
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Conta',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe uma conta';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _valor,
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor',
                      prefixIcon: Text('  R\$'),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      String valorTexto = _valor.text;
                      double valorDouble = double.parse(valorTexto);

                      if (value!.isEmpty) {
                        return 'Informe um valor';
                      } else if (valorDouble > context.read<Saldo>().saldo) {
                        return 'Saldo Insuficiente';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: finalizar,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 13, bottom: 10, right: 5),
                      child: Text('Concluir', style: TextStyle(fontSize: 20)),
                    ),
                    Icon(Icons.check),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
