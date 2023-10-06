import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/notes_screen.dart'; // Pastikan Anda mengimpor home_page.dart

class SendOrUpdateData extends StatefulWidget {
  final String judul;
  final String isi;
  final String id;
  final bool isEditing;

  SendOrUpdateData({
    this.judul = '',
    this.isi = '',
    this.id = '',
    this.isEditing = false,
  });

  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();
  bool showProgressIndicator = false;
  String successMessage = '';

  @override
  void initState() {
    if (widget.isEditing) {
      judulController.text = widget.judul;
      isiController.text = widget.isi;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          widget.isEditing ? 'Edit Catatan' : 'Tambah Catatan',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: judulController,
              decoration:
                  InputDecoration(hintText: 'Isikan judul catatan Anda'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Isi',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: isiController,
                maxLines: null, // Mengizinkan input kalimat panjang
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Isikan catatan Anda',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (judulController.text.isEmpty ||
                    isiController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Isi semua kolom')),
                  );
                } else {
                  final dUser = FirebaseFirestore.instance
                      .collection('catatan')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'judul': judulController.text,
                    'isi': isiController.text,
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.isEditing) {
                    await dUser.update(jsonData).then((value) {
                      judulController.text = '';
                      isiController.text = '';
                      showProgressIndicator = false;
                      setState(() {
                        successMessage = 'Catatan berhasil diupdate';
                      });
                      // Delay pesan sukses selama beberapa detik dan kembali ke halaman sebelumnya
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    });
                  } else {
                    await dUser.set(jsonData).then((value) {
                      judulController.text = '';
                      isiController.text = '';
                      showProgressIndicator = false;
                      setState(() {
                        successMessage = 'Catatan berhasil ditambah';
                      });
                      // Delay pesan sukses selama beberapa detik dan kembali ke halaman sebelumnya
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.blue.shade400,
              child: showProgressIndicator
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      widget.isEditing ? 'Update' : 'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
            ),
            SizedBox(height: 10),
            Text(
              successMessage,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
