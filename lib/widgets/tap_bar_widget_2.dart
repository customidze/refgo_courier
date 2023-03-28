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
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey)),
                //color: Colors.amber,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Получатель'),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(widget.order.recepientFIO),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Конт. лицо'),
                        const SizedBox(
                          width: 13,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              widget.order.customerContactPerson,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Телефон'),
                        const SizedBox(
                          width: 28,
                        ),
                        Text(widget.order.customerTel),
                        widget.order.customerTel != ''
                            ? IconButton(
                                onPressed: () {
                                  _makePhoneCall(widget.order.customerTel);
                                },
                                icon: const Icon(Icons.call_end_rounded,color: Colors.green,))
                            : const SizedBox(),
                        widget.order.customerTel != ''
                            ? IconButton(
                                onPressed: () {
                                  _makeSmsSend(widget.order.customerTel);
                                },
                                icon: const Icon(Icons.sms,color:Colors.green,))
                            : const SizedBox(),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Адрес'),
                        const SizedBox(
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
                    const Divider(),
                    Row(
                      children: [
                        const Text('Время'),
                        const SizedBox(
                          width: 41,
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                '${widget.order.windowStart.hour}:${widget.order.windowStart.minute}'),
                            const Text('  -  '),
                            Text(
                                '${widget.order.windowEnd.hour}:${widget.order.windowEnd.minute}'),
                            const Text('                  '),
                            Text(
                                '${widget.order.deliveryDate.day}.${widget.order.deliveryDate.month}.${widget.order.deliveryDate.year}'),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Примечание'),
                        const SizedBox(
                          width: 1,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              widget.order.note,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )),
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
