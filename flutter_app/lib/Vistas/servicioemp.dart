import 'package:flutter/material.dart';

import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'carrito_page.dart';

class servicioemp extends StatefulWidget {
  int _categoria;
  String _titulo;
  servicioemp(int categoria,String titulo){
    this._categoria = categoria;
    this._titulo = titulo;
  }
  @override
  _servicioempState createState() => _servicioempState(this._categoria,this._titulo);

}



class _servicioempState extends State<servicioemp> with TickerProviderStateMixin {


  List<serviciosFin> listaCategorias = new List();


  Future _initdata() async {
    final response = await http.get('http://${MyApp.hostApp}/lista-servicio/${this._categoria}');
    var data = json.decode(response.body);
    // print(data);


    setState(() {
      for(final cat in data){
        listaCategorias.add(serviciosFin(cat["id_servicio"], cat["precio"],this._titulo,cat["descripcion"],this));
      }
    });


  }

  List<String> litems = [];

  int _categoria;
  String _titulo;
  _servicioempState(int categoria,String titulo){
    this._categoria =categoria;
    this._titulo = titulo;
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
          "Servicio ${this._titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _ProductsListPageBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> CarridoPage()));
              },
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


}

class serviciosFin {
  int _id;
  int _nombre;
  String _nombreServicio;
  String _descripcion;
  TickerProvider estado;
  bool _isButtonDisabled = false;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  serviciosFin(int id , int nombre ,String nombreServicio, String descripcion,TickerProvider estado)
  {
    this._id= id;
    this._nombre=nombre;
    this._nombreServicio = nombreServicio;
    this._descripcion = descripcion;
    this.estado = estado;
     _isButtonDisabled = false;
  }

  builderSimple(context)
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
            child: Icon(Icons.add,color: Colors.white24) ,

          ),
          title: Text(this.nombre.toString() , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          trailing:
          IconButton(
            icon: Icon(Icons.attach_money,color: Colors.white,size: 30.0,),
            onPressed: () =>{
              // Navigator.push(context,MaterialPageRoute(builder: (context)=> servicioemp(this._id,this._nombre)))
            },
          ),
        ),
      ),
    );

  }

  builder(context)
  {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return Container(
        child: Card(
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildServiceImageWidgets(),
              SizedBox(height: 12.0),
              _buildDivider(screenSize),
              SizedBox(height: 12.0),
              _buildServiceTitle(),
              SizedBox(height: 12.0),
              _buildDivider(screenSize),
              SizedBox(height: 12.0),
              _buildDetailsAndMaterialWidgets(),
              SizedBox(height: 12.0),
              SizedBox(height: 12.0),
              _buildDivider(screenSize),
              SizedBox(height: 12.0),
              _buildButton(context),
              SizedBox(height: 12.0),
            ],
          ),
        )
    );
  }



  _buildButton(context){
    return Container(
      //color: Colors.lightGreenAccent,
      child: RaisedButton(
        onPressed: _isButtonDisabled ? null : () {
          //MyApp.carrito.add(this);
          showAlertDialog(context);
        },
        color: Colors.green,
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
                "Pedir",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ) ,
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        MyApp.carrito.add(this);

        (this.estado as _servicioempState).setState((){
          _isButtonDisabled = true;
        });
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmar el servicio"),
      content: Text("Usted quiere agregar este servicio a su carrito ."),
      actions: [
        okButton,
        cancelButton
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildServiceTitle(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(this._nombreServicio, style: TextStyle(fontSize: 25,color:Colors.black ),),
      ),
    );
  }
  _buildServiceImageWidgets(){

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            height: 250.0,
            child:Center(
              child: Image.asset("assets/images/notfound.png"),
            )
        )

    );
  }

  _buildDetailsAndMaterialWidgets() {
    TabController tabController = new TabController(length: 2 ,vsync: estado );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            //isScrollable: true,
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "PRECIO",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "DESCRIPCION",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            height: 100,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Container(
               child:Center(
                   child:Text(
                  "Q "+this._nombre.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0
                  ),
                )
                ),
                ),
                Container(
                child:Text(
                 this._descripcion,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int get nombre => _nombre;

  set nombre(int value) {
    _nombre = value;
  }

  String get nombreServicio => _nombreServicio;

  set nombreServicio(String value) {
    _nombreServicio = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  bool get isButtonDisabled => _isButtonDisabled;

  set isButtonDisabled(bool value) {
    _isButtonDisabled = value;
  }

}
