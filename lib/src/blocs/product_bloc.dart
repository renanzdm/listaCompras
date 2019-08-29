import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:recase/recase.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  Produto produto;
  int idCat;
  String title;

  final _titleController = BehaviorSubject<String>.seeded('');
  final _idCategoryController = BehaviorSubject<int>();
 

  setTitle(String title) {   
     ReCase rc = ReCase(title);
    _titleController.add(rc.headerCase);
  }

  setIdCategory(int idCat){
    _idCategoryController.add(idCat);
  }


  saveProduct(){
      produto = Produto(title: _titleController.value,id_categoria: _idCategoryController.value);
      MyDatabase.instance.produtoDao.addProduto(produto);
    }




  @override
  void dispose() {
    _titleController.close();
    super.dispose();
  }
}
