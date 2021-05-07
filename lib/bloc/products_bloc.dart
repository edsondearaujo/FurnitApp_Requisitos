import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitapp/models/Produto.dart';

class ProductsBloc {
  Future<List<Produto>> getProductsList({String category = ''}) async {
    List<Produto> _produtos = [];
    if (category == 'Tudo') {
      QuerySnapshot _querySnapshot =
          await FirebaseFirestore.instance.collection('Produtos').get();
      await Future.forEach(
        _querySnapshot.docs,
        (DocumentSnapshot documentSnpshot) => _produtos.add(
          Produto(
            id: documentSnpshot.id,
            nome: documentSnpshot.data()['nome'],
            urlImage: documentSnpshot.data()['urlImage'],
            categoria: documentSnpshot.data()['categoria'],
            codigo: documentSnpshot.data()['codigo'],
            cor: documentSnpshot.data()['cor'],
            descricao: documentSnpshot.data()['descricao'],
            valor: documentSnpshot.data()['valor'],
          ),
        ),
      );
    } else {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection('Produtos')
          .where('categoria', isEqualTo: category)
          .get();
      await Future.forEach(
        _querySnapshot.docs,
        (DocumentSnapshot documentSnpshot) => _produtos.add(
          Produto(
            id: documentSnpshot.id,
            nome: documentSnpshot.data()['nome'],
            urlImage: documentSnpshot.data()['urlImage'],
            categoria: documentSnpshot.data()['categoria'],
            codigo: documentSnpshot.data()['codigo'],
            cor: documentSnpshot.data()['cor'],
            descricao: documentSnpshot.data()['descricao'],
            valor: documentSnpshot.data()['valor'],
          ),
        ),
      );
    }

    return _produtos;
  }
}
