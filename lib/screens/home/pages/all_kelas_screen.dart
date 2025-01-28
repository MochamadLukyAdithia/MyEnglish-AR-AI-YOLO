import 'package:flutter/material.dart';

class AllKelasScreen extends StatefulWidget {
  const AllKelasScreen({super.key});

  @override
  State<AllKelasScreen> createState() => _AllKelasScreenState();
}

class _AllKelasScreenState extends State<AllKelasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Ini ALL kelas"),
      ),
    );
  }
}
