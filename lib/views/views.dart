
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/produto.controller.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';



class ProdutoListView extends StatefulWidget {
  @override
  _ProdutoListViewState createState() => _ProdutoListViewState();
}
class _ProdutoListViewState extends State<ProdutoListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  ProdutoController _controller = null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<ProdutoController>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Sua lista pessoal'),
          backgroundColor: Color.fromRGBO(123, 104, 238, 5),
          centerTitle: true),

      body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                      title: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: _controller.list[i].concluido
                            ? Text(
                          _controller.list[i].nome,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough),
                        )
                            : Text(_controller.list[i].nome),
                        value: _controller.list[i].concluido,
                        secondary: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20.0,
                            color: Colors.red[900],
                          ),
                          onPressed: () async {
                            await _controller.delete(i);
                          },
                        ),
                        onChanged: (c) async {
                          Produto edited = _controller.list[i];
                          edited.concluido = c;
                          await _controller.update(i, edited);
                        },
                      )),
              ],
            );
          }else{
            return Text("Erro");
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(123, 104, 238, 5),
        onPressed: () => _displayDialog(context),
      ),
    );
  }
  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o produto.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Produto"),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(Produto(nome: _itemController.text,
                        concluido: false));
                    _itemController.text = "";
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
