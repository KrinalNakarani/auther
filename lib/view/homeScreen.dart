import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/authController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  AuthController auth = Get.put(AuthController());

  TextEditingController name = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController auther_name = TextEditingController();
  TextEditingController about_auther = TextEditingController();
  TextEditingController about_book = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController publish_year = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Books"),
          centerTitle: true,
          backgroundColor: Colors.pink.shade300,
        ),
          body: StreamBuilder(
      stream: auth.readData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData) {
          print("====================${snapshot.data.snapshot}");

          List<Modelbook> l1 = [];
          DataSnapshot data = snapshot.data.snapshot;

          for (var x in data.children) {
            Modelbook r1 = Modelbook(
                name: x.child("name").value.toString(),
                img: x.child("img").value.toString(),
                auther_name: x.child("auther_name").value.toString(),
                about_auther: x.child("about_auther").value.toString(),
                about_book: x.child("about_book").value.toString(),
                rating: x.child("rating").value.toString(),
                publish_year: x.child("publish_year").value.toString(),
                key: x.key);
            l1.add(r1);
          }

          return ListView.builder(
              itemCount: l1.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network("${l1[index].img}"),
                  title: Text("${l1[index].name}"),
                  subtitle: Text("${l1[index].rating}"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            name = TextEditingController(text: l1[index].name);
                            img = TextEditingController(text: l1[index].img);
                            auther_name = TextEditingController(text: l1[index].auther_name);
                            about_auther = TextEditingController(text: l1[index].about_auther);
                            about_book = TextEditingController(text: l1[index].about_book);
                            rating = TextEditingController(text: l1[index].rating);
                            publish_year = TextEditingController(text: l1[index].publish_year);
                            DialogBox(l1[index].key.toString());
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            auth.Delete(l1[index].key);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            name = TextEditingController();
            img = TextEditingController();
            auther_name = TextEditingController();
            about_auther = TextEditingController();
            about_book = TextEditingController();
            rating = TextEditingController();
            publish_year = TextEditingController();
            DialogBox(null);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  void DialogBox(String? key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 640,
                child: Column(
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "name",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: img,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "img",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: auther_name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "auther name",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: about_auther,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "about auther",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: about_book,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "about book",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: rating,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "rating",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: publish_year,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "publish year",
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                       auth.AddData(
                            name: name.text,
                            img: img.text,
                           auther_name: auther_name.text,
                           about_auther: about_auther.text,
                           about_book: about_book.text,
                           rating: rating.text,
                           publish_year: publish_year.text,
                            key: key);
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
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
