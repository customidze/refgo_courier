import 'package:flutter/material.dart';

class ProgressInd extends StatefulWidget {
  const ProgressInd({super.key});

  @override
  State<ProgressInd> createState() => _ProgressIndState();
}

class _ProgressIndState extends State<ProgressInd>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  final List<double> _stops =
      List<double>.generate(2, (index) => index * 0.1 - 0);

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //controller!.reset();
          //controller!.forward();
          controller!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller!.forward();
        }
      });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Загрузка...'),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.green,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.black, spreadRadius: 1),
                  // ],
                  //border: const Border(left: BorderSide(width: 1,color: Colors.black),),
                  gradient: LinearGradient(
                    //transform: GradientRotation(100),
                    begin: const Alignment(1, 0),
                    end: const Alignment(-1, 0),
                    colors: const [
                      Colors.blue,
                      Colors.white,
                    ],
                    stops: _stops.map((e) => e + animation!.value).toList(),
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
            ),
            Container(
              width: 100,
              height: 15,
              decoration: BoxDecoration(
                  
                  gradient: LinearGradient(
                    //transform: GradientRotation(100),
                    // begin: Alignment(0 , 0),
                    // end: Alignment(1 , 1),
                    colors: const [
                      Colors.blue,
                      Colors.white,
                    ],
                    stops: _stops.map((e) => e + animation!.value).toList(),
                  ),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
          ],
        ),
      ],
    );
  }
}
