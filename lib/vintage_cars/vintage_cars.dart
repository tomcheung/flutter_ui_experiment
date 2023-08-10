import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uichallenge/vintage_cars/car_info.dart';
import 'package:uichallenge/vintage_cars/stacked_card.dart';
import 'package:uichallenge/vintage_cars/top_car_info.dart';

import 'car_detail_info.dart';
import 'components.dart';

const double kCardBorderRadius = 24;

class VintageCars extends StatefulWidget {
  const VintageCars({super.key});

  @override
  State<VintageCars> createState() => _VintageCarsState();
}

class _VintageCarsState extends State<VintageCars>
    with TickerProviderStateMixin {
  static const startYear = 1959;

  final ItemScrollController _scrollController = ItemScrollController();
  int _currentYear = startYear;
  var _showAppbar = true;
  var _cardExpened = false;
  late AnimationController _animationController;
  late Animation<double> timelineOffsetAnimation;
  late Animation<double> titleOpacityAnimation;

  late Animation<double> slideUpAnimation;
  late Animation<double> colorFadeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, value: 0);

    slideUpAnimation = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.4, curve: Curves.easeInSine));
    colorFadeAnimation = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1, curve: Curves.easeOutSine));

    timelineOffsetAnimation =
        Tween<double>(begin: 250, end: 0).animate(slideUpAnimation);
    titleOpacityAnimation =
        Tween<double>(begin: 1, end: 0).animate(slideUpAnimation);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // _animationController.
        setState(() {
          _cardExpened = true;
        });
      }

      if (status == AnimationStatus.completed) {
        setState(() {
          _showAppbar = _animationController.value < 1;
        });

        if (_animationController.value == 0) {
          setState(() {
            _cardExpened = false;
          });
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTimeline(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _scrollController,
      itemCount: 50,
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

  Widget _buildBottomCard(BuildContext context) {
    return Stack(
      children: [
        StackedCard(
          cornerRadius: kCardBorderRadius,
          onIndexChange: (index) {
            setState(() {
              _currentYear = index + startYear;
            });
            _scrollController.scrollTo(
                index: index,
                alignment: 0.4,
                duration: const Duration(milliseconds: 200));
          },
          itemBuilder: (index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kCardBorderRadius),
                  topRight: Radius.circular(kCardBorderRadius),
                ),
              ),
              child: TopCarInfo(
                carInfo: CarInfo(
                  name: 'Chevrolet Corvette C3',
                  year: startYear + index,
                ),
                darkBackground: true,
                onVerticalDragUpdate: _handleDrag,
              ),
            );
          },
        ),
        Visibility(
          visible: _cardExpened,
          child: BottomCarCard(
            carInfo: CarInfo(name: 'Chevrolet Corvette C3', year: _currentYear),
            animationController: _animationController,
            slideUpAnimation: slideUpAnimation,
            colorFadeAnimation: colorFadeAnimation,
            onVerticalDragUpdate: _handleDrag,
          ),
        ),
      ],
    );
  }

  void _handleDrag(DragUpdateDetails d) {
    const duration = Duration(milliseconds: 1500);
    if (d.delta.dy < -0.5 && _animationController.value == 0) {
      _animationController.animateTo(1, duration: duration);
    } else if (d.delta.dy > 0.5 && _animationController.value == 1) {
      _animationController.animateTo(0, duration: duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _showAppbar
          ? AppBar(
              centerTitle: true,
              title: AnimatedBuilder(
                animation: titleOpacityAnimation,
                builder: (context, child) {
                  return Opacity(
                      opacity: titleOpacityAnimation.value, child: child);
                },
                child: const Text(
                  'Timeline',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            )
          : null,
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
                  child: _buildTimeline(context)),
            ),
          ),
          Expanded(child: _buildBottomCard(context)),
        ],
      ),
    );
  }
}

class BottomCarCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> slideUpAnimation;
  final Animation<double> colorFadeAnimation;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final CarInfo carInfo;

  const BottomCarCard({
    super.key,
    required this.carInfo,
    required this.animationController,
    required this.slideUpAnimation,
    required this.colorFadeAnimation,
    this.onVerticalDragUpdate,
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
        curve: const Interval(0.5, 1),
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
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  TopCarInfo(
                    carInfo: carInfo,
                    darkBackground: false,
                    onVerticalDragUpdate: onVerticalDragUpdate,
                  ),
                  AnimatedBuilder(
                    animation: detailSlideInAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: detailSlideInAnimation.value,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              0, 200 - detailSlideInAnimation.value * 200, 0),
                          child: child,
                        ),
                      );
                    },
                    child: CarDetailInfo(info: carInfo),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
