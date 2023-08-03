part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class ChangeCameraPosition extends MapState {}

class GetPermissionSuccessState extends MapState {}

class GetPermissionFailedState extends MapState {}

class GetMarkersSuccessState extends MapState {}

class GetMarkersFailedState extends MapState {}

class GetCurrentPositionFailedState extends MapState {}

class GetCurrentPositionSuccessState extends MapState {}

class GetCameraPositionState extends MapState {}

class LocNameState extends MapState {}
