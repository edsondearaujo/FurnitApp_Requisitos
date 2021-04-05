import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  var id;
  var codigo;
  var nome;
  var descricao;
  var valor;
  var cor;
  var categoria;
  var avatarImage;
  List<String> urlImages;

  Produto();

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
      "avatarImage": this.avatarImage,
      "urlImages": this.urlImages
    };
    return map;
  }
}
