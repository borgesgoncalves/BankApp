import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaCota extends StatefulWidget {
  const TelaCota({Key? key}) : super(key: key);

  @override
  _TelaCotaState createState() => _TelaCotaState();
}

class _TelaCotaState extends State<TelaCota> {
  Map<String, dynamic>? exchangeRates;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(
        'https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL,BTC-BRL,GBP-BRL,AUD-BRL,CAD-BRL,JPY-BRL,CHF-BRL,CNY-BRL'));

    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Falha ao carregar a taxa de câmbio');
    }
  }

  IconData? getCurrencyIcon(String code) {
    switch (code.toUpperCase()) {
      case 'USD':
        return Icons.attach_money;
      case 'EUR':
        return Icons.euro_symbol; // Ícone do Euro
      case 'BTC':
        return Icons.monetization_on; // Ícone do Bitcoin
      case 'GBP':
        return Icons.attach_money;
      case 'AUD':
        return Icons.attach_money;
      case 'CAD':
        return Icons.attach_money;
      case 'JPY':
        return Icons.attach_money;
      case 'CHF':
        return Icons.attach_money;
      case 'CNY':
        return Icons.attach_money;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              'Cotação de Moedas'),
          backgroundColor: Colors.orange.shade700,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  buildExchangeRateTile(
                      'USD', 'Dólar Americano', exchangeRates!['USDBRL']),
                  buildExchangeRateTile(
                      'EUR', 'Euro', exchangeRates!['EURBRL']),
                  buildExchangeRateTile(
                      'BTC', 'Bitcoin', exchangeRates!['BTCBRL']),
                  buildExchangeRateTile(
                      'GBP', 'Libra Esterlina', exchangeRates!['GBPBRL']),
                  buildExchangeRateTile(
                      'AUD', 'Dólar Australiano', exchangeRates!['AUDBRL']),
                  buildExchangeRateTile(
                      'CAD', 'Dólar Canadense', exchangeRates!['CADBRL']),
                  buildExchangeRateTile(
                      'JPY', 'Iene Japonês', exchangeRates!['JPYBRL']),
                  buildExchangeRateTile(
                      'CHF', 'Franco Suíço', exchangeRates!['CHFBRL']),
                  buildExchangeRateTile(
                      'CNY', 'Yuan Chinês', exchangeRates!['CNYBRL']),
                ],
              ));
  }

  Widget buildExchangeRateTile(String code, String name, dynamic rateData) {
    IconData? currencyIcon = getCurrencyIcon(code);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: Icon(currencyIcon, color: Colors.indigo),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListTile(
            title: Text('Compra: R\$ ${rateData['bid']}'),
            subtitle: Text('Venda: R\$ ${rateData['ask']}'),
          ),
          ListTile(
            title: Text('Variação Percentual: ${rateData['pctChange']}%'),
            leading: Icon(Icons.trending_up),
          ),
          ListTile(
            title: Text('Última Atualização: ${rateData['timestamp']}'),
            leading: Icon(Icons.access_time),
          ),
        ],
      ),
    );
  }
}
