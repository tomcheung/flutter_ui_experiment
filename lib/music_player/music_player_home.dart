import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ui_experiment/music_player/music_player_component.dart';
import 'package:flutter_ui_experiment/music_player/music_player_now_playing.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model.dart';
import 'music_player_custom_route.dart';

class MusicPlayerHome extends StatefulWidget {
  final List<Album> albums;

  const MusicPlayerHome({super.key, required this.albums});

  @override
  State<MusicPlayerHome> createState() => _MusicPlayerHomeState();
}

class _MusicPlayerHomeState extends State<MusicPlayerHome> {
  final _albumCoverPageController =
      PageController(initialPage: 0, viewportFraction: 0.7);
  final _albumInfoPageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _albumInfoPageController.addListener(_syncController);
  }

  _syncController() {
    _albumCoverPageController.jumpTo(_albumInfoPageController.offset * 0.7);
  }

  @override
  void dispose() {
    _albumCoverPageController.dispose();
    _albumInfoPageController.dispose();
    super.dispose();
  }

  Widget _buildTitle(BuildContext context) => RichText(
        text: TextSpan(
            text: 'My ',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
            children: [
              TextSpan(
                text: 'Library',
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700),
              )
            ]),
      );

  Widget _buildInfoView(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.albums.length,
          controller: _albumInfoPageController,
          itemBuilder: (context, index) {
            return PageViewPerspectiveEffect(
                index: index,
                scrollAnimation: _albumInfoPageController,
                child: AlbumInfoView(album: widget.albums[index]));
          },
        ),
        Container(
          height: 20,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x4D616161), Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoverView(BuildContext context) {
    return PageView.builder(
      controller: _albumCoverPageController,
      itemCount: widget.albums.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Center(
          child: PageViewAnimationBuilder(
            index: index,
            scrollAnimation: _albumCoverPageController,
            builder: (context, offset, child) {
              final double padding = max(0, 1 - offset.abs()) * 70 + 10;
              return MusicAlbumCover(
                image: widget.albums[index].coverImage,
                position: index,
                padding: padding,
              );
            },
          ),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildTitle(context),
            ),
            SizedBox(
              height: 200,
              child: _buildCoverView(context),
            ),
            Container(
              height: 12,
              decoration: const BoxDecoration(
                  color: Color(0xFFEBEBEB),
                  boxShadow: [
                    BoxShadow(color: Color(0x3DA3A3A3), blurRadius: 8)
                  ]),
            ),
            Expanded(child: _buildInfoView(context)),
            GestureDetector(
                onTap: () {
                  final route = MusicNowPlayingRoute(
                      builder: (ctx, animation) => MusicPlayerNowPlaying(
                          enterTransitionAnimation: animation));
                  Navigator.push(context, route);
                },
                child: const PlayerInfoBar()),
            // const PlayerInfoBar(),
          ],
        ),
      ),
    );
  }
}
