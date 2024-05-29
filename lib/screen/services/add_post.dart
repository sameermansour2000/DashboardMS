import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../auth/pallete.dart';
import '../auth/widgets/gradient_button.dart';
import '../auth/widgets/login_field.dart';

class AddServices extends StatefulWidget {
  const AddServices({Key? key}) : super(key: key);

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;

  TextEditingController name = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController late = TextEditingController();

  TextEditingController long = TextEditingController();

  TextEditingController info = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.3,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                      Pallete.gradient3,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.black87,
                        backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                        ),
                        radius: 70.0,
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: const Text(
                          "ADD Post    ...",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          selctFile.isNotEmpty
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      MemoryImage(selectedImageInBytes!),
                                  backgroundColor: Colors.red,
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      NetworkImage(defaultImageUrl),
                                  backgroundColor: Colors.red,
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () => selectFile(true),
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Color(0xffDE5D76),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      LoginField(
                        hintText: 'name',
                        controller: name,
                      ),

                      const SizedBox(height: 20.0),

                      LoginField(
                        hintText: 'info',
                        controller: info,
                      ),

                      const SizedBox(height: 20.0),

                      //InputField Widget from the widgets folder
                      LoginField(
                        hintText: 'late',
                        controller: late,
                      ),
                      const SizedBox(height: 20.0),

                      //InputField Widget from the widgets folder
                      LoginField(
                        hintText: 'long',
                        controller: long,
                      ),
                      const SizedBox(height: 20.0),

                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 130,
                            child: GradientButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: 'Cancel',
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          SizedBox(
                            width: 130,
                            child: GradientButton(
                              onTap: () {
                                if (selctFile.isNotEmpty &&
                                    late.text.isNotEmpty &&
                                    long.text.isNotEmpty &&
                                    info.text.isNotEmpty) {
                                  uploadFile().then((value) {
                                    info.clear();
                                    long.clear();
                                    late.clear();
                                    name.clear();
                                    selctFile = '';
                                  });
                                }
                              },
                              title: 'Post',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });

      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);

          imageCounts += 1;
        });
      });
    }
    print(selctFile);
  }

  selectFileProfile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });

      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);

          imageCounts += 1;
        });
      });
    }
    print(selctFile);
  }

  Future<String> uploadFile() async {
    String imageUrl = '';
    String postId = const Uuid().v1();
    DocumentReference addPost =
        FirebaseFirestore.instance.collection('posts').doc(postId);
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('posts')
          .child(FirebaseAuth.instance.currentUser!.uid);

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      // uploadTask = ref.putFile(File(file!.path));
      uploadTask = ref.putData(selectedImageInBytes!, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      addPost.set({
        "description": info.text,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "likes": [],
        "save": [],
        "username": name.text,
        "postId": postId,
        "datePublished": DateTime.now(),
        'postUrl': imageUrl,
        'profImage':
            'https://firebasestorage.googleapis.com/v0/b/instegram-bb63c.appspot.com/o/png-clipart-24-7-logo-24-7-service-customer-service-management-email-miscellaneous-blue-thumbnail.png?alt=media&token=e8fced33-8846-4c0a-a52d-b5449773c292',
        'late': double.parse(late.text),
        'long': double.parse(long.text),
      });
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }
}
