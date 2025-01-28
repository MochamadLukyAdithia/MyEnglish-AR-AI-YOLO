import 'package:flutter/material.dart';

class AllMentorScreen extends StatefulWidget {
  const AllMentorScreen({super.key});

  @override
  State<AllMentorScreen> createState() => _AllMentorScreenState();
}

class _AllMentorScreenState extends State<AllMentorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Ini All Mentor",
        ),
      ),
    );
  }
}
