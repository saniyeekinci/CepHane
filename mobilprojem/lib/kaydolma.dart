import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/services/auth_services.dart';

import 'giris.dart';

class Kaydolma extends StatelessWidget {
  Kaydolma({Key? key}) : super(key: key);

final _tName= TextEditingController();
final _tSurName= TextEditingController();
final _tEmail= TextEditingController();
final _tPassword= TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade900, Colors.orange.shade50],
              begin: Alignment.topLeft, // Gradient başlangıç noktası
              end: Alignment.bottomRight, // Gradient bitiş noktası
              stops: [0.0, 1], // Renklerin geçişlerinin oranları (isteğe bağlı)
              tileMode: TileMode.clamp,
            ),
          ),
          child: SingleChildScrollView(
              child:Padding(
                padding:EdgeInsets.all(size.height* 0.060),
                child: OverflowBar(
                  overflowAlignment: OverflowBarAlignment.center,
                  overflowSpacing: size.height * 0.0045,
                  children: [
                    Image.asset('assets/login2.png'),
                    Text("Hoş Geldiniz!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text("Hesap Oluşturun",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size.height* 0.001),
                    TextField(
                      controller: _tName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:20.0),
                        filled: true,
                        hintText: "Ad",
                        prefixIcon: Icon(Icons.person, color: Colors.grey.shade400), // E-posta simgesi
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),


                    TextField(
                      controller: _tSurName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:20.0),
                        filled: true,
                        hintText: "Soyad",
                        prefixIcon: Icon(Icons.person, color: Colors.grey.shade400), // E-posta simgesi
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _tEmail,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:20.0),
                        filled: true,
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email, color: Colors.grey.shade400), // E-posta simgesi
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),

                    TextField(
                      controller: _tPassword,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:20.0),
                        filled: true,
                        hintText: "Şifre",
                        prefixIcon: Icon(Icons.lock, color: Colors.grey.shade400), // E-posta simgesi
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),
                    SizedBox(height: 1,),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: size.height*0.060,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(37),
                          ),
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),),

                        ),
                      onPressed: () async {
                        await AuthService().signUp(
                          context,
                          name: _tName.text,
                          surname: _tSurName.text,
                          email: _tEmail.text,
                          password: _tPassword.text,
                        );
                      },

                    ),
                    SizedBox(height: size.height * 0.002), // Araya boşluk eklemek için SizedBox kullandık
                    Text(
                      "----------Veya----------",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: size.height * 0.002),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: size.height*0.060,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(37),
                            color: Color.fromRGBO(225, 225, 225, 0.28),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 45,
                                spreadRadius: 0,
                                color: Color.fromRGBO(120, 40, 150, 0.25),
                                offset: Offset(0, 25),
                              ),
                            ],
                          ),
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),),

                        ), onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Giris()),
                      );
                    }
                    ),

                  ],
                ),
              )
          )
      ),
    );
  }
}
