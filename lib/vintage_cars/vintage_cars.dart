import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uichallenge/vintage_cars/car_info.dart';
import 'package:uichallenge/vintage_cars/top_car_info.dart';

import 'car_detail_info.dart';
import 'components.dart';

class VintageCars extends StatefulWidget {
  const VintageCars({super.key});

  @override
  State<VintageCars> createState() => _VintageCarsState();
}

class _VintageCarsState extends State<VintageCars>
    with TickerProviderStateMixin {
  static const startYear = 1959;

  final ScrollController _scrollController = ScrollController();
  int _currentYear = startYear;
  late AnimationController _animationController;
  late Animation<double> timelineOffsetAnimation;
  late Animation<double> titleOpacityAnimation;

  late Animation<double> slideUpAnimation;
  late Animation<double> colorFadeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, value: 0);

    slideUpAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0, 0.4, curve: Curves.easeInSine));
    colorFadeAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0.4, 1, curve: Curves.easeOutSine));

    timelineOffsetAnimation =
        Tween<double>(begin: 250, end: 0).animate(slideUpAnimation);
    titleOpacityAnimation =
        Tween<double>(begin: 1, end: 0).animate(slideUpAnimation);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTimeline(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 45, 16, 16),
        child: TimelineYear(
          year: startYear + i,
          isHighlighted: startYear + i == _currentYear,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedBuilder(
          animation: titleOpacityAnimation,
          builder: (context, child) {
            return Opacity(opacity: titleOpacityAnimation.value, child: child);
          },
          child: const Text(
            'Timeline',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.bug_report),
        onPressed: () {
          _animationController.animateTo(
            _animationController.value == 0 ? 1 : 0,
            duration: const Duration(milliseconds: 1500),
          );
        },
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          AnimatedBuilder(
            animation: timelineOffsetAnimation,
            builder: (context, child) {
              return SizedBox(
                height: timelineOffsetAnimation.value,
                child: child,
              );
            },
            child: Align(
                alignment: Alignment.bottomLeft,
                child: OverflowBox(
                    alignment: Alignment.bottomLeft,
                    child: _buildTimeline(context))),
          ),
          Expanded(
            child: BottomCarCard(
              carInfo: CarInfo.chevroletCorvetteC3,
              slideUpAnimation: slideUpAnimation,
              colorFadeAnimation: colorFadeAnimation,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCarCard extends StatelessWidget {
  final Animation<double> slideUpAnimation;
  final Animation<double> colorFadeAnimation;
  final CarInfo carInfo;

  const BottomCarCard({
    super.key,
    required this.carInfo,
    required this.slideUpAnimation,
    required this.colorFadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final cornerRadiusAnimation = Tween<double>(begin: 24, end: 0).animate(
      CurvedAnimation(
        parent: slideUpAnimation,
        curve: const Interval(0.7, 1),
      ),
    );

    final colorSlideUpAnimation = Tween<double>(begin: 1.3, end: -1.3).animate(
      CurvedAnimation(
        parent: colorFadeAnimation,
        curve: const Interval(0, 0.8),
      ),
    );

    final detailSlideInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: colorFadeAnimation,
        curve: const Interval(0.3, 1),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: cornerRadiusAnimation,
          builder: (context, child) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(cornerRadiusAnimation.value),
                  topRight: Radius.circular(cornerRadiusAnimation.value),
                ),
              ),
              child: child,
            );
          },
          child: TopCarInfo(
            carInfo: carInfo,
            darkBackground: true,
          ),
        ),
        AnimatedBuilder(
            animation: colorSlideUpAnimation,
            builder: (context, child) {
              Alignment startAlign = Alignment(0, colorSlideUpAnimation.value);
              Alignment endAlign = Alignment(0, startAlign.y - 0.3);

              return ShaderMask(
                shaderCallback: (Rect bounds) => LinearGradient(
                        begin: startAlign,
                        end: endAlign,
                        colors: const <Color>[Colors.black, Colors.transparent])
                    .createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: child,
              );
            },
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  TopCarInfo(
                    carInfo: carInfo,
                    darkBackground: false,
                  ),
                  AnimatedBuilder(
                    animation: detailSlideInAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: detailSlideInAnimation.value,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              100 - detailSlideInAnimation.value * 100, 0, 0),
                          child: child,
                        ),
                      );
                    },
                    child: CarDetailInfo(info: carInfo),
                  ),
                ],
              ),
            )),
        const Positioned(
          top: 48,
          left: 0,
          right: 0,
          child: Center(child: Handle(color: Colors.grey)),
        ),
      ],
    );
  }
}
