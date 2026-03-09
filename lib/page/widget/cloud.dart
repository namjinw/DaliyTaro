import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../util/util.dart';

class Cloud extends StatefulWidget {
  const Cloud({super.key});

  @override
  State<Cloud> createState() => _CloudState();
}

class _CloudState extends State<Cloud> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        rightCloud(0.8, 70.0, 10.0),
        rightCloud(1.0, 50.0, -70.0),
        leftCloud(0.9, 65.0, -10.0),
        leftCloud(0.8, -5.0, -40.0),
        rightCloud(1.0, -20.0, 0.0),
      ],
    );
  }

  Widget rightCloud(opacity, bottom, right) => Positioned(
    right: right,
    bottom: bottom,
    child: Opacity(
      opacity: opacity,
      child: SizedBox(
        width: 220,
        child: Image.asset('assets/images/cloud.png', fit: BoxFit.contain),
      ),
    ),
  );

  Widget leftCloud(opacity, bottom, right) => Positioned(
    right: right,
    bottom: bottom,
    child: Transform(
      transform: .rotationY(math.pi),
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          width: 220,
          child: Image.asset('assets/images/cloud.png', fit: BoxFit.contain),
        ),
      ),
    ),
  );
}
