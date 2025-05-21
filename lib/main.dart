import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SimuladorFinanciamentoApp());
}

class SimuladorFinanciamentoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Financiamento',
      home: SimuladorFinanciamento(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimuladorFinanciamento extends StatefulWidget {
  @override
  _SimuladorFinanciamentoState createState() => _SimuladorFinanciamentoState();
}

class _SimuladorFinanciamentoState extends State<SimuladorFinanciamento> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _taxaController = TextEditingController();
  final TextEditingController _parcelasController = TextEditingController();
  final TextEditingController _custosController = TextEditingController();

  double _valorTotal = 0;
  double _valorParcela = 0;

  void _calcularFinanciamento() {
    double valor = double.tryParse(_valorController.text) ?? 0;
    double taxa =
        double.tryParse(_taxaController.text.replaceAll('%', '')) ?? 0;
    int parcelas = int.tryParse(_parcelasController.text) ?? 0;
    double custos = double.tryParse(_custosController.text) ?? 0;

    double taxaDecimal = taxa / 100;

    if (taxaDecimal == 0) {
      _valorParcela = (valor + custos) / parcelas;
    } else {
      _valorParcela =
          (valor * taxaDecimal * pow(1 + taxaDecimal, parcelas)) /
          (pow(1 + taxaDecimal, parcelas) - 1);
    }

    _valorTotal = _valorParcela * parcelas + custos;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EF),
      appBar: AppBar(
        title: Text('Simulador de Financiamento'),
        backgroundColor: Color.fromARGB(255, 196, 143, 127),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 8),
            Text(
              'Valor do financiamento:',
              style: TextStyle(color: Colors.blue[900]),
            ),
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Taxa de juros ao mês:',
              style: TextStyle(color: Colors.blue[900]),
            ),
            TextField(
              controller: _taxaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite a taxa de juros',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Número de parcelas:',
              style: TextStyle(color: Colors.blue[900]),
            ),
            TextField(
              controller: _parcelasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o número de parcelas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Demais taxas e custos:',
              style: TextStyle(color: Colors.blue[900]),
            ),
            TextField(
              controller: _custosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o total de taxas e custos adicionais',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 189, 125, 104),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: _calcularFinanciamento,
              child: Text('Calcular'),
            ),
            SizedBox(height: 32),
            Text(
              'Valor total a ser pago: R\$ ${_valorTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            ),
            SizedBox(height: 8),
            Text(
              'Valor da parcela: R\$ ${_valorParcela.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            ),
          ],
        ),
      ),
    );
  }
}
