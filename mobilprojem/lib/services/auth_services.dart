import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilprojem/anasayfa.dart';
import 'package:mobilprojem/giris.dart';
import 'package:mobilprojem/kaydolma.dart';

class AuthService{
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;





  Future<void> signUp(BuildContext context, {required String name, required String surname, required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _registerUser(name: name, surname: surname, email: email, password: password);
        navigator.push(MaterialPageRoute(builder: (context) => Giris(),));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }


  Future<void> signIn(BuildContext context , {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try{
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null){
        //navigator.push(MaterialPageRoute(builder: (context) => AnaSayfa(uid: userCredential.user!.uid ?? 'Kullanıcı Adı'),));
        navigator.push(MaterialPageRoute(builder: (context) => AnaSayfa(),));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }


  Future<void> _registerUser({required String name, required String surname , required String email, required String password}) async{
    try {
    await userCollection.doc(firebaseAuth.currentUser!.uid).set({
      "name": name,
      "surname": surname,
      "email": email,
      "password": password
    });//
}
    catch (e) {
      // Hata durumunda hata mesajını gösterin veya işlemi işleyin
      print("Hata: $e");
    }
  }

}