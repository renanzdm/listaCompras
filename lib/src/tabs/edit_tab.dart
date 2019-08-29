import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:lista_de_compras/src/screens/add_category.dart';
import 'package:lista_de_compras/src/screens/add_product.dart';
import 'package:lista_de_compras/src/tiles/category_tile.dart';

class EditTab extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    Widget _floatingButtom() {
      return SpeedDial(
        child: Icon(Icons.add),
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.3,
        children: [
          SpeedDialChild(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddCategory()));
              },
              child: Icon(Icons.category),
              label: 'Categorias',
              labelStyle: TextStyle(color: Colors.black)),
          SpeedDialChild(
            child: Icon(Icons.format_list_numbered),
            label: 'Produtos',
            labelStyle: TextStyle(color: Colors.black),
            onTap: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct()));
            }
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categorias'),
      ),
      floatingActionButton: _floatingButtom(),
      body: StreamBuilder<List<Categoria>>(
        stream: MyDatabase.instance.categoriaDao.listAll(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          List<Categoria> list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return CategoryTile(list[index]);
            },
          );
        },
      ),
    );
  }
}
