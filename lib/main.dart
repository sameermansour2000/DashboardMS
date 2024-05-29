import 'package:fintech_dashboard_clone/controller/home_provider.dart';
import 'package:fintech_dashboard_clone/screen/auth/login_screen.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/map_provider.dart';
import 'layout/app_layout.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBDkB2s8-wGtyVoIw8dQ98KU1jNdZz2pCo",
        authDomain: "moneysaving-bff46.firebaseapp.com",
        projectId: "moneysaving-bff46",
        storageBucket: "moneysaving-bff46.appspot.com",
        messagingSenderId: "137120661327",
        appId: "1:137120661327:web:ec080e10f1c85d46178f3a",
        measurementId: "G-XMEH14N528"),
  );
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProviderController(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Money Saving',
            theme: ThemeData(
              scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
              scrollbarTheme: Styles.scrollbarTheme,
            ),
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                initialData: FirebaseAuth.instance.currentUser,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return LoginScreen();
                  } else {
                    return const HomePage();
                  }
                })));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    var pro = Provider.of<HomeController>(context);
    return Scaffold(
      body: SafeArea(
        child: FirebaseAuth.instance.currentUser != null
            ? AppLayout(
                content: pro.page[pro.currentPage],
              )
            : LoginScreen(),
      ),
    );
  }
}
