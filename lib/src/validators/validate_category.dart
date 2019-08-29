

class CategoryValidator {

  String validateTitle(String text){
    if(text.isEmpty  ) return 'Adicione uma categoria';
    if(text.length < 2) return 'Categoria Invalida';
    return null;
  }
}