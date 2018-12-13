import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  String url = "https://randomuser.me/api/?results=30";
 List data;
 var name;
 var phone;
  Future<String> makeRequest() async {
    var respons = 
      await http.get(Uri.encodeFull(url),headers:{"Accept" :"application/json"});

   

    setState(() {
          var extractData =json.decode(respons.body);
    data= extractData["results"];
      print(data[0]["name"]["first"]);
        });
    
  }

 @override
  void initState() { 
    print("here");
    this.makeRequest();
  //  super.initState();
   
 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contact List"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length ,
        itemBuilder: (BuildContext context , i){
        return new ListTile(
          title: new Text(data[i]["name"]["first"]),
          subtitle: new Text(data[i]['phone']),
          leading: new CircleAvatar(
            backgroundImage: new  NetworkImage(data[i]["picture"]["thumbnail"]),
          ),
          trailing: new Icon(Icons.call),
          onTap: (){
             Navigator.push(context, 
              new MaterialPageRoute(
                builder: (BuildContext context) =>
                new SecondPage(data[i]))
             );
          },
        );
        },
      ),
    );
  }

 
}


class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;
  
  @override
  Widget build(BuildContext context) => new Scaffold(

    appBar: new AppBar(
      title: new Text("Second Page"),
    ),
    body: new Center(
      
      child: new Container(
        width: 150.0,
        height: 150.0,
        decoration: new BoxDecoration(
          color: const Color(0xff7c94b6),
          image: new DecorationImage(
            image: new NetworkImage(data["picture"]["large"]),
            fit: BoxFit.cover,
          ),
          borderRadius:  new BorderRadius.all(new Radius.circular(75.0)),
          border: new Border.all(
            color: Colors.red,
            width: 4.0
          )
        ),
        
      ),
    
    ),
  
  );
}
