import 'package:flutter/material.dart';
import 'package:furnitapp/LoggedUser.dart';
import 'package:furnitapp/bloc/products_bloc.dart';
import 'package:furnitapp/bloc/signIn.bloc.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/models/Produto.dart';
import 'package:furnitapp/page/details/details_page.dart';
import 'package:furnitapp/page/new_product.dart';
import 'package:furnitapp/page/productsList_page.dart';
import 'package:furnitapp/page/showProducts/product_card.dart';
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
  ValueNotifier<String> _selectedcategory;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _selectedcategory = ValueNotifier('Sala');
    _displayLoading = false;
    _productsBloc = ProductsBloc();
    _selectedcategory.addListener(() {
      setState(() {});
    });
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Container(),
              ),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewProduct(),
                    ),
                  );
                },
                child: Text('Adicionar produtos'),
              ),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Estoque(),
                    ),
                  );
                },
                child: Text('Lista de produtos'),
              )
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        leading: LoggedUser.user != null && LoggedUser.fuser.isAdmin
            ? IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(Icons.menu),
              )
            : Container(),
        actions: [
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white)),
            child: Text(
              LoggedUser.user == null ? 'Entrar' : 'Sair',
              style: TextStyle(color: Colors.grey[300]),
            ),
            onPressed: () async {
              setState(() {
                _displayLoading = true;
              });
              if (LoggedUser.user == null) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              } else {
                await SignInBloc.signOut();
                setState(() {
                 LoggedUser.user = null;
                });
              }
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: kPrimaryColor,
      body: ValueListenableBuilder(
          valueListenable: _selectedcategory,
          builder: (context, selectedCategory, snapshot) {
            return Column(
              children: [
                CategoryList(
                  selectedCategory: _selectedcategory,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: _productsBloc.getProductsList(
                          category: selectedCategory),
                      builder:
                          (context, AsyncSnapshot<List<Produto>> snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          produto: snapshot.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            );
          }),
    );
  }
}
