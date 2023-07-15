import 'package:e_commerce_app/presentation/map_screen/downside_screen.dart';
import 'package:e_commerce_app/presentation/map_screen/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  void initState() {
    MapCubit.get(context).getPermission(context);
    MapCubit.get(context).getCurrentPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        var cubit = MapCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              cubit.latLng != null
                  ? GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: cubit.getCamerPosition(),
                      myLocationEnabled: true,
                      onMapCreated: (controller) {
                        cubit.gmc = controller;
                      },
                      mapType: MapType.normal,
                      markers: cubit.getMarkers(),
                      onCameraMove: (position) {
                        cubit.onCameraMove(position);

                        cubit.getPlaceName(position.target.latitude,
                            position.target.longitude);
                        print(" this is my position name ${cubit.getPlaceName(position.target.latitude,
                            position.target.longitude)}");
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              const DownSideContainer(),
            ],
          ),
        );
      },
    );
  }
}

class GetMyLocationButton extends StatelessWidget {
  final VoidCallback? getLocation;
  const GetMyLocationButton({
    super.key,
    this.getLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200.h,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.grey,
        ),
        child: IconButton(
            onPressed: getLocation,
            icon: const Icon(
              Icons.location_disabled_outlined,
              color: Colors.white,
            )),
      ),
    );
  }
}
