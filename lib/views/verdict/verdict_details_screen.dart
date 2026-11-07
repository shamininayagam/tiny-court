import 'package:flutter/material.dart';

class VerdictDetailsScreen extends StatelessWidget {
  final String caseId;
  const VerdictDetailsScreen({super.key, required this.caseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verdict')),
      body: Center(child: Text('Verdict Details Screen ($caseId)')),
    );
  }
}
