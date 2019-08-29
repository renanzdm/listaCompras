import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:moor_flutter/moor_flutter.dart';


part 'CategoriaDAO.g.dart';

@UseDao(tables:[Produtos,Categorias])
class CategoriaDao extends DatabaseAccessor<MyDatabase> with _$CategoriaDaoMixin{
  CategoriaDao(MyDatabase db) : super(db);


  Stream<List<Categoria>> listAll(){
    return (select(categorias)).watch();
  }

    Future addCategoria(Categoria entity) {
    return into(categorias).insert(entity);
  }

  Future deleteCategoria(int id){
    return (delete(categorias)..where((cat)=> cat.id.equals(id))).go();
}


}