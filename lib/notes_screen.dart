import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'send_or_update_data_screen.dart';
import 'ui/side_screen.dart';
import 'view_data_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SendOrUpdateData(),
            ),
          );
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.note_add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Catatan',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      drawer: const SideScreen(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('catatan').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewDataScreen(
                              judul: streamSnapshot.data!.docs[index]['judul'],
                              isi: streamSnapshot.data!.docs[index]['isi'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 11),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streamSnapshot.data!.docs[index]['judul'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SendOrUpdateData(
                                          judul: streamSnapshot
                                              .data!.docs[index]['judul'],
                                          isi: streamSnapshot.data!.docs[index]
                                              ['isi'],
                                          id: streamSnapshot.data!.docs[index]
                                              ['id'],
                                          isEditing: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                    size: 21,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final docData = FirebaseFirestore.instance
                                        .collection('catatan')
                                        .doc(streamSnapshot.data!.docs[index]
                                            ['id']);
                                    await docData.delete();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade900,
                                    size: 21,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              : Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}
