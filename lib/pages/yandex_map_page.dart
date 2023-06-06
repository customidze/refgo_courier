import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:geolocator/geolocator.dart';

class YandexMapPage extends StatefulWidget {
  late DrivingSessionResult result;
  late DrivingSession session;
  static double zoom = 13;

  YandexMapPage({super.key});
  // late final PlacemarkMapObject startPlacemark;
  // late final PlacemarkMapObject endPlacemark;

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  final Completer<YandexMapController> _completer = Completer();
  final List<MapObject> mapObjects = [];

  final List<DrivingSessionResult> results = [];
  bool follow_me = false;
  double zoomInState = 13;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List markers = (ModalRoute.of(context)?.settings.arguments ?? []) as List;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта'),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            YandexMap(
              // onMapTap: (argument) {
              //   print(157);
              //   positionStream.cancel();
              // },
              // onMapLongTap: (argument) {
              //   print(7879);
              // },
              onCameraPositionChanged: (cameraPosition, reason, finished) {
                //print(7896314);
                YandexMapPage.zoom = cameraPosition.zoom;

                if (reason.name == 'gestures') {
                  setState(() {
                    follow_me = false;
                  });
                  positionStream.cancel();
                }
              },
              mapObjects: mapObjects,
              onMapCreated: _onMapCreated,
            ),
            // follow_me
            //     ? const Center(child: Icon(Icons.add_location_sharp))
            //     : const SizedBox()
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: '1',
              child: const Icon(Icons.near_me),
              onPressed: () {
                positionStream;
                //print('done');
                cameraLL();
                // cameraLatLong(positionStream);
              }),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: '2',
              child: const Icon(Icons.route),
              onPressed: () {
                //createMarkers();
                addMarker(markers);
                // for (var element in markers) {

                //   addMarker(element['lat'], element['long']);

                //  }
              }),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: '3',
              child: const Icon(Icons.telegram),
              onPressed: () {
                //createMarkers();
                //addMarker(markers);
                showAllMarkers();
                // for (var element in markers) {

                //   addMarker(element['lat'], element['long']);

                //  }
              })
        ],
      ),
    );
  }

  void _onMapCreated(YandexMapController controller) {
    _completer.complete(controller);
    //controller.moveCamera(CameraUpdate.zoomTo(6));
    positionStream.onData((data) {
      cameraLatLong(data);
    });
  }

  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,

    //timeLimit: Duration(seconds: 3)
  )).listen((Position? position) {
    //var tt= zoomInState;
    if (position != null) {
      CameraUpdate.newCameraPosition(CameraPosition(
          zoom: YandexMapPage.zoom,
          //zoom: widget.zoom,
          target: Point(
              latitude: position.latitude, longitude: position.longitude)));
    }
  });

  void cameraLatLong(Position position) async {
    positionStream.resume();
    YandexMapController controller = await _completer.future;
    controller
        .moveCamera(
            animation: const MapAnimation(
              duration: 1,
            ),
            CameraUpdate.newCameraPosition(CameraPosition(
                zoom: 13,
                target: Point(
                    latitude: position.latitude,
                    longitude: position.longitude))))
        .then((value) {
      //add user position
      PlacemarkMapObject mark1 = PlacemarkMapObject(
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/user.png'),
              scale: 1)),
          isDraggable: true,
          mapId: const MapObjectId('me'),
          point: Point(
              latitude: position.latitude, longitude: position.longitude));

      setState(() {
        mapObjects.add(mark1);
        //add user position^^^^^

        follow_me = true;
      });
    });
  }

  void cameraLL() async {
    Position positionL = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    YandexMapController controllerL = await _completer.future;

    // PlacemarkMapObject mark1 = PlacemarkMapObject(
    //     icon: PlacemarkIcon.single(PlacemarkIconStyle(
    //         image: BitmapDescriptor.fromAssetImage('assets/user.png'),
    //         scale: 1)),
    //     isDraggable: true,
    //     mapId: const MapObjectId('me'),
    //     point: Point(
    //         latitude: positionL.latitude, longitude: positionL.longitude));

    // mapObjects.add(mark1);
    //var zoom = controllerL.getUserCameraPosition().

    controllerL
        .moveCamera(
            animation: const MapAnimation(duration: 1),
            CameraUpdate.newCameraPosition(CameraPosition(
                zoom: YandexMapPage.zoom,
                target: Point(
                    latitude: positionL.latitude,
                    longitude: positionL.longitude))))
        .then((value) {
      mapObjects.add(PlacemarkMapObject(
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/user.png'),
              scale: 1)),
          mapId: MapObjectId('me'),
          point: Point(
              latitude: positionL.latitude, longitude: positionL.longitude)));

      setState(() {
        follow_me = true;
      });
    });
  }

  void showAllMarkers() async {
    Position positionL = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    YandexMapController controllerL = await _completer.future;
    var test = await controllerL.getVisibleRegion();
    //controllerL.moveCamera(CameraUpdate.);
    //controllerL.moveCamera(CameraUpdate.newBounds(BoundingBox()));
    // controllerL.moveCamera(
    //     animation: const MapAnimation(duration: 1),
    //     CameraUpdate.newCameraPosition(CameraPosition(
    //         zoom: 13,
    //         target: Point(
    //             latitude: positionL.latitude,
    //             longitude: positionL.longitude))));
  }

  void addMarker(List markers) async {
    if (markers.isEmpty) {
      return;
    }
    YandexMapController controllerL = await _completer.future;
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    List<MapObject> placemarks = [];
    List<Point> listpoints = [];

    for (var element in markers) {
      listpoints
          .add(Point(latitude: element['lat'], longitude: element['long']));

      PlacemarkMapObject marker = PlacemarkMapObject(
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/route_end.png'),
              scale: 1)),
          isDraggable: true,
          mapId: MapObjectId(element.toString()),
          point: Point(latitude: element['lat'], longitude: element['long']));
      placemarks.add(marker);
      //mapObjects.addAll(marker);
    }

    controllerL.moveCamera(CameraUpdate.newBounds(
        BoundingBox(northEast: listpoints.first, southWest: listpoints.last)));

    // mapObjects.add(PolylineMapObject(
    //   mapId: MapObjectId('mapId'),
    //   polyline: Polyline(points: listpoints),
    //   strokeColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    //   strokeWidth: 3,
    // ));
    var resultWithSession = await _requestRoutes(listpoints);
    widget.result = await resultWithSession.result;
    widget.session = await resultWithSession.session;

    setState(() {
      follow_me = false;
      mapObjects.addAll(placemarks);
      widget.result.routes?.asMap().forEach((i, route) {
        mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: Colors.blue,
          //Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
      //if (mapObjects.isNotEmpty) {
//        mapObjects.clear();
      //    } else {
//        mapObjects.add(marker);
      //  }
    });
  }

  // void createMarkers() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   PlacemarkMapObject mark1 = PlacemarkMapObject(
  //       icon: PlacemarkIcon.single(PlacemarkIconStyle(
  //           image: BitmapDescriptor.fromAssetImage('assets/route_end.png'),
  //           scale: 1)),
  //       isDraggable: true,
  //       mapId: const MapObjectId('serp'),
  //       point:
  //           Point(latitude: position.latitude, longitude: position.longitude));

  //   setState(() {
  //     if (mapObjects.isNotEmpty) {
  //       mapObjects.clear();
  //     } else {
  //       mapObjects.add(mark1);
  //     }
  //   });
  // }

  static _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      return;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();

      return;
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      // print("latitude = ${position.latitude}");
      // print("longitude= ${position.longitude}");
    }
  }

  Future _requestRoutes(List listpoints) async {
    //print('Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');
    List<RequestPoint> listRequestPoints = [];

    for (var element in listpoints) {
      listRequestPoints.add(RequestPoint(
          point: element, requestPointType: RequestPointType.wayPoint));
    }

    var resultWithSession = YandexDriving.requestRoutes(
        points: listRequestPoints,
        // [
        //   RequestPoint(
        //       point: listpoints[0],
        //       requestPointType: RequestPointType.wayPoint),
        //   RequestPoint(
        //       point: listpoints[1],
        //       requestPointType: RequestPointType.viaPoint),
        //   RequestPoint(
        //       point: listpoints[2],
        //       requestPointType: RequestPointType.wayPoint),
        // ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));
    //print('Points: ');
    return resultWithSession;
  }
}



    // PlacemarkMapObject mark1 = PlacemarkMapObject(
    //     isDraggable: true,
    //     mapId: MapObjectId('serp'),
    //     point:
    //         Point(latitude: position.latitude, longitude: position.longitude));

    // setState(() {
    //   //if (mapObjects.isNotEmpty) {
    //   // mapObjects.clear();
    //   //} else {
    //   // mapObjects.add(mark1);
    //   // }
    // });