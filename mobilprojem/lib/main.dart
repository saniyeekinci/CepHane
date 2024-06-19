import 'package:flutter/material.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/profilepage.dart';
import 'package:mobilprojem/video_info.dart';
import 'package:mobilprojem/giris.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilprojem/video_info.dart';

//Flutter'da bir splash ekranı oluşturarak belirli bir süre sonra
// başlangıç ekranından ana sayfaya geçiş yapmayı sağlar.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter UI tut",
      home: Giris(),
    );
  }
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    // Burada, Future.delayed yöntemiyle 3 saniye bekleyip sonra
    // Navigator.push kullanarak Anasa  yfa widget'ına geçiş yapıyorsunuz:
    Future.delayed(Duration(seconds: 3),
            (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Giris()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
