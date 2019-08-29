import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/blocs/category_bloc.dart';
import 'package:lista_de_compras/src/blocs/product_bloc.dart';
import 'package:lista_de_compras/src/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=>CategoryBloc()),
        Bloc((i)=>ProductBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Compras',
        theme: ThemeData.dark(),
        home:HomeScreen()
      ),
    );
  }
}

