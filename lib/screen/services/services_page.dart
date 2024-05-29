import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data!.docs as List;
            return Container(
              margin: const EdgeInsets.all(6),
              child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 1500 ? 1 : 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 2,
                  childAspectRatio: MediaQuery.of(context).size.width <= 1500
                      ? MediaQuery.of(context).devicePixelRatio / 0.9
                      : MediaQuery.of(context).devicePixelRatio / 0.77,
                  children: List.generate(data.length, (index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                data[index]['postUrl'],
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            data[index]['profImage']),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(data[index]['username'] ?? '',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15.0)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  // InkWell(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   ServicesLocation(
                                  //                     late: data[index]['late'],
                                  //                     long: data[index]['long'],
                                  //                   )));
                                  //     },
                                  //     child: const Icon(
                                  //       Icons.location_on_rounded,
                                  //       color: Colors.red,
                                  //     )),
                                  // const SizedBox(
                                  //   width: 6,
                                  // ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.blueGrey,
                                    onPressed: () async {
                                      FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(data[index]['postId'])
                                          .delete();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                  })),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
