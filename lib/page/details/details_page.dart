import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/models/Produto.dart';
import 'package:furnitapp/page/cart/cart_bloc.dart';
import 'package:furnitapp/page/cart/cart_page.dart';

class DetailsScreen extends StatefulWidget {
  final Produto produto;

  const DetailsScreen({Key key, @required this.produto}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool checkProcutInCart() {
    return CartBloc.selectedProducts.contains(widget.produto);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: BackButton(
          color: Colors.grey,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var response = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );

              if (response) {
                setState(() {});
              }
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  height: _size.width * 0.6,
                  clipBehavior: Clip.hardEdge,
                  width: _size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Image.network(
                    widget.produto.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      widget.produto.nome,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      'R\$ ' + widget.produto.valor.toString(),
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    if (checkProcutInCart()) {
                      setState(() {
                        CartBloc.removeProduct = widget.produto;
                      });
                    } else {
                      setState(() {
                        CartBloc.addProduct = widget.produto;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: checkProcutInCart()
                          ? Colors.green
                          : Colors.yellow[700],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          checkProcutInCart()
                              ? 'Remover do carrinho'
                              : 'Adicionar ao carrinho',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
