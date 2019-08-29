
class ProductValidator {

  String validateTitle(String text){
    if(text.isEmpty  ) return 'Adicione um Produto';
    if(text.length < 2) return 'Produto Invalida';
    return null;
  }

    String validateDrop(int value){
      if(value == null) return 'Escolha uma categoria';
      return null;
    }

 
}