import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/notes_screen.dart';
import 'home_screen.dart';

class SideScreen extends StatelessWidget {
  const SideScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Text(
              'Notes App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Catatan'),
            leading: Icon(Icons.note),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesScreen(),
                ),
              );
            },
          ),
          // ListTile(
          //   title: Text('Produk'),
          //   leading: Icon(Icons.shopping_cart),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ProdukScreen(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: Text('Kategori'),
          //   leading: Icon(Icons.category),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => KategoriScreen(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: Text('Mahasiswa'),
          //   leading: Icon(Icons.person),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MahasiswaScreen(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
