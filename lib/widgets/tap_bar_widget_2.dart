import 'package:flutter/material.dart';

import 'package:refgo_courier/domain/order.dart';
import 'package:url_launcher/url_launcher.dart';

class TapBarWidget2 extends StatefulWidget {
  Order order;
  TapBarWidget2({super.key, required this.order});

  @override
  State<TapBarWidget2> createState() => _TapBarWidget2State();
}

class _TapBarWidget2State extends State<TapBarWidget2>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Column(
      children: [
        Container(
          child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  height: 20,
                  text: 'Доставка',
                ),
                Tab(
                  height: 20,
                  text: 'Фото',
                ),
                Tab(
                  height: 20,
                  text: 'Ответственный',
                )
              ]),
        ),
        Container(
          width: double.maxFinite,
          height: 300,
          child: TabBarView(controller: _tabController, children: [
            Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Получатель'),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Maris'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Конт. лицо'),
                        SizedBox(
                          width: 13,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              'Конт. лицоy456456456455345345345ertert43534rtwert54654t45t45t45t',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Телефон'),
                        SizedBox(
                          width: 28,
                        ),
                        Text('89161999984'),
                        IconButton(
                            onPressed: () {
                              _makePhoneCall('89161999984');
                            },
                            icon: Icon(Icons.ring_volume_sharp)),
                        IconButton(
                            onPressed: () {
                              _makeSmsSend('89161999984');
                            },
                            icon: Icon(Icons.sms))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Адрес'),
                        SizedBox(
                          width: 43,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              widget.order.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Время'),
                        SizedBox(
                          width: 41,
                        ),
                        Text('89161999984'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Примечание'),
                        SizedBox(
                          width: 1,
                        ),
                        Text('89161999984'),
                      ],
                    ),
                  ],
                )),
            Text('two'),
            Container(color: Colors.amber, child: Text('one')),
          ]),
        )
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSmsSend(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
