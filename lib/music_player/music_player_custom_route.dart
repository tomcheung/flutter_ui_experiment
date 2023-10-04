import 'package:flutter/material.dart';

class MusicNowPlayingRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  final Widget Function(BuildContext context, Animation<double> animation)
      builder;

  @override
  bool maintainState;

  MusicNowPlayingRoute({required this.builder, this.maintainState = true});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return _NowPlayingTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context, animation);
  }

  @override
  Widget buildContent(BuildContext context) {
    throw UnimplementedError();
  }
}

class _NowPlayingTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget? child;

  const _NowPlayingTransition({
    super.key,
    this.child,
    required this.animation,
    required this.secondaryAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class MusicPlayerHomeRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  final WidgetBuilder builder;

  MusicPlayerHomeRoute({required this.builder, this.maintainState = true});

  @override
  bool maintainState;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return _MusicPlayerHomeExitTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }

  @override
  Widget buildContent(BuildContext context) => builder(context);
}

class _MusicPlayerHomeExitTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget? child;

  const _MusicPlayerHomeExitTransition({
    super.key,
    this.child,
    required this.animation,
    required this.secondaryAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final fadeinAnimation2 = CurvedAnimation(
        parent: animation,
        curve: Curves.ease,
        reverseCurve: const Interval(0, 0.4, curve: Curves.ease));

    final fadeinAnimation = Tween(begin: 0.0, end: 1.0)
         .chain(CurveTween(curve: const Interval(0.6, 1, curve: Curves.ease)))
        .animate(fadeinAnimation2);

    final fadeoutAnimation = Tween(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: const Interval(0.0, 0.6, curve: Curves.ease)))
        .animate(secondaryAnimation);

    final scaleAnimation = Tween(begin: 1.0, end: 1.1)
        .chain(CurveTween(curve: const Interval(0.5, 1, curve: Curves.ease)))
        .animate(secondaryAnimation);

    final slideAnimation = Tween(
            begin: Offset.zero, end: const Offset(0, -0.3))
        .chain(CurveTween(curve: const Interval(0, 1, curve: Curves.easeIn)))
        .animate(secondaryAnimation);

    return FadeTransition(
      opacity: fadeinAnimation,
      child: Container(
        color: Colors.white,
        child: SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeoutAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
