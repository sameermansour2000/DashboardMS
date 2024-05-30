import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LatestTransactions extends StatefulWidget {
  const LatestTransactions({Key? key}) : super(key: key);

  @override
  _LatestTransactionsState createState() => _LatestTransactionsState();
}

class _LatestTransactionsState extends State<LatestTransactions> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _mainTabController;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Category'),
        bottom: TabBar(
          controller: _mainTabController,
          tabs: const [
            Tab(text: 'Offers'),
            Tab(text: 'Subscription'),
            Tab(text: 'Available Job'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _mainTabController,
        children: [
          OffersTab(),
          _buildSubscriptionPage(context),
          _buildAvailableJobPage(context),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPage(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Subscription')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var document = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              document['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Description: ${document['desc']}",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Subscription')
                                    .doc(document.id)
                                    .delete();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildAvailableJobPage(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Available_job')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var document = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              document['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Description: ${document['desc']}",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Available_job')
                                    .doc(document.id)
                                    .delete();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class OffersTab extends StatefulWidget {
  @override
  _OffersTabState createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> with SingleTickerProviderStateMixin {
  late TabController _offersTabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _offersTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _offersTabController.dispose();
    super.dispose();
  }
  final TextEditingController subCat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _offersTabController,
          tabs: const [
            Tab(text: 'Restaurant'),
            Tab(text: 'School Supplies'),
            Tab(text: 'Shops'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _offersTabController,
            children: [
              _buildRestaurantPage(context),
              _buildSchoolSuppliesPage(context),
              _buildShopsPage(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantPage(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Offers')
          .doc('Restaurant')
          .collection('data')
          .where('newSubCate', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var document = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              document['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Category: ${document['subCate']}",
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edit SubCategory'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextField(
                                              controller: subCat,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your SubCategory.',
                                                contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Approve'),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Offers')
                                                .doc('Restaurant')
                                                .collection('data')
                                                .doc(document.id)
                                                .update({'subCate': subCat.text});
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('Restaurant')
                                    .collection('data')
                                    .doc(document.id)
                                    .update({'newSubCate': false});
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(Icons.done),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('Restaurant')
                                    .collection('data')
                                    .doc(document.id)
                                    .delete();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  Widget _buildSchoolSuppliesPage(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Offers')
          .doc('School_supplies')
          .collection('data')
          .where('newSubCate', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var document = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              document['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Category: ${document['subCate']}",
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edit SubCategory'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextField(
                                              controller: subCat,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your SubCategory.',
                                                contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Approve'),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Offers')
                                                .doc('School_supplies')
                                                .collection('data')
                                                .doc(document.id)
                                                .update({'subCate': subCat.text});
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('School_supplies')
                                    .collection('data')
                                    .doc(document.id)
                                    .update({'newSubCate': false});
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(Icons.done),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('School_supplies')
                                    .collection('data')
                                    .doc(document.id)
                                    .delete();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget _buildShopsPage(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Offers')
          .doc('Shops')
          .collection('data')
          .where('newSubCate', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> data = snapshot.data!.docs;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var document = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              document['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Category: ${document['subCate']}",
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edit SubCategory'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextField(
                                              controller: subCat,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your SubCategory.',
                                                contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.lightBlueAccent,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Approve'),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Offers')
                                                .doc('Shops')
                                                .collection('data')
                                                .doc(document.id)
                                                .update({'subCate': subCat.text});
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('Shops')
                                    .collection('data')
                                    .doc(document.id)
                                    .update({'newSubCate': false});
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(Icons.done),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('Offers')
                                    .doc('Shops')
                                    .collection('data')
                                    .doc(document.id)
                                    .delete();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}
