import 'package:flutter/material.dart';
import 'package:socratize/history.page.dart';
import 'package:socratize/theme.dart';

void main() {
  runApp(SocratizeApp());
}

class SocratizeApp extends StatelessWidget {
  const SocratizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socratize',
      theme: socratizeTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Socratize"),
        ),
        body: Container(
          color: Colors.blue
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget> [
              UserAccountsDrawerHeader(
                accountName: Text("Paula"), 
                accountEmail: Text("paula.silva@email.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: 
                  NetworkImage("assets/images/socratize-logo.png"),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Perguntas"),
                //subtitle: Text("Meus favoritos..."),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()
                  ));
                }
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Histórico de pensamentos"),
                //subtitle: Text("Meus favoritos..."),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()
                  ));
                }
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Contactar psicólogo"),
                //subtitle: Text("Meus favoritos..."),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()
                  ));
                }
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Perfil"),
                //subtitle: Text("Meus favoritos..."),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()
                  ));
                }
              ),
               ListTile(
                leading: Icon(Icons.star),
                title: Text("Sair"),
                //subtitle: Text("Meus favoritos..."),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()
                  ));
                }
              )
            ],
          )
        )
      ), // Substitua por sua página inicial
    );
  }
}

