import 'package:flutter/material.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            color: Colors.green,
            child: const Center(child: Text('Меню')),
          ),
          ListTile(
            title: const Text('Сетевые настройки'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/network');
            },
          ),
          ListTile(
            title: const Text('Настройки Ibox'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/ibox');
            },
          ),
        ],
      ),
    );
  }
}
