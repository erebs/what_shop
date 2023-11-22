// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   LatLng? selectedLocation;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Location'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0), // Initial map center
//           zoom: 15.0, // Initial zoom level
//         ),
//         onTap: _onMapTapped,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (selectedLocation != null) {
//             // Do something with the selectedLocation (latitude and longitude)
//             print('Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}');
//           } else {
//             // Handle case where no location is selected
//             print('No location selected');
//           }
//           Navigator.pop(context); // Close the map screen
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
//
//   void _onMapTapped(LatLng location) {
//     setState(() {
//       selectedLocation = location;
//       _moveCameraToLocation(location);
//     });
//   }
//
//   void _moveCameraToLocation(LatLng location) {
//     mapController.animateCamera(
//       CameraUpdate.newLatLng(location),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: MapScreen(),
//   ));
// }
