import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ServiceDbPage extends StatelessWidget {
  const ServiceDbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Обслуживание БД'),centerTitle: true,),);
  }
}