import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/blocs/product_bloc.dart';
import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:lista_de_compras/src/validators/validate_product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

final _bloc = BlocProvider.getBloc<ProductBloc>();
int value;
final _formKey = GlobalKey<FormState>();
final _formKeyDrop = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class _AddProductState extends State<AddProduct> with ProductValidator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Adiconar Produto'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Título'),
                  onSaved: (text) {
                    _bloc.setTitle(text);
                  },
                  validator: validateTitle,
                ),
                SizedBox(
                  height: 8,
                ),
                StreamBuilder(
                  stream: MyDatabase.instance.categoriaDao.listAll(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Adicione uma Categoria para continuar',
                          style: TextStyle(fontSize: 22, color: Colors.teal),
                          textAlign: TextAlign.center,
                        ),
                      );
                    List<Categoria> list = snapshot.data;

                    return DropdownButtonFormField(
                      value: value,
                      key: _formKeyDrop,
                      hint: Text('Selecione uma Categoria'),
                      items: list.map((categoria) {
                        return DropdownMenuItem(
                          child: Text(categoria.title),
                          value: categoria.id,
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      },
                      onSaved: (idCat) {
                        _bloc.setIdCategory(idCat);
                      },
                      validator: validateDrop,
                    );
                  
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                RaisedButton(
                  color: Colors.teal,
                  onPressed: () {
                    saveProduct();
                  },
                  child: Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _bloc.saveProduct();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Salvando produto....',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.teal,
        ),
      );

      Future.delayed(Duration(seconds: 1)).then((_) => Navigator.pop(context));
    }
  }
}
