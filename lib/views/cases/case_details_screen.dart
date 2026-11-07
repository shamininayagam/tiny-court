import 'package:flutter/material.dart';

class CaseDetailsScreen extends StatelessWidget {
  final String caseId;
  const CaseDetailsScreen({super.key, required this.caseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Case Details')),
      body: Center(child: Text('Case Details Screen ($caseId)')),
    );
  }
}
