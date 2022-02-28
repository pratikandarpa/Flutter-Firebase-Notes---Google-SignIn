import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title = '';
  String des = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      child: Icon(Icons.arrow_back),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                    ),
                    ElevatedButton(
                      onPressed: () => {add()},
                      child: Text("Save"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                    )
                  ],
                ),
              ),
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        InputDecoration.collapsed(hintText: "Add Title"),
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration.collapsed(hintText: "Add Note"),
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      des = val;
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {'title': title, 'des': des, 'created': DateTime.now()};

    ref.add(data);

    Navigator.pop(context);
  }
}
