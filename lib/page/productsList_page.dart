import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitapp/models/Produto.dart';
import 'package:furnitapp/page/new_product.dart';
import 'new_product.dart';

class Estoque extends StatefulWidget {
  @override
  _EstoqueState createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;

  _addProductsListener() {
    final stream = db.collection("Produtos").orderBy("codigo").snapshots();

    stream.listen((event) {
      _controller.add(event);
    });
  }

  @override
  void initState() {
    _addProductsListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estoque"),
      ),
      body: productsList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewProduct()));
        },
      ),
    );
  }

  Widget productsList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Carregando produtos"),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("Erro ao carregar produtos!");
              } else {
                QuerySnapshot querySnapshot = snapshot.data;
                return ListView.builder(
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (_, index) {
                      List<DocumentSnapshot> products =
                      querySnapshot.docs.toList();
                      DocumentSnapshot item = products[index];

                      String urlImage = item.data()["urlImage"];
                      String codigo = item.data()["codigo"];
                      String nome = item.data()["nome"];
                      String valor = item.data()["valor"];

                      Produto produto = Produto();
                      produto.urlImage = urlImage;
                      produto.codigo = codigo;
                      produto.nome = nome;
                      produto.valor = valor;

                      return Column(
                        children: [
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration:
                                  BoxDecoration(color: Colors.blueGrey),
                                  child: produto.urlImage != null
                                      ? Image.network(produto.urlImage)
                                      : null),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(produto.nome),
                            ),
                            subtitle: Row(
                              children: [Text(produto.valor)],
                            ),
                            trailing: Text("#" + produto.codigo),
                          ),
                        ],
                      );
                    });
              }
          }
          return Container();
        });
  }