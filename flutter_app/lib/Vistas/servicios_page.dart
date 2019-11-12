import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class serviciosPage extends StatefulWidget {
  @override
  _serviciosPageState createState() => _serviciosPageState();

}


class _serviciosPageState extends State<serviciosPage>  {


  /*Future<String> _login() async {
    final response = await http.post('http://${MyApp.hostApp}/loginAPI', body: {
      "id": _usernameController.text,
      "pass": _passwordController.text,
    });
    var datauser = json.decode(response.body);
    setState(() {
      _email  = datauser;
    });
    if(datauser == "OK"){
      MyApp.setUsername(_usernameController.text);
      Navigator.pushReplacementNamed(context, '/carrito_Page');
    }
    return datauser;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Detalle servicio",
          style: TextStyle(color: Colors.white),
        ),
      ),
     body: _buildProductDetailsPage(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
      );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
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
              ],
            ),
          ),
        )
      ],
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
          child: Text("Producto Titulo", style: TextStyle(fontSize: 25,color:Colors.black ),),
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
              onPressed: (){},
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
                      "SAVE",
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
                      "AGREGAR A CARRO",
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

