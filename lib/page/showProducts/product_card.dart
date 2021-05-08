import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/models/Produto.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  final Function onTap;

  const ProductCard({
    Key key,
    @required this.onTap,
    @required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: this.onTap,
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
                      child: Text('R\$ ' + this.produto.valor.toString()),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
