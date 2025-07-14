// socket_event.dart
abstract class SocketEvent {}

class ConnectEvent extends SocketEvent {}

class DisconnectEvent extends SocketEvent {}

class DriverLocationEvent extends SocketEvent {
  final String data;
  DriverLocationEvent(this.data);
}

class CarDriverLocationEvent extends SocketEvent {
  final String data;
  CarDriverLocationEvent(this.data);
}

class UserLocationEvent extends SocketEvent {
  final String data;
  UserLocationEvent(this.data);
}

class RideRequestEvent extends SocketEvent {
  final String data;
  RideRequestEvent(this.data);
}

class RideRequestAcceptedEvent extends SocketEvent {}

class RecieveChatMessageEvent extends SocketEvent {
  final String data;
  RecieveChatMessageEvent(this.data);
}
