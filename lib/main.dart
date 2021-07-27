import 'dart:math';

import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',

      theme: ThemeData(
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
      ),

      home: TelaPrincipal(),

   )
  );

}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  //Armazer valores do peso e altura
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Calculadora IMC'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: (){
              //debugPrint("botão acionado.");

              setState(() {
                txtPeso.text = "";
                txtAltura.text = "";
              });

            }
          )
        ],
      ),

      backgroundColor: Theme.of(context).backgroundColor,
      
      body: 
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Form(

                key: formKey,

                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Icon(
                  Icons.people , 
                  size: 120, 
                  color: Theme.of(context).primaryColor
                ),

                campoTexto("Peso", txtPeso),
                campoTexto("Altura", txtAltura),
                botao("calcular"),

              ],
      ),
            ),
          ),
        ),

    );
  }

  //
  // CAMPO DE TEXTO
  //
  Widget campoTexto(rotulo, variavelControle){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(

        keyboardType: TextInputType.number,  

        controller: variavelControle,
        style: TextStyle(fontSize: 28),  

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
          ),
        ),

        validator: (value){
          return (double.tryParse(value) == null) ? 
              "Informe um valor numérico" : null;
        },

      ),
    );
  }

  //
  // BOTÃO
  //
  Widget botao(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: RaisedButton(
        child: Text(
          rotulo, 
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: (){
          //debugPrint("calcular");

          if (formKey.currentState.validate()){
            setState(() {
              double peso = double.parse(txtPeso.text);
              double altura = double.parse(txtAltura.text);
              double imc = peso / pow(altura,2);
              caixaDialogo('IMC: ${imc.toStringAsFixed(2)}');
            });
          }


        },
      ),
    );
  }

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(msg){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Resultado', style: TextStyle(fontSize: 12)),
          content: Text(msg, style: TextStyle(fontSize: 16)),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('fechar')
            )
          ],
        );
      }
    );
  }




}