import 'package:flutter/material.dart';

class CourtroomScreen extends StatelessWidget {
  final String caseId;
  const CourtroomScreen({super.key, required this.caseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courtroom')),
      body: Center(child: Text('Courtroom Screen ($caseId)')),
    );
  }
}
