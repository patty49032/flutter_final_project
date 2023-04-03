import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/edit_employee.dart';
import 'package:flutter_final_project/screens/login.dart';
import 'package:flutter_final_project/screens/new_employee.dart';
import 'package:flutter_final_project/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    User? _currentUser = _service.user;
    String displayEmail = "";

    if (_currentUser != null && _currentUser.email != null) {
      displayEmail = _currentUser.email!;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              child: Text("Hello User $displayEmail")),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              _service.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
          )
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("employee").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataDocuments[index]["name"].toString()),
                subtitle: Text(dataDocuments[index]["role"].toString()),
                onTap: () => _editItemScreen(dataDocuments[index].id,
                    dataDocuments[index]["name"], dataDocuments[index]["role"], dataDocuments[index]["salary"]),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewEmployee,
        tooltip: 'Create New Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewEmployee() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewEmployeeScreen()));
  }

  _editItemScreen(String documentid, String itemName, String itemRole, String itemSalary) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditItemScreen(documentid, itemName, itemRole, itemSalary)));
  }
}
