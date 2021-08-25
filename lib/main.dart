
import 'package:flutter/material.dart';
import 'package:flutter_app/views/views.dart';
import 'package:provider/provider.dart';
import 'controllers/produto.controller.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          Provider<ProdutoController>.value(
            value: ProdutoController(),)
        ],
        child: MaterialApp(
          title: 'Lista',
          debugShowCheckedModeBanner: false,
          home: ProdutoListView(),
        )
    );
  }
}