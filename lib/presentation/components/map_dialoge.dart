// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapDialog extends StatefulWidget {
//   const MapDialog({
//     Key? key,
//     required this.onPickedLocation,
//   }) : super(key: key);
//   final void Function(
//     LatLng position,
//     String formattedAddress,
//   ) onPickedLocation;
//   @override
//   State<MapDialog> createState() => _MapDialogState();
// }

// class _MapDialogState extends State<MapDialog> {
//   Marker? marker;
//   Set<Marker> markers = {};
//   var addressController = TextEditingController();
//   String? country, city, area;
//   @override
//   void initState() {
//     getCurrentLocation();
//     super.initState();
//   }

//   // static const CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(37.42796133580664, -122.085749655962),
//   //   zoom: 14.4746,
//   // );
//   late GoogleMapController _controller;
//   var initPoisition = const LatLng(21.422664, 39.825896);

//   @override
//   void dispose() {
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       height: MediaQuery.of(context).size.height,
//       width: double.infinity,
//       child: Theme(
//         data: Theme.of(context).copyWith(
//             inputDecorationTheme:
//                 const InputDecorationTheme(border: OutlineInputBorder())),
//         child: PlacePicker(
//           hidePlaceDetailsWhenDraggingPin: false,
//           // selectedPlaceWidgetBuilder:
//           //     (context, selectedPlace, state, isSearchBarFocused) =>
//           //         MyTextFormField(
//           //   controller: addressController,
//           //   maxlines: null,
//           //   isEnable: false,
//           //   title: 'address',
//           // ),
//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.end,
//           //   children: [
//           //     BottomSheet(
//           //       backgroundColor: Colors.white,
//           //       enableDrag: false,
//           //       shape: const RoundedRectangleBorder(
//           //           borderRadius:
//           //               BorderRadius.vertical(top: Radius.circular(26))),
//           //       onClosing: () {},
//           //       // builder: (_) => _PickedPlaceSheet(
//           //       //   isEdit: isEdit,
//           //       //   widget: widget,
//           //       //   result: selectedPlace,
//           //       //   nameController: nameController,
//           //       //   phoneController: phoneController,
//           //       // ),
//           //     ),
//           //   ],
//           // ),
//           // resizeToAvoidBottomInset: true,

//           apiKey: Platform.isAndroid
//               ? "AIzaSyDTJ3PIzFQ-S1Tju6Bz9kBVKh5ujHydcNs"
//               : "AIzaSyD_gg0kso2TWsWe2tBYTc7Nm-nNh_iONGQ",
//           hintText: "context.loc?.findAPlace",
//           // searchingText: "Please wait ...",
//           selectText: "context.loc?.selectYourAddress",
//           outsideOfPickAreaText: "context.loc?.placeNotInArea",
//           initialPosition: initPoisition,
//           // useCurrentLocation: true,
//           selectInitialPosition: true,
//           usePinPointingSearch: true,
//           usePlaceDetailSearch: true,
//           // zoomGesturesEnabled: true,
//           // zoomControlsEnabled: true,
//           // selectedPlaceWidgetBuilder: (context, selectedPlace, state, isSearchBarFocused) => ,

//           onMapCreated: (GoogleMapController controller) {
//             log("Map created");
//           },
//           onPlacePicked: (PickResult result) {
//             log("Place picked: ${result.formattedAddress}");
//             addressController.text = result.formattedAddress ?? '';
//             widget.onPickedLocation(
//               LatLng(
//                 result.geometry?.location.lat ?? 0,
//                 result.geometry?.location.lng ?? 0,
//               ),
//               addressController.text,
//             );
//             if (marker != null && addressController.text.isNotEmpty) {}
//             Navigator.pop(context);

//             // addAddressModelSheet(
//             //   context,
//             //   result,
//             //   nameController: nameController,
//             //   phoneController: phoneController,
//             // );
//           },
//         ),
//       ),

//       // child: GoogleMap(
//       //   myLocationEnabled: true,
//       //   initialCameraPosition: _kGooglePlex,
//       //   markers: markers,
//       //   onTap: (latLng) {
//       //     getAddressFromPosition(latLng);
//       //   },
//       //   onMapCreated: (GoogleMapController controller) {
//       //     _controller = controller;
//       //   },
//       // ),
//     );
//   }

//   Future<void> getCurrentLocation() async {
//     // var isLocationEnabled = await Geolocator.isLocationServiceEnabled();
//     // if (!isLocationEnabled) {
//     //   Geol
//     //   return;
//     // }

//     var permission = await Geolocator.requestPermission();

//     if (permission == LocationPermission.deniedForever) {
//       await Geolocator.openAppSettings();
//     }
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     try {
//       var position = await Geolocator.getCurrentPosition();

//       getAddressFromPosition(
//         LatLng(
//           position.latitude,
//           position.longitude,
//         ),
//       );
//       _controller.animateCamera(
//         CameraUpdate.newLatLngZoom(
//           LatLng(position.latitude, position.longitude),
//           15,
//         ),
//       );
//     } catch (e) {
//       log('error => $e');
//     }
//   }

//   Future<void> getAddressFromPosition(
//     LatLng latLng,
//   ) async {
//     // setState(() {
//     //   marker = Marker(
//     //     markerId: MarkerId(
//     //       latLng.latitude.toString(),
//     //     ),
//     //     position: LatLng(
//     //       latLng.latitude,
//     //       latLng.longitude,
//     //     ),
//     //   );
//     //   markers = {marker!};
//     // });
//     try {
//       var addressFromPosition =
//           await GeocodingPlatform.instance.placemarkFromCoordinates(
//         latLng.latitude,
//         latLng.longitude,
//         localeIdentifier: context.languageCode,
//       );
//       var first = addressFromPosition.first;
//       var address =
//           "${first.locality ?? ''}, ${first.administrativeArea ?? ''},${first.subLocality ?? ''}, ${first.subAdministrativeArea ?? ''},${first.street ?? ''}, ${first.country ?? ''},${first.thoroughfare ?? ''}";

//       log('address is => $address ${addressFromPosition.first}');
//       country = first.country;
//       city = first.administrativeArea;
//       area = first.subLocality?.isNotEmpty == true
//           ? first.subLocality
//           : first.thoroughfare?.isNotEmpty == true
//               ? first.thoroughfare
//               : first.locality?.isEmpty == true
//                   ? first.street
//                   : first.locality;

//       addressController.text = address;
//     } catch (error) {
//       log('addressError=> $error');
//     }
//   }
// }
