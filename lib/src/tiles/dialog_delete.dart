import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/db/my_database.dart';

class CustomDialog extends StatelessWidget {
  final String title, description;
  final Categoria categoria;

  CustomDialog(
      {@required this.title, @required this.description, this.categoria});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
                SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Text('Excluir'),
                    onPressed: () {
                      MyDatabase.instance.categoriaDao.deleteCategoria(categoria.id);
                      Navigator.pop(context);

                    },
                    color: Colors.redAccent,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.teal,
                  ),
                ],
              )
            ],
          ),
        ),

        //...top circlular image part,
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
