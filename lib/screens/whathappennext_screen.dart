import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatHappen extends StatelessWidget {
  const WhatHappen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Color.fromARGB(255, 88, 83, 87),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 35),
            // color: Colors.red,
            width: 300,

        child: Column(
          children: [
            Text("What happens next?",style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(310, 68),
                  backgroundColor: const Color.fromARGB(255, 47, 47, 47),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  ),
              child: Text(
                "The crow saw a pot in a garden",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
           const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(310, 68),
                  backgroundColor: const Color.fromARGB(255, 47, 47, 47),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  )),
              child: Text(
                "The poor crow was so sad and didn${"'"}t know what to do.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,

                ),
                softWrap: true,
              ),
            ),
           const SizedBox(height: 15,),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(310, 68),
                  backgroundColor: const Color.fromARGB(255, 47, 47, 47),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  )),
              child: Text(
                "The crow kept working hard",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
           const SizedBox(height: 15,),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(310, 68),
                  backgroundColor: const Color.fromARGB(255, 47, 47, 47),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  )),
              child: Text(
                "The crow couldn't find any water",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
