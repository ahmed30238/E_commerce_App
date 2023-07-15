import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(context) => BlocProvider.of(context);

  Set<Marker> markers = <Marker>{};
  GoogleMapController? gmc;

  @override
  Future<void> close() {
    gmc!.dispose();
    return super.close();
  }

  Future getPermission(BuildContext context) async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (!services) {
      // ignore: use_build_context_synchronously
      // showDialog(
      //   context: context,
      //   builder: (context) => CustomDialog(
      //     title: "title",
      //     image: Assets.imagesProfile,
      //     onButtonPressed: () {},
      //   ),
      // );
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
    return per;
  }

  onCameraMove(CameraPosition pos) {
    latLng = LatLng(pos.target.latitude, pos.target.longitude);
    emit(ChangeCameraPosition());
  }

  CameraPosition getCamerPosition() {
    cameraPosition = CameraPosition(target: latLng!);
    return cameraPosition!;
  }

  CameraPosition? cameraPosition;

  LatLng? latLng;
  Future<void> getCurrentPosition(BuildContext context) async {
    getPermission(context);
    var cl = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then(
      (value) => value,
    );
    latLng = LatLng(cl.latitude, cl.longitude);
    emit(GetCurrentPositionSuccessState());
  }

  getPlaceName(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    emit(LocNameState());
    return placemarks.first;
  }

  Set<Marker> getMarkers() {
    markers.clear();
    markers.add(
      Marker(
          markerId: MarkerId(
            latLng.toString(),
          ),
          position: latLng!),
    );
    return markers;
  }
}
