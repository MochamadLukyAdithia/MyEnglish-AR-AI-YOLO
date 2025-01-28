import 'package:duo_clone/widgets/myicon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duo_clone/widgets/mybutton.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';

Column headerPath() {
  return Column(
    spacing: 0,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Row(
          children: [
            Text(
              "Halo Luky 👋",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Spacer(),
            MyButton(
              icon: Myicon.notif,
              pressed: () {},
            )
          ],
        ),
      ),
      Text(
        "Sudah siap untuk belajar hari ini?",
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
