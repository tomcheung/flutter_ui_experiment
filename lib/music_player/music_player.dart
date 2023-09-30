import 'package:flutter/material.dart';
import 'package:flutter_ui_experiment/music_player/model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'music_player_home.dart';

class MusicPlayer extends StatelessWidget {
  static final sampleAlbum = List.generate(8, (index) {
    final sample = [
      Album(
        name: 'Modern Times',
        author: 'Bob Dylan',
        description:
            'Modern Times is the 32nd studio album by American singer-songwriter Bob Dylan, released on August 29, 2006, by Columbia Records. The album was the third work (following Time Out of Mind and Love And Theft) in a string of albums by Dylan that garnered wide acclaim from critics.',
        relatedDate: DateTime(1975),
        length: const Duration(minutes: 53),
        coverImage: const NetworkImage(
            'https://upload.wikimedia.org/wikipedia/en/2/28/Bob_Dylan_-_Modern_Times.jpg'),
      ),
      Album(
          name: '30',
          author: 'Adele',
          description:
              '30 is the first new music from Adele since the release of her third studio album 25 in November 2015. The album is produced with former collaborators Greg Kurstin, Max Martin and Shellback and Tobias Jesso Jr as well as new collaborators Inflo and Ludwig Goransson. The album is available on CD, Double BLACK VINYL LP, and digital formats. AMAZON will also have an EXCLUSIVE WHITE VINYL version of the LP. This is the CD version.',
          relatedDate: DateTime(2021, 10, 6),
          length: const Duration(minutes: 58),
          coverImage: const NetworkImage(
              'https://upload.wikimedia.org/wikipedia/en/7/76/Adele_-_30.png')),
      Album(
        name: 'Strangers',
        author: 'Kenya Grace',
        description:
            '"Strangers" is a song by Kenya Grace, released as her major-label debut single on 1 September 2023 through Major Recordings, a dance label owned by Warner Records. It is the follow-up to her 2023 viral single "Meteor".',
        relatedDate: DateTime(2023, 9, 1),
        length: const Duration(minutes: 2, seconds: 52),
        coverImage: const NetworkImage(
            'https://upload.wikimedia.org/wikipedia/en/6/6a/Kenya_Grace_-_Strangers.png'),
      ),
    ];
    return sample[index % sample.length];
  });

  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        textTheme: TextTheme(
            displayLarge: GoogleFonts.playfairDisplay(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w700)),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          backgroundColor: const Color(0xFFEFEFF0),
        ),
      ),
      child: MusicPlayerHome(albums: sampleAlbum),
    );
  }
}
