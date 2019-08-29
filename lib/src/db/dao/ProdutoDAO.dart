import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'ProdutoDAO.g.dart';

class ProdutoWithNameCategoria {
  final Produto produto;
  final String nameCategoria;

  ProdutoWithNameCategoria(this.produto, this.nameCategoria);
}



@UseDao(tables: [Produtos, Categorias])
class ProdutoDao extends DatabaseAccessor<MyDatabase> with _$ProdutoDaoMixin {
  Stream<List<Produto>> listAll() {
    return (select(produtos)).watch();
  }
  Stream<List<Produto>> listProdCat(int id) {
    return (select(produtos)..where((prod) => prod.id_categoria.equals(id))).watch();
  }
  

  Future addProduto(Produto entity) {
    return into(produtos).insert(entity);
  }

  Future deleteProduto(int id) {
    return (delete(produtos)..where((prod) => prod.id.equals(id))).go();
  }

  /*   Stream<List<ProdutoWithNameCategoria>> listProductCategory(){
         return customSelectStream('SELECT produtos.*, categorias.title FROM produtos LEFT JOIN categorias ON produtos.id_categoria = categorias.id  ', 
    readsFrom: {produtos,categorias}).map((rows){
        return rows.map((row)=>ProdutoWithNameCategoria(Produto.fromData(row.data, db),row.readString('title'))).toList();
    });
    } */


  ProdutoDao(MyDatabase db) : super(db);
}
