import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:lista_de_compras/src/db/my_database.dart';
import 'package:recase/recase.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  Categoria categoria;

  final _titleController = BehaviorSubject<String>.seeded('');
  //final _validateController = BehaviorSubject<bool>();
  //Observable<bool> get outValidate => _validateController.stream;


  void setTitle(String title) {
    ReCase rc = ReCase(title);
    _titleController.add(rc.headerCase);
    categoria = Categoria(title: _titleController.value);
  }

  saveData() {
    try {
      MyDatabase.instance.categoriaDao.addCategoria(categoria);
     // _validateController.add(true);
    } catch (e) {
     // _validateController.add(false);
     print(e.toString());
    }
  }
  @override
  void dispose() {
    _titleController.close();
    super.dispose();
  }
}
