import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  void AddData(
      {String? name,
      String? img,
      String? auther_name,
      String? about_auther,
      String? about_book,
      String? rating,
      String? publish_year,
      String? key}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();

    if (key == null) {
      FDBref.child("Books").push().set({
        "id": name,
        "img": img,
        "title": auther_name,
        "cate": about_auther,
        "desc": about_book,
        "img": rating,
        "img": publish_year
      });
    } else {
      FDBref.child("Recipe").child(key).set({
        "id": name,
        "img": img,
        "title": auther_name,
        "cate": about_auther,
        "desc": about_book,
        "img": rating,
        "img": publish_year
      });
    }
  }

  Stream<DatabaseEvent> readData() {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    return FDBref.child("Books").onValue;
  }

  void Delete(String? key) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    FDBref.child("Books").child(key!).remove();
  }
}

class Modelbook {
  String? name,
      img,
      auther_name,
      about_auther,
      about_book,
      rating,
      publish_year,
      key;

  Modelbook(
      {this.name,
      this.img,
      this.auther_name,
      this.about_auther,
      this.about_book,
      this.rating,
      this.publish_year,
      this.key});
}

/*
name
imge link
auther name
about auther
about book
rating
publish year
 */
