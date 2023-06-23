import 'package:dv_test/pages/CreateUser/create_user_page.dart';
import 'package:dv_test/pages/user_detail.dart';
import 'package:dv_test/pages/users_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => UsersPage(),
        '/create-user': (context) => CreateUserPage(),
        '/user-detail': (context) => const UserDetail(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}
