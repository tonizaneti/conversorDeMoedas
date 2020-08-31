import 'package:flutter/material.dart';
class Conversor extends StatefulWidget {
  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController _realController = TextEditingController();
  final TextEditingController _dollarController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _conversion='';
  _onItemTapped(int index){
    debugPrint(index.toString());
    if(index==0){
      _realController.clear();
      _dollarController.clear();
      setState(() {
        _conversion='';
      });
    }
    else if(_realController.text.isEmpty || _dollarController.text.isEmpty){
      key.currentState.showSnackBar(SnackBar(
        content: Text('Valor em Real e Cotação do Dolar São Obrigatórios'),
      ));
    }
    else{
      try{
        var dollar = double.parse(_dollarController.text);
        var real = double.parse(_realController.text);
        var equivalente = real/dollar;
        setState(() {
          _conversion = "Com ${real.toStringAsFixed(2)} reais é possível comprar ${equivalente.toStringAsFixed(2)} dólares a  ${dollar.toStringAsFixed(2)} cada";
          //Com 100 reais é possivel comprar 18.45 dólares a 5.42 cada
          });

      }catch(e){
        key.currentState.showSnackBar(SnackBar(
          content: Text('Real  ou Dolar foi informado em formato inválido'),
        ));
      }
      //debugPrint(imc.toStringAsFixed(2));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:key,
      appBar: AppBar(title: Text("Conversor de Moedas - Toni Zaneti", style: TextStyle(color: Colors.green)), backgroundColor: Colors.yellowAccent),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/money.png", width: 90),
          TextField(
            controller: _realController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Reais',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                icon: Icon(Icons.monetization_on)),
          ),
          TextField(
            controller: _dollarController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Cotação do Dollar',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                icon: Icon(Icons.attach_money)
            ),
          ),
          //Text('$_resultado', style: TextStyle(fontSize:30 ),),
          Text('$_conversion', style: TextStyle(fontSize:30 ),)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        onTap:_onItemTapped,

        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.clear, color: Colors.white),
              title: Text("Limpar", style: TextStyle(color: Colors.white, fontSize: 20),)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon:Icon(Icons.check, color: Colors.white),
              title: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20),)

          )
        ],
      ),
    );
  }
}

