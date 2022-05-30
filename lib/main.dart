
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:prueba_login/second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(10.0),
    child:SafeArea(
    child:Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(labelText:"Email",
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.email)),
      ),
      SizedBox(height: 15 ,),
      TextFormField(
        controller: passController,
        obscureText: true,
        decoration: InputDecoration(labelText:"Password",
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.email)),
      ),
      SizedBox(height: 45,),
      OutlinedButton.icon(onPressed: (){
          login();
    },
    icon: Icon(Icons.login, size: 18), label: Text("Login"))
    ],
    ),
    ) ,
    ),
    )
    );
  }


  //CREO FUNCION LOGIN PARA LA API

  Future<void> login() async {
    if(passController.text.isNotEmpty && emailController.text.isNotEmpty){
     var response = await http.post(Uri.parse("https://reqres.in/api/login"), body: (
         {'email': emailController.text, 'password': passController.text}

     ));
     print(response.toString());
     if(response.statusCode == 200){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
       print(response);

     }else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
     }
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Field Not Allowed")));
    }

  }
}


