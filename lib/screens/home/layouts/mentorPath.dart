import 'package:duo_clone/screens/home/pages/all_mentor_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mentorPath extends StatelessWidget {
  const mentorPath({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Belajar dengan mentor terbaik",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AllMentorScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Lihat Semua",
                  style: GoogleFonts.inter(
                      color: Colors.blueAccent.shade200,
                      fontSize: 14,
                      fontStyle: FontStyle.normal),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Image.asset(
                      "./assets/images/mentor.png",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mrs.Hana",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Image.asset(
                      "./assets/images/mentor.png",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mrs.Hana",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
