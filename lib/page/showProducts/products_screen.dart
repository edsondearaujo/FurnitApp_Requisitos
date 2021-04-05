import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';

import 'category_list.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: Stack(
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
                ProductCard()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
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
              child: Image.network(
                  'https://www.casasbahia-imagens.com.br/Control/ArquivoExibir.aspx?IdArquivo=1185423396'),
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
                    child: Text('Mesa 4 cadeiras marrom', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Spacer(),
                  Container(
                    
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4),
                    decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22), topRight: Radius.circular(22))),
                    child: Text('\$458,99'),
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
