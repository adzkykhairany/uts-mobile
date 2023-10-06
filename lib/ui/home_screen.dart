import 'package:flutter/material.dart';
import '../send_or_update_data_screen.dart';
import 'side_screen.dart';
import '../send_or_update_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Selamat datang kembali',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 20), // Spacer
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman SendOrUpdateData saat tombol ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SendOrUpdateData(),
                ),
              );
            },
            child: Text('Tambah Catatan'),
          ),
        ],
      ),
      drawer: const SideScreen(),
    );
  }
}
