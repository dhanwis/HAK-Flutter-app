



import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressButton extends StatefulWidget {
  final int totalSteps;
  final double size;

  const CircularProgressButton({
    super.key,
    this.totalSteps = 4,
    this.size = 80,
  });

  @override
  _CircularProgressButtonState createState() => _CircularProgressButtonState();
}

class _CircularProgressButtonState extends State<CircularProgressButton> {
  int _currentStep = 1;

  void _handleNextStep() {
    if (_currentStep < widget.totalSteps) {
      setState(() {
        _currentStep++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: GestureDetector(
          onTap: _handleNextStep,
          child: Container(
            width: widget.size * 0.7,
            height: widget.size * 0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter:  CircularProgressPainter(
                progress: _currentStep / widget.totalSteps,
              ),
              child: Center(
                child: Text(
                 _currentStep==4?'Finish': 'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.size * 0.14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start angle (top)
      2 * pi * progress, // Sweep angle based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
