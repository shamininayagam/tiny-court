import 'package:flutter/material.dart';

class CreateCaseScreen extends StatelessWidget {
  final String? templateId;
  const CreateCaseScreen({super.key, this.templateId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Case')),
      body: Center(child: Text('Create Case Screen (Template: $templateId)')),
    );
  }
}
