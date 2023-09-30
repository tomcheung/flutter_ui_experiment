import 'package:flutter/material.dart';
import 'package:flutter_ui_experiment/music_player/model.dart';
import 'package:flutter_ui_experiment/music_player/music_player.dart';

class PageViewPerspectiveEffect extends StatelessWidget {
  final PageController scrollAnimation;
  final int index;
  final Widget child;

  const PageViewPerspectiveEffect({
    super.key,
    required this.index,
    required this.scrollAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PageViewAnimationBuilder(
      index: index,
      scrollAnimation: scrollAnimation,
      child: child,
      builder: (context, offset, child) {
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0.0, -10.0, 0.0)
          ..rotateX(offset / 5)
          ..rotateY(-offset / 2)
          ..scale(1 - offset.abs() / 3);

        return Transform(
          alignment: Alignment(0 - offset / 2, -0.45),
          transform: transform,
          child: child,
        );
      },
    );
  }
}

class PageViewAnimationBuilder extends StatelessWidget {
  final PageController scrollAnimation;
  final int index;
  final Widget Function(BuildContext context, double offset, Widget? child)
      builder;
  final Widget? child;

  const PageViewAnimationBuilder({
    super.key,
    required this.index,
    required this.scrollAnimation,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollAnimation,
      child: child,
      builder: (context, child) {
        double offset = 0;
        if (scrollAnimation.position.hasContentDimensions) {
          offset = (scrollAnimation.page ?? 0) - index.toDouble();
        }

        return builder(context, offset, child);
      },
    );
  }
}

class AlbumInfoView extends StatelessWidget {
  final Album album;

  const AlbumInfoView({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    var titleTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 12,
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                'Album',
                style: titleTheme.displayLarge
                    ?.apply(color: Colors.grey, fontSizeFactor: 0.5),
              )
            ]),
            Text(
              album.name,
              style: titleTheme.displayLarge,
            ),
            const SizedBox(height: 18),
            RichText(
              text: TextSpan(
                text: 'By ',
                children: [
                  TextSpan(
                    text: album.author,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Text(
              '${album.relatedDate.year}  ${album.length.inMinutes} mins',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              album.description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicAlbumCover extends StatelessWidget {
  final ImageProvider image;
  final int position;
  final double padding;

  const MusicAlbumCover(
      {super.key,
      required this.position,
      this.padding = 30,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(padding, 0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/music_player/vinyl.png'),
                  ClipOval(
                      child: FractionallySizedBox(
                          widthFactor: 0.4, child: Image(image: image))),
                ],
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: DropdownShadow(
            child: Image(
              image: image,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }
                return Container(
                  color: Colors.grey,
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownShadow extends StatelessWidget {
  final Widget? child;

  const DropdownShadow({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShadowPainter(),
      child: child,
    );
  }
}

class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect =
        Rect.fromLTRB(-100, size.height * 0.7, size.width + 200, size.height);
    final p = Paint()
      ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black.withAlpha(10),
          ]).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..relativeLineTo(30, -50)
      ..relativeLineTo(-size.width - 60, 0);

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PlayerInfoBar extends StatelessWidget {
  const PlayerInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipOval(
                    child: Image(
                  image: MusicPlayer.sampleAlbum.first.coverImage,
                )),
                const CircularProgressIndicator(
                  value: 0.6,
                  color: Color(0xF0625C5B),
                  backgroundColor: Colors.white54,
                  strokeWidth: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            children: [
              Text('Dollar Days'),
              Text(
                'Dollar Days',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.play_arrow_outlined))
        ],
      ),
    );
  }
}
