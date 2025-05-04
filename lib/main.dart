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
      title: 'Socratize',
      theme: socratizeTheme,
      home: HistoryPage(), // Substitua por sua página inicial
    );
    //drawer: const NavigationDrawer(),
  }
}

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}) :super(key: key)

//   @override
//   Widget build(BuildContext context) => Drawer(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget> [
//           buildHeader(context),
//           buildMenuItems(context),
//         ],
//       ),
//     ),
//   );
//   Widget buildHeader(BuildContext context) => Container(
//     padding: EdgeInsets.only(
//       top: MediaQuery.of(context).padding.top,
//     ),
//   );

//   Widget buildMenuItems(BuildContext context) => Container(
//     padding: const EdgeInsets.all(24),
//     child: Wrap(
//       runSpacing: 16,
//       children: [
//         ListTile(
//           leading: const Icon(Icons.home_outlined),
//           title: const Text('Home'),
//           onTap: () => 
//             Navigator.of(context).pushReplacement(MaterialPageRoute),
//           builder: (context) => const HomePage(),
//         ),
//         ListTile(
//           leading: const Icon(Icons.home_outlined),
//           title: const Text('Home'),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: const Icon(Icons.home_outlined),
//           title: const Text('Home'),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: const Icon(Icons.home_outlined),
//           title: const Text('Home'),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: const Icon(Icons.home_outlined),
//           title: const Text('Home'),
//           onTap: () {},
//         ),
//       ],
//     ),
//   );

 // }

