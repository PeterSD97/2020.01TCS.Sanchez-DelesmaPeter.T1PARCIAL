import 'dart:convert';
//import 'dart:ui' as ui;
import 'package:consulta/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
@override 
_LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading= false;
  
  
  
  @override 
  Widget build (BuildContext context) {
     return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.teal,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
             ),
        ) ,
        child:_isLoading ? Center(child : CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),   
            

     );
  }

  Container textSection(){
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 20.0) ,
     margin: EdgeInsets.only(top: 30.0),
     child: Column(
       children: <Widget>[
         txtSection("Usuario",Icons.people),
         SizedBox(height: 30.0),
         txtSection("Password", Icons.lock),
       ],
     ),
     ); 
  }

  TextEditingController usuarioController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();


  TextFormField txtUsuario(String title,IconData icon){
    return TextFormField(
      controller: usuarioController,
      obscureText: true,

      style:TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color:  Colors.white70),
        icon: Icon(icon)
      ),
    );
  }

  TextFormField txtPassword(String title,IconData icon){
    return TextFormField(
      controller: passwordController,
      obscureText: true,

      style:TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color:  Colors.white70),
        icon: Icon(icon)
      ),
    );
  }

  TextFormField txtSection(String title, IconData icon){
    return TextFormField(
      obscureText: title == "Usuario" ?false : true,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon)
      ),
    );
  }




  Container headerSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0) ,
      child: Text("SIGAP", style: TextStyle(color: Colors.white)),
      );

  }

  signIn(String usuario, password) async{
    Map data = {
      'usuario': usuario,
      'password':password
    };
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 
    var response = await http.post('https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/buscar/', body: data);
    if(response.statusCode==200){
      jsonData = jsonDecode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute (builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      });
    }
    else {
      print(response.body);
    }
  }





  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0) ,
     margin: EdgeInsets.only(top: 30.0),
     child: RaisedButton(
       onPressed: () {
         setState(() {
          _isLoading = true;
         });
         signIn(usuarioController.text, passwordController.text);
       },
       color: Colors.purple,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: Text("Sign In", style: TextStyle(color: Colors.white70)) ,
       ),
    );
  }       
                   
            
             

  }
