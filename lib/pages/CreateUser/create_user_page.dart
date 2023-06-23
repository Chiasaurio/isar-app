import 'package:dv_test/isar_service.dart';
import 'package:dv_test/pages/CreateUser/create_user_form.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create user')),
      body: SingleChildScrollView(child: CreateUserForm(service: service)),
    );
  }
}
