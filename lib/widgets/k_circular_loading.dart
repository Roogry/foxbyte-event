import 'dart:async';

import 'package:flutter/material.dart';

class KCircularLoading extends StatefulWidget {
  double? height;

  KCircularLoading({Key? key, this.height}) : super(key: key);

  @override
  _KCircularLoadingState createState() => _KCircularLoadingState();
}

class _KCircularLoadingState extends State<KCircularLoading>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(minutes: 1), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
      
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value / 100 > 1.0 ? 1.0 : animation.value / 100,
      child: SizedBox(
        height: animation.value,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
