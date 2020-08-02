import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() {
  runApp(
MaterialApp(

      home:HomePage()   

    ),

  );
}

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage>{

  List data;
  List usersData;

  getUsers() async{
    
    http.Response response= await http.get('https://proyecto-sigap.herokuapp.com//alumnoprograma/buscard/08884699');
    data=json.decode(response.body);
    setState(() {
      usersData= data;
      
    });
  }

  @override
  void initState(){
    super.initState();
    getUsers();

    
  }


  Widget build(BuildContext context){
    return Scaffold(
      
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: usersData==null ? 0 : usersData.length  ,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(10.0),
                  child:Text("$index ", 
                  style: TextStyle(
                    fontSize:  8.0,
                    fontWeight: FontWeight.w500
                  )),

                 )
                  ,
                  /*Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${usersData[index]["codAlumno"]}",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700
                    ),),
                  ),*/
                 
                   Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${usersData[index]["nom_programa"]}",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                  

                ],),
            )
          );
        },
      ),
    );
  }

}