import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin{
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_controller);

    _controller.addListener(() {
      print(_controller.value);
      print(_colorAnimation.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFavorite = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFavorite = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: 30,
          ),
          onPressed: () {isFavorite ? _controller.reverse() : _controller.forward();},
        );
      },
    );
  }
}
