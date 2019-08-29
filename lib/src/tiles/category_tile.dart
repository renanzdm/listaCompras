import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/db/dao/ProdutoDAO.dart';
import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:lista_de_compras/src/tiles/dialog_delete.dart';

class CategoryTile extends StatelessWidget {
  final Categoria _categoria;

  const CategoryTile(this._categoria);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      borderOnForeground: true,
      child: ExpansionTile(
        leading: GestureDetector(
          onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              categoria: _categoria,
              title: 'Excluir categoria',
              description:
                  'Ao excluir categoria excluir também os produtos relacionados',
            ),
          );
        },
          child: CircleAvatar(
            backgroundColor: Colors.teal,
          ),
        ),
        title: Text(_categoria.title),
        children: <Widget>[
          StreamBuilder<List<Produto>>(
            stream: MyDatabase.instance.produtoDao.listProdCat(_categoria.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return Container();
              List<Produto> list = snapshot.data;
              return Column(
                  children: list.map((prod) {
                return ListTile(
                  title: Text(prod.title),
                );
              }).toList());
            },
          )
        ],
      ),
    );
  }
}
