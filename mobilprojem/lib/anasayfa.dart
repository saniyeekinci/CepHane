import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobilprojem/notlar.dart';
import 'package:mobilprojem/profilepage.dart';
import 'package:mobilprojem/video_info.dart';
import 'package:mobilprojem/video_info2.dart';
import 'package:mobilprojem/video_info3.dart';
import 'package:mobilprojem/video_info4.dart';
import 'notekleme.dart';

class AnaSayfa extends StatefulWidget {
  AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 0;
  String? userId;
  

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<String> getUserName() async {
    if (userId == null) {
      throw Exception('User ID is null');
    }
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: PreferredSize(//appbar büyütmk için kullanılır 
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.orange.shade700,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.deepOrange.shade700),
                    ),
                  ),
                  FutureBuilder<String>(
                    future: getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(color: Colors.white);
                      } else if (snapshot.hasError) {
                        return Text('Hata: ${snapshot.error}');
                      } else {
                        String? userName = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hoş geldin, $userName',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'Cephane',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(//üst üste binen widgetı düzenler
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.49, // Mor kutunun yüksekliği artırıldı
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 4),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        'Başarı, küçük çabaların tekrar edilmesiyle elde edilir.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Robert Collier',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -19,
            right: 20,
            left: 224,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset(
              'assets/indirim.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Kurslar',
                style: TextStyle(
                  color: Colors.orangeAccent.shade400,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28 - 10,
            left: 12,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/math.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.orange.shade700.withOpacity(0.9),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'İntegral',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28 - 10,
            left: 205,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoInfo2()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/geo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.orange.shade700.withOpacity(0.9),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Çember ve Daire',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28 + 150,
            left: 12,
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoInfo3()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/bio.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.orange.shade700.withOpacity(0.9),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Bitki Biyolojisi',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28 + 150,
            left: 205,
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoInfo4()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/kimya.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.orange.shade700.withOpacity(0.9),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Organik Kimya',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
