import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitapp/bloc/products_bloc.dart';
import 'package:furnitapp/bloc/signIn.bloc.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/models/Produto.dart';
import 'package:furnitapp/page/signIn/signIn.page.dart';
import 'package:furnitapp/page/signUp/signUp.page.dart';

import 'category_list.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductsBloc _productsBloc;
  bool _displayLoading;

  @override
  void initState() {
    _displayLoading = false;
    _productsBloc = ProductsBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: kPrimaryColor,
          child: Column(
            children: [
              DrawerHeader(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white)),
            child: Text('Sair'),
            onPressed: () async {
              setState(() {
                _displayLoading = true;
              });
              await SignInBloc.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          CategoryList(),
          SizedBox(
            height: kDefaultPadding,
          ),
          Expanded(
            child: FutureBuilder(
                future: _productsBloc.getProductsList(),
                builder: (context, AsyncSnapshot<List<Produto>> snapshot) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => ProductCard(
                            produto: snapshot.data[index],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Produto produto;

  const ProductCard({
    Key key,
    @required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [kDefaultShadow],
                color: kBlueColor),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(22)),
            ),
          ),
          Positioned(
            top: 30,
            right: 0,
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(shape: BoxShape.circle),
              height: 120,
              width: 200,
              child: Image.network(this.produto.urlImage),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              width: MediaQuery.of(context).size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      this.produto.nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Text(this.produto.valor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}