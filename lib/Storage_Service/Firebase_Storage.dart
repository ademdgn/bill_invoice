import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import '../Model/BillModel.dart';
import '../Model/UserModel.dart';
import '../Pages/Const/Utils.dart';

class Storage {
  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection("Person");

  Storage();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String currentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return "null";
    }
  }

  Future<void> addUser(Person person, UserCredential userCredential) async {
    await collectionUser.doc(userCredential.user?.uid).set({
      "name": person.name,
      "email": person.email,
      "password": person.password,
    });
  }

  Future<List<Map<String, dynamic>>> getBills() async {
    if (currentUser() != "null") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Bill')
            .where("isPaid", isEqualTo: false)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> billDocuments = querySnapshot.docs;
          List<Map<String, dynamic>> bills = [];

          for (QueryDocumentSnapshot document in billDocuments) {
            Map<String, dynamic> billData =
                document.data() as Map<String, dynamic>;

            bills.add(billData);
          }

          return bills;
        } else {
          return [];
        }
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
        return [];
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> paidBills() async {
    if (currentUser() != "null") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Bill')
            .where("isPaid", isEqualTo: true)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> billDocuments = querySnapshot.docs;
          List<Map<String, dynamic>> bills = [];

          for (QueryDocumentSnapshot document in billDocuments) {
            Map<String, dynamic> billData =
                document.data() as Map<String, dynamic>;

            bills.add(billData);
          }

          return bills;
        } else {
          return [];
        }
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
        return [];
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
      return [];
    }
  }

  Future<void> addBill(Map<String, dynamic> billData) async {
    if (currentUser() != "null") {
      try {
        CollectionReference billRef = await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Bill');

        DocumentReference reference = await billRef.add(billData);
        String billId = reference.id;
        Map<String, dynamic> data = {"billId": billId};
        await updateBill(billId, data);
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<void> updateBill(
      String billId, Map<String, dynamic> updatedData) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Bill')
            .doc(billId)
            .update(updatedData);
        print('Fatura başarıyla güncellendi.');
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<void> updatePerson(Map<String, dynamic> updatedData) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .update(updatedData);
        print('Kişi  başarıyla güncellendi.');
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<Map<String, dynamic>> getPerson() async {
    var personId = currentUser();
    Map<String, dynamic>? userList = {};
    var documentSnapshot = await collectionUser.doc(personId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      userList = data;
    } else {
      print('Belge bulunamadı.');
    }
    return userList;
  }

  Future<void> deleteBill(String billId) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Bill')
            .doc(billId)
            .delete();
        print('Fatura başarıyla silindi.');
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<String?> uploadProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('UserProfilePhoto')
        .child(currentUser())
        .child("profil.png");

    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final downloadURL = await storageRef.getDownloadURL();
      collectionUser.doc(currentUser()).update({"photoUrl": downloadURL});
      return downloadURL;
    } else {
      // Return null or an error message in case of an error.
      return null;
    }
  }
}
