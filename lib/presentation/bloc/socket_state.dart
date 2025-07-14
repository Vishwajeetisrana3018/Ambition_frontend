// socket_state.dart
abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketDisconnected extends SocketState {}

class DriverLocationReceived extends SocketState {
  final String location;
  DriverLocationReceived(this.location);
}

class CarDriverLocationReceived extends SocketState {
  final String location;
  CarDriverLocationReceived(this.location);
}

class UserLocationReceived extends SocketState {
  final String location;
  UserLocationReceived(this.location);
}

class RideRequestReceived extends SocketState {
  final String request;
  RideRequestReceived(this.request);
}

class RideRequestAccepted extends SocketState {}

class SocketChatMessageReceived extends SocketState {
  final String message;
  SocketChatMessageReceived(this.message);
}
