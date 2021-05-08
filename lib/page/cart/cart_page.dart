import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/page/cart/cart_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    bool _cartIsNotEmpty = CartBloc.selectedProducts != null &&
        CartBloc.selectedProducts.isNotEmpty;

    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context, true);
          },
          color: Colors.grey,
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: _size.height * 0.7,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: _cartIsNotEmpty
                  ? ListView.builder(
                      itemCount: CartBloc.selectedProducts.length,
                      itemBuilder: (context, index) => ListTile(
                          leading: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                                CartBloc.selectedProducts[index].urlImage),
                          ),
                          title: Text(CartBloc.selectedProducts[index].nome),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              setState(() {
                                CartBloc.selectedProducts.removeWhere(
                                    (product) => product.id == value);
                              });
                            },
                            child: Icon(Icons.more_vert),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: CartBloc.selectedProducts[index].id,
                                  child: Text('Remover produto'),
                                )
                              ];
                            },
                          )),
                    )
                  : Center(
                      child: Text(
                        'Não há produtos aqui ainda',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Comprar',
                          style: TextStyle(
                            color: _cartIsNotEmpty ? Colors.grey : Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.credit_card,
                          color: _cartIsNotEmpty ? Colors.grey : Colors.white,
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
