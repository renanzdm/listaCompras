import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/blocs/category_bloc.dart';
import 'package:lista_de_compras/src/validators/validate_category.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();
final _bloc = BlocProvider.getBloc<CategoryBloc>();

class _AddCategoryState extends State<AddCategory> with CategoryValidator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Adiconar Categoria'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                validator: validateTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Categoria'),
                onSaved: (text) {
                  _bloc.setTitle(text);
                },
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                  child: Text('Salvar'),
                  onPressed: () {
                    saveCategory();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void saveCategory() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _bloc.saveData();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Salvando categoria....',
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
