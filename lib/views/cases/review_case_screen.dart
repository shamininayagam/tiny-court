import 'package:flutter/material.dart';

class ReviewCaseScreen extends StatelessWidget {
  final String caseId;
  const ReviewCaseScreen({super.key, required this.caseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Docket')),
      body: Center(child: Text('Review Case Screen ($caseId)')),
    );
  }
}
