import 'package:duo_clone/screens/home/layouts/banner.dart';
import 'package:duo_clone/screens/home/layouts/kelasPath.dart';
import 'package:duo_clone/screens/home/layouts/mentorPath.dart';
import 'package:duo_clone/utils/constans.dart';
import 'package:duo_clone/screens/home/layouts/headerPath.dart';
import 'package:duo_clone/screens/home/layouts/searchPath.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerPath(),
                searchPath(),
                bannerPath(),
                mentorPath(),
                kelasPath(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
