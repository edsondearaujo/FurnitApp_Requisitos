import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  var id;
  var codigo;
  var nome;
  var descricao;
  var valor;
  var cor;
  var categoria;
  var urlImage;

  Produto(
      {this.codigo,
      this.nome,
      this.descricao,
      this.valor,
      this.cor,
      this.categoria,
      this.urlImage,
      this.id});

  save() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference colRef = db.collection("Produtos");
    DocumentReference docRef = await colRef.add(this.toMap());
    this.id = docRef.id;
    docRef.set(this.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "codigo": this.codigo,
      "nome": this.nome,
      "categoria": this.categoria,
      "descricao": this.descricao,
      "valor": this.valor,
      "cor": this.cor,
      "urlImage": this.urlImage,
    };
    return map;
  }
}
