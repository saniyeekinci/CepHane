import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/notlar.dart';
import 'package:mobilprojem/profilepage.dart';

class NotEkleme extends StatefulWidget {
  @override
  _NotEklemeState createState() => _NotEklemeState();
}

class _NotEklemeState extends State<NotEkleme> {
  late User? user;
  late CollectionReference notes;
  List<Map<String, dynamic>> noteList = [];
  String note = '';
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    notes = FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('notes');
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    try {
      final snapshot = await notes.get();
      setState(() {
        noteList = snapshot.docs.map((doc) => {
          'id': doc.id,
          'note': doc['note']
        }).toList();
      });
    } catch (e) {
      print("Error fetching notes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text('Note Ekleme', style: TextStyle(color: Colors.white70)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Not',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  note = value;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                onPressed: () {
                  if (note.isNotEmpty) {
                    _addNote();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill out the note field'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Ekle',
                  style: TextStyle(fontSize: 16.0, color: Colors.white70),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.grey.shade400,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        noteList[index]['note'],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteNote(noteList[index]['id']),
                        color: Colors.deepOrange.shade900,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        gap: 10,
        backgroundColor: Colors.orange.shade700,
        color: Colors.white70,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.orangeAccent,
        padding: EdgeInsets.all(18),
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnaSayfa()));
              break;
            case 1:
              // current page
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notlar()));
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
            default:
              break;
          }
        },
        tabs: [
          GButton(icon: Icons.home, text: 'Anasayfa'),
          GButton(icon: Icons.add, text: 'Ekle'),
          GButton(icon: Icons.book, text: 'Notlarım'),
          GButton(icon: Icons.person, text: 'Hesabım'),
        ],
      ),
    );
  }

  Future<void> _addNote() async {
    try {
      await notes.add({'note': note});
      _fetchNotes();
      setState(() {
        note = '';
      });
    } catch (e) {
      print("Error adding note: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add note'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteNote(String noteId) async {
    try {
      await notes.doc(noteId).delete();
      _fetchNotes();
    } catch (e) {
      print("Error deleting note: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete note'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
