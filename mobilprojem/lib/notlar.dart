import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/biyoloji.dart';
import 'package:mobilprojem/geometri.dart';
import 'package:mobilprojem/kimya.dart';
import 'package:mobilprojem/matematik.dart';
import 'package:mobilprojem/notekleme.dart';
import 'package:mobilprojem/profilepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Notlar(),
    );
  }
}

class Notlar extends StatelessWidget {

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade800,
        leading: Padding(
          padding: EdgeInsets.only(top: 24, left: 25),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white70),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              height: 200,
              child: Column(
                children: [
                  Text('Ders Notların ',
                      style: TextStyle(fontSize: 30, color: Colors.white70)),
                  SizedBox(height: 10),
                  Text(' Hep Elinin Altında',
                      style: TextStyle(fontSize: 30, color: Colors.white70)),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade800,
                    Colors.orange.shade400,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatematikPdf()),
                          );
                        },
                        child: SubjectContainer(imagePath: 'assets/math.png'),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatematikPdf()),
                          );
                        },
                        child: SubjectContainer(imagePath: 'assets/bio.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GeometriPdf()),
                          );
                        },
                        child: SubjectContainer(imagePath: 'assets/geo.png'),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KimyaPdf()),
                          );
                        },
                        child: SubjectContainer(imagePath: 'assets/kimya.png'),
                      ),
                    ],
                  ),
                ),
              ],
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
  selectedIndex: _selectedIndex,
  padding: EdgeInsets.all(18),
  onTabChange: (index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnaSayfa())); // AnaSayfa
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotEkleme())); // Not Ekleme
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Notlar())); // Notlarım
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())); // Hesabım
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
}

class SubjectContainer extends StatelessWidget {
  final String imagePath;

  SubjectContainer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orangeAccent.shade100,
            Colors.orangeAccent.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 10,
            spreadRadius: 0.0,
            offset: Offset(0, 7),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
