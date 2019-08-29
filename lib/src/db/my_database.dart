import 'package:lista_de_compras/src/db/dao/CategoriaDAO.dart';
import 'package:lista_de_compras/src/db/dao/ProdutoDAO.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'my_database.g.dart';

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}

class Produtos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get id_categoria => integer()();
}

@UseMoor(tables: [Categorias, Produtos])
class MyDatabase extends _$MyDatabase {
  static final MyDatabase instance = MyDatabase._internal();

  ProdutoDao produtoDao;
  CategoriaDao categoriaDao;
  MyDatabase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite')) {
    produtoDao = ProdutoDao(this);
    categoriaDao = CategoriaDao(this);
  }
  @override
  int get schemaVersion => 1;
}
