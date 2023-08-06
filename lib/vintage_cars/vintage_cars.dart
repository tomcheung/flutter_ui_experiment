import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uichallenge/vintage_cars/car_info.dart';
import 'package:uichallenge/vintage_cars/car_info_card.dart';

import 'components.dart';

class VintageCars extends StatefulWidget {
  const VintageCars({super.key});

  @override
  State<VintageCars> createState() => _VintageCarsState();
}

class _VintageCarsState extends State<VintageCars> with TickerProviderStateMixin {
  static const startYear = 1959;

  final ScrollController _scrollController = ScrollController();
  int _currentYear = startYear;
  late AnimationController _animationController;
  late Animation<double> timelineOffsetAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, value: 0);
    timelineOffsetAnimation = Tween<double>(begin: 250, end: 45).animate(_animationController);
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
      itemBuilder: (ctx, i) =>
          Padding(
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
        title: const Text(
          'Timeline',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bug_report),
        onPressed: () {
          _animationController.animateTo(_animationController.value == 0 ? 1 : 0, duration: Duration(milliseconds: 1000));
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
            child:  Align(alignment: Alignment.bottomLeft, child: OverflowBox(alignment: Alignment.bottomLeft, child: _buildTimeline(context))),
          ),
          Expanded(
            child: BottomCarCard(carInfo: CarInfo.chevroletCorvetteC3, animationController: _animationController,),
            // child: StackedCard(
            //   itemBuilder: (i) => VintageCardTransition(
            //     darkChild: CarInfoCard(
            //       carInfo: CarInfo.chevroletCorvetteC3,
            //       darkBackground: true,
            //     ),
            //     whiteChild: CarInfoCard(
            //         carInfo: CarInfo.chevroletCorvetteC3,
            //         darkBackground: false),
            //     showDarkChild: !_isExpand,
            //   ),
            //   currentIndex: _currentYear - startYear,
            // ),
          ),
        ],
      ),
    );
  }
}

class BottomCarCard extends StatelessWidget {
  final AnimationController animationController;
  final CarInfo carInfo;

  const BottomCarCard({super.key, required this.carInfo, required this.animationController});

 @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VintageCardTransition(
          darkChild: CarInfoCard(
            carInfo: CarInfo.chevroletCorvetteC3,
            darkBackground: true,
          ),
          whiteChild: CarInfoCard(
            carInfo: CarInfo.chevroletCorvetteC3,
            darkBackground: false,
          ),
          transition: animationController,
        ),
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: Center(child: Handle(color:  Colors.red)),
        ),
      ],
    );
  }
}

class VintageCardTransition extends AnimatedWidget {
  final Widget darkChild;
  final Widget whiteChild;
  final Animation<double> _transition;

  const VintageCardTransition({
    super.key,
    required this.darkChild,
    required this.whiteChild,
    required Animation<double> transition,
  })
      : _transition = transition,
        super(listenable: transition);

  @override
  Widget build(BuildContext context) {
    // low2 + (value - low1) * (high2 - low2) / (high1 - low1)
    double mappedValue = -1 + _transition.value * (1.5 - -1);
    Alignment endAlign = Alignment(0, mappedValue);
    Alignment startAlign = Alignment(0, endAlign.y - 0.5);

    return Stack(
      children: [
        darkChild,
        ShaderMask(
          shaderCallback: (Rect bounds) =>
              LinearGradient(
                  begin: startAlign,
                  end: endAlign,
                  colors: const <Color>[Colors.transparent, Colors.black])
                  .createShader(bounds),
          blendMode: BlendMode.dstOut,
          child: whiteChild,
        ),
      ],
    );
  }
}
