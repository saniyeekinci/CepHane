import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/giris.dart';
import 'package:mobilprojem/main.dart';
import 'package:mobilprojem/notekleme.dart';
import 'package:mobilprojem/notlar.dart';

void main() {
  runApp(const ProfilePage());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;
  late User? user;
  Map<String, dynamic> userInfo = {//anahtar-değer (key-value) çiftlerini saklamak için kullanıla
    'name': '',
    'surname': '',
    'email': '',
    'password': '********'
  };

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        setState(() {
          userInfo = doc.data()!;
        });
      }
    } catch (e) {
      print("Kullanıcı bilgileri alınırken hata oluştu: $e");
    }
  }

  Future<void> _updateUserInfo(String field, String value) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({field: value});
      setState(() {
        userInfo[field] = value;
      });
    } catch (e) {
      print("Kullanıcı bilgileri güncellenirken hata oluştu: $e");
    }
  }

  void _showEditDialog(String field, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$field Düzenle'),
        content: TextField(
          controller: controller,
          obscureText: field == 'password',
          decoration: InputDecoration(hintText: "Yeni $field"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              _updateUserInfo(field, controller.text);
              Navigator.of(context).pop();
            },
            child: Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30, top: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade700, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 2), // Adjust this value to move the avatar up or down
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/login1.png'),
              ),
              const SizedBox(height: 20),
              itemProfile('Ad', userInfo['name'], Icons.person, 'Ad'),
              const SizedBox(height: 10),
              itemProfile('Soyad', userInfo['surname'], Icons.person, 'Soyad'),
              const SizedBox(height: 10),
              itemProfile('Email', userInfo['email'], Icons.mail, 'Email'),
              const SizedBox(height: 10),
              itemProfile('Şifre', userInfo['password'], Icons.password, 'Şifre'),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.orange.shade900,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Giris()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.white70, size: 25),
                      Text(
                        "Çıkış Yap",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotEkleme()));
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

  Widget itemProfile(String title, String subtitle, IconData iconData, String? field) {
    return GestureDetector(
      onTap: field != null
          ? () {
              _showEditDialog(field, subtitle);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.orange.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
