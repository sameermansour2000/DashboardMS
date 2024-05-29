// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
//
// import '../../controller/map_provider.dart';
//
// class ServicesLocation extends StatefulWidget {
//   const ServicesLocation({Key? key, required this.late, required this.long})
//       : super(key: key);
//   final double late;
//   final double long;
//
//   @override
//   State<ServicesLocation> createState() => _ServicesLocationState();
// }
//
// class _ServicesLocationState extends State<ServicesLocation>
//     with TickerProviderStateMixin {
//   MapController mapController = MapController();
//
//   Timer? timer;
//
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     mapController = MapController();
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       lowerBound: 0.5,
//       duration: const Duration(seconds: 3),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     timer?.cancel();
//     mapController.dispose();
//     super.dispose();
//   }
//
//   void _animatedMapMove(LatLng destLocation, double destZoom) {
//     final latTween = Tween<double>(
//         begin: mapController.center.latitude, end: destLocation.latitude);
//     final lngTween = Tween<double>(
//         begin: mapController.center.longitude, end: destLocation.longitude);
//     final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);
//
//     final controller = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//
//     final Animation<double> animation =
//         CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
//
//     controller.addListener(() {
//       mapController.move(
//           LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
//           zoomTween.evaluate(animation));
//     });
//
//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.dispose();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.dispose();
//       }
//     });
//
//     controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var x = Provider.of<ProviderController>(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           title: const Text("Services "),
//           elevation: 0,
//         ),
//         body: Stack(
//           children: [
//             FlutterMap(
//               key: ValueKey(MediaQuery.of(context).orientation),
//               options: MapOptions(
//                 controller: mapController,
//                 onMapCreated: (c) {
//                   mapController = c;
//                 },
//                 maxZoom: 22,
//                 minZoom: 3,
//                 zoom:15,
//                 onPositionChanged: (center, val) {},
//                 plugins: [
//                   MarkerClusterPlugin(),
//                   const LocationMarkerPlugin(),
//                 ],
//                 center: LatLng(widget.late, widget.long),
//               ),
//               layers: [
//                 TileLayerOptions(
//                   urlTemplate:
//                       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 MarkerLayerOptions(markers: [
//                   Marker(
//                       width: 80,
//                       height: 80,
//                       point: LatLng(widget.late, widget.long),
//                       builder: (BuildContext context) => const Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: 40,
//                           )),
//                 ]),
//               ],
//             ),
//             Positioned(
//                 bottom: 40,
//                 right: 15,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   color: Colors.white,
//                   elevation: 2,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.my_location,
//                       size: 26,
//                       color: Colors.blue,
//                     ),
//                     onPressed: () {
//                       // x.endValue(true);
//                       x.getCurrentLocation().whenComplete(() {
//                         _animatedMapMove(LatLng(x.lat!, x.long!), 13);
//                         // mapController.move(LatLng(x.lat!, x.long!), 13);
//                       });
//                       // mapController.move(LatLng(lat, long), 13);
//                     },
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
