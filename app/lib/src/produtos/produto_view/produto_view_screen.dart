import 'package:app/src/shared/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProdutoViewScreen extends StatefulWidget {
  final Produto produto;

  const ProdutoViewScreen({Key key, this.produto}) : super(key: key);

  @override
  _ProdutoViewScreenState createState() => _ProdutoViewScreenState(produto);
}

class _ProdutoViewScreenState extends State<ProdutoViewScreen> {
  final Produto produto;

  _ProdutoViewScreenState(this.produto);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: produto.id,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(produto.image),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(color: Colors.blue),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -5,
            left: 25,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              elevation: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                height: height * 0.50,
                width: width * 0.80,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Preço: ${produto.price}'),
                      Divider(),
                      Text('Descrição: ${produto.description}'),
                      Divider(),
                    ],
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