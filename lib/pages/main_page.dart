import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:refgo_courier/widgets/drawer_main.dart';
import 'package:refgo_courier/widgets/progress_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMain(),
      body: ProgressInd(),
    );
  }
}