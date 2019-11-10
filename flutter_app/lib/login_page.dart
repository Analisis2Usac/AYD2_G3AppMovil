import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'Vistas/carrito_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _password = "jorged104@gmail.com";
  String _email = "...";

  Future<String> _login() async {
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
                'Login Information' ,
              style: TextStyle(fontSize:20),
                ),
            TextFormField(
              controller: _usernameController,
              onSaved: (String value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email")),
            TextFormField(
              controller: _passwordController,
              onSaved: (String value) => _password = value,
              obscureText: true,
              decoration: InputDecoration(labelText:"Password")),
            RaisedButton(
              textColor: Colors.white,
              color : Colors.deepPurple,

              child: Text('Login'),
              onPressed: () {
                try{
                  setState(() {
                    _email = "Cargando ...";
                  });
                  _login();
                  //Navigator.pop(context);
                }catch(err) {

                    }

              } ,
            ),
            Text(
                _email.toString()
            )
          ],
        )
      ),
    );
  }

}