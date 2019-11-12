
import 'package:flutter/material.dart';
import 'package:flutter_app/Vistas/categoryPage.dart';
import 'package:flutter_app/Vistas/servicioemp.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class CarridoPage extends StatefulWidget {
  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarridoPage>
{
  _categoryPageState(){
  //  _initdata();
    //litems.add("holis2");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Carrito",
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
                //Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context)=> categoryPage()));
              },
              color: Colors.lightGreenAccent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                        Icons.attach_money,
                        color: Colors.white
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Q "+ _CalcularTotal().toString(),
                      style: TextStyle(color: Colors.white , fontSize: 15.0),
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
                _Pagar();
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
                      "PAGAR",
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
      itemCount: MyApp.carrito.length,
      itemBuilder: (BuildContext ctx, int index){
        return   MyApp.carrito[index].builderSimple(context);
      },
    );
  }
  int _total;

  _CalcularTotal(){
    this._total = 0;
    for(serviciosFin x in MyApp.carrito)
      {
        _total += x.nombre;
      }
    return this._total;
  }

  _Pagar(){
     if( MyApp.getUsername() != null ){
       _hazpago();
     }else{
       Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginPage()));
     }

  }

  Future _hazpago() async {
    //final response = await http.put('http://${MyApp.hostApp}/detalle?id_contrato=null&fecha=null&id_empresa=null&id_servicio=null&id_pago=null&email=null');
    //var data = json.decode(response.body);
    // print(data);


    setState(() {
      MyApp.carrito.clear();
    });


  }
}


