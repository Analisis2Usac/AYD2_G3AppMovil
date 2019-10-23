import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String _password;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
              onSaved: (value) => _email = value,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email")),
            TextFormField(
              onSaved: (value) => _password = value,
              obscureText: true,
              decoration: InputDecoration(labelText:"Password")),
            RaisedButton(child: Text('Login'), onPressed: () {} ,)
          ],
        )
      ),
    );
  }
}