import 'package:flutter/material.dart';

import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'ListaServicios.dart';

class categoryPage extends StatefulWidget {
  @override
  _categoryPageState createState() => _categoryPageState();

}



class _categoryPageState extends State<categoryPage>  {

List<categoria> listaCategorias = new List();


  Future _initdata() async {
    final response = await http.get('http://${MyApp.hostApp}/categoria');
    var data = json.decode(response.body);
   // print(data);


    setState(() {
      for(final cat in data){
        listaCategorias.add(categoria(cat["id_categoria"], cat["nombre"], cat["ruta"]));
      }
    });


  }

  List<String> litems = [];

  _categoryPageState(){
    _initdata();
      litems.add("holis2");
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Categorias servicio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _ProductsListPageBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
_buildBottomNavigationBar() {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50.0,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            color: Colors.grey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      Icons.list,
                      color: Colors.white
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "Atras",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.deepPurpleAccent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      Icons.card_travel,
                      color: Colors.white
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "Ver carro",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
  _ProductsListPageBody(){
    return ListView.builder(
      itemCount: listaCategorias.length,
      itemBuilder: (BuildContext ctx, int index){
        return listaCategorias[index].builder(context);
      },
    );
  }
  }

class categoria {
  int _id;
  String _nombre;
  String _imagen;

  categoria(int id , String nombre , imagen)
  {
    this._id= id;
    this._nombre=nombre;
    this._imagen = imagen;
  }

  builder(context)
  {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(right: BorderSide(width: 1.0,color: Colors.white24))
            ),
            child: getimagen() ,

          ),
          title: Text(this._nombre , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          trailing:
              IconButton(
              icon: Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 30.0,),
             onPressed: () =>{
             Navigator.push(context,MaterialPageRoute(builder: (context)=> ListaServicios(this._id,this._nombre)))
             },
              ),
        ),
      ),
    );
  }
  getimagen(){
    return _imagen != null ?  Image.network(this._imagen):  Icon(Icons.category,color: Colors.white24);
  }
}
