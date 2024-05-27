import 'package:appbank/repositories/saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Transferencia extends StatefulWidget {
  const Transferencia({super.key});

  @override
  State<Transferencia> createState() => _TransferenciaState();
}

class _TransferenciaState extends State<Transferencia> {
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();

  finalizar() {
    if (_form.currentState!.validate()) {
      //recalcula saldo
      String valorTexto = _valor.text;
      double valorDouble = double.parse(valorTexto);
      context.read<Saldo>().subtrair(valor: valorDouble);

      //volta tela inicial e dispara mensagem
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tranferencia realizada')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Transferencia')),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Form(
                  key: _form,
                  child: TextFormField(
                    controller: _valor,
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor',
                      prefixIcon: Text('  R\$'),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe um valor';
                      }
                    },
                  )),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: finalizar,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: 13, bottom: 10, right: 5),
                          child:
                              Text('Concluir', style: TextStyle(fontSize: 15))),
                      Icon(Icons.check)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
