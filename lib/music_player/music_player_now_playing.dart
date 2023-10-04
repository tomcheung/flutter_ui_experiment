import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayerNowPlaying extends StatefulWidget {
  final Animation<double> enterTransitionAnimation;

  const MusicPlayerNowPlaying({
    super.key,
    this.enterTransitionAnimation = const AlwaysStoppedAnimation(1),
  });

  @override
  State<MusicPlayerNowPlaying> createState() => _MusicPlayerNowPlayingState();
}

class _MusicPlayerNowPlayingState extends State<MusicPlayerNowPlaying> with TickerProviderStateMixin {
  late Animation _slideAnimation;
  late Animation _rotateAnimation;
  late Animation _opacityAnimation;

  @override
  void initState() {
    final masterController = widget.enterTransitionAnimation;
    _slideAnimation = masterController.drive(
        Tween(begin: -700.0, end: 0.0).chain(CurveTween(curve: const Interval(0.5, 1.0, curve: Curves.easeOut))));
    _rotateAnimation = masterController.drive(
        Tween(begin: 0.1, end: 0.9).chain(CurveTween(curve: const Interval(0.7, 1.0, curve: Curves.easeInOut))));
    _opacityAnimation = masterController.drive(
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: const Interval(0.4, 0.55, curve: Curves.linear))));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOW PLAYING', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: _NowPlayingEnterTransitionCover(
        enterTransitionAnimation: widget.enterTransitionAnimation,
        child: Container(
          color: Colors.white54,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) => Opacity(
                  opacity: _opacityAnimation.value,
                  child: _VinylPlayerView(
                    angle: _rotateAnimation.value,
                    yUpOffset: _slideAnimation.value,
                  ),
                ),
              ),
              const Text('David Bowie', style: TextStyle(fontSize: 24),),
              Text(
                'Dollar Days',
                style: GoogleFonts.playfairDisplay(fontSize: 58, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VinylPlayerView extends StatelessWidget {
  final double yUpOffset;
  final double angle;

  const _VinylPlayerView({super.key, this.angle = 0, this.yUpOffset = 0});

  @override
  Widget build(BuildContext context) {
    var transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..translate(0.0, yUpOffset, 0.0)
      ..rotateX(-angle);

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Transform(
          alignment: Alignment.center,
          transform: transform,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: Offset(0, 6),
                    color: Colors.black45,
                  )
                ],
              ),
              child: Image.asset('images/music_player/vinyl.png')),
        ),
      ),
    );
  }
}

class _NowPlayingEnterTransitionCover extends StatelessWidget {
  final Animation<double> enterTransitionAnimation;
  final Widget? child;

  const _NowPlayingEnterTransitionCover({
    super.key,
    required this.enterTransitionAnimation,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tween = CurveTween(curve: const Interval(0.3, 0.7, curve: Curves.easeIn));
    final slideAnimation = Tween(begin: Offset.zero, end: const Offset(0, -1))
        .chain(tween)
        .animate(enterTransitionAnimation);
    final fadeoutAnimation = Tween(begin: 1.0, end: 0.0)
        .chain(tween)
        .animate(enterTransitionAnimation);

    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(child: child),
        SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeoutAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 30,
                      color: Colors.black45,
                      offset: Offset(0, 6))
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
