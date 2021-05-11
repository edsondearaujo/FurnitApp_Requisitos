import 'package:furnitapp/models/Produto.dart';

class CartBloc {
  static List<Produto> _selectedProdutcs = [];

  static List<Produto> get selectedProducts => _selectedProdutcs;

  static set addProduct(Produto produto) {
    if (_selectedProdutcs == null)
      _selectedProdutcs = [produto];
    else
      _selectedProdutcs.add(produto);
  }

  static set removeProduct(Produto produto) {
    _selectedProdutcs
        .removeWhere((produtoIndex) => produtoIndex.id == produto.id);
  }

  static double get totalValueInCart {
    double total = 0;
    for (Produto produto in _selectedProdutcs) {
      total += double.parse(produto.valor);
    }
    return total;
  }
}
