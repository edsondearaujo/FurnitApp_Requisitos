import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furnitapp/models/Produto.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _corController = TextEditingController();

  String _value;

  saveProduct() {
    Produto produto = Produto();
    produto.codigo = _codigoController.text;
    produto.nome = _nomeController.text;
    produto.descricao = _descricaoController.text;
    produto.categoria = _value;
    produto.valor = _valorController.text;
    produto.cor = _corController.text;
    produto.save();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Produto"),
      ),
      body: Form(
        child: ListView(
         padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Código'
              ),
              keyboardType: TextInputType.number,
              controller: _codigoController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome'
              ),
              keyboardType: TextInputType.name,
              controller: _nomeController,
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: DropdownButton(
                value: _value,
                isExpanded: true,
                hint: Text("Selecione Categoria"),
                items: [
                  'Sala',
                  'Cozinha',
                  'Quarto'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style:TextStyle(color:Colors.black),),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descrição'
              ),
              keyboardType: TextInputType.multiline,
              controller: _descricaoController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Valor'
              ),
              keyboardType: TextInputType.number,
              controller: _valorController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cor'
              ),
              controller: _corController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check), onPressed: saveProduct),
    );
  }
}