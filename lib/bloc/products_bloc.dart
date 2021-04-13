import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsBloc {

  Future<QuerySnapshot> getProductsList() async {
    
    return await FirebaseFirestore.instance.collection('Produtos').get();
  }
}
