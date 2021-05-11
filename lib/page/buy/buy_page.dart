import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/models/Produto.dart';
import 'package:furnitapp/page/cart/cart_bloc.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final ScrollController _scrollController = ScrollController();
  double _value;

  @override
  void initState() {
    _value = CartBloc.totalValueInCart;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: ListView(
            controller: _scrollController,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: SvgPicture.asset('assets/creditcard.svg'),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Número do cartão',
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: 'XXXX.XXXX.XXXX.XXXX',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kPrimaryColor, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome no cartão',
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: 'Nome',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Validade',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintText: 'MM/AA',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'CVV',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintText: 'CVV',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: DropdownButton(
                          onChanged: (value) {
                            setState(() {
                              this._value = value;
                            });
                          },
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              value: CartBloc.totalValueInCart,
                              child: Text('R\$ ${CartBloc.totalValueInCart} x 1'),
                            ),
                            DropdownMenuItem(
                              value: CartBloc.totalValueInCart / 2,
                              child: Text('R\$ ${(CartBloc.totalValueInCart/2).truncateToDouble()} x 2'),
                            ),
                            DropdownMenuItem(
                              value: CartBloc.totalValueInCart / 3,
                              child: Text('R\$ ${(CartBloc.totalValueInCart/3).truncateToDouble()} x 3'),
                            ),
                             DropdownMenuItem(
                              value: CartBloc.totalValueInCart / 4,
                              child: Text('R\$ ${(CartBloc.totalValueInCart/4).truncateToDouble()} x 4'),
                            ),
                             DropdownMenuItem(
                              value: CartBloc.totalValueInCart / 5,
                              child: Text('R\$ ${(CartBloc.totalValueInCart/5).truncateToDouble()} x 5'),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => kSecondaryColor),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Confirmar'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
