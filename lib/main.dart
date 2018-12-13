import 'package:flutter/material.dart';
import './firstpage.dart' as firstpage;
import './secondpage.dart' as secondpage;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page Day 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this, length: 2);

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text('My First Flutter App with list view and alert'),
        ),
        backgroundColor: Colors.red,
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.airplanemode_active),),
            new Tab(icon: new Icon(Icons.airplanemode_inactive),)
          ],
        ),
      ),
      // bottomNavigationBar: new Material(
      //   color: Colors.teal,
      //   child: new TabBar(
      //     controller: controller,
      //     tabs: <Widget>[
      //       new Tab(icon: new Icon(Icons.airplanemode_active),),
      //       new Tab(icon: new Icon(Icons.airplanemode_inactive),)
      //     ],
      //   ),
      // ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new firstpage.FirstPage(),
          new secondpage.SecondPage(),
        ],
      ),
      // body: new _MyList()
    );
  }
}
class _MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
       padding: const EdgeInsets.all(4.0),
       itemBuilder:(context, i){
         return new ListTile(
           title: new Text('Random Username'),
           subtitle: new Text('Online',style: new TextStyle(fontStyle: FontStyle.italic,color: Colors.green),),
           leading: const Icon(Icons.access_alarms),
           trailing: new RaisedButton(
             child:  new Text('Remove'),
             onPressed: (){
               deleteDialog(context).then((value){
                 print('Value is $value');
               });
             },
           ),
         );
       },
      );
  }
}


Future<bool> deleteDialog(BuildContext context) async {
 return showDialog(
   context: context,
   barrierDismissible: false,
   builder: (BuildContext context){
     return new AlertDialog(
       title: new Text('Are You Sure ?'),
       actions: <Widget>[ 
         new FlatButton(
           child: new Text('Yes'),
           onPressed: (){
             Navigator.of(context).pop(true);
           },
         ),
         new FlatButton(
           child: new Text('No'),
           onPressed: (){
             Navigator.of(context).pop(false);
           },
         )
       ],
     );
   }
 );
}