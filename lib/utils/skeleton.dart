import 'package:flutter/material.dart';

class Skeletal extends StatefulWidget {
  final double height;
  final double width;
  final bool isIncognito;

  const Skeletal({
    super.key, // Use the null-safe Key type
    this.height = 20,
    this.width = 100,
    this.isIncognito = false,
  });

  @override
  SkeletonState createState() => SkeletonState();
}

class SkeletonState extends State<Skeletal>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _controller; // Mark as late to be initialized in initState
  late Animation<double>
      gradientPosition; // Mark as late to be initialized in initState

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a gradient combining grey, pink, and blue
    final gradientColors = [
      Colors.grey[400]!.withOpacity(0.3), // Grey
      Colors.green[400]!.withOpacity(0.5), // Pink
      Colors.blue[400]!.withOpacity(0.3), // Blue
    ];

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: const Alignment(-1, 0),
          colors: gradientColors,
        ),
      ),
    );
  }
}
