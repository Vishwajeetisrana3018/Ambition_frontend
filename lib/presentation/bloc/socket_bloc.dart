import 'package:ambition_delivery/presentation/bloc/socket_event.dart';
import 'package:ambition_delivery/presentation/bloc/socket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  IO.Socket? _socket;

  SocketBloc() : super(SocketInitial()) {
    _connect();
    on<ConnectEvent>((event, emit) {
      emit(SocketConnected());
    });

    on<DisconnectEvent>((event, emit) {
      emit(SocketDisconnected());
    });

    on<DriverLocationEvent>((event, emit) {
      emit(DriverLocationReceived(event.data));
    });

    on<CarDriverLocationEvent>((event, emit) {
      emit(CarDriverLocationReceived(event.data));
    });

    on<UserLocationEvent>((event, emit) {
      emit(UserLocationReceived(event.data));
    });

    on<RideRequestEvent>((event, emit) {
      emit(RideRequestReceived(event.data));
    });

    on<RideRequestAcceptedEvent>((event, emit) {
      emit(RideRequestAccepted());
    });

    on<RecieveChatMessageEvent>((event, emit) {
      emit(SocketChatMessageReceived(event.data));
    });
  }

  void _connect() {
    _socket = IO.io('https://ambitionbackend-258e6c7522d2.herokuapp.com',
        IO.OptionBuilder().setTransports(['websocket']).build());

    _socket?.onConnect((_) {
      add(ConnectEvent());
    });

    _socket?.onDisconnect((_) => add(DisconnectEvent()));
  }

  /// Subscribe to specific events with dynamic channels (e.g., user ID)
  void subscribeToEvents(String? userId) {
    if (userId == null) return;
    _socket?.on('driver_location_update_$userId', (data) {
      add(DriverLocationEvent(data.toString()));
    });

    _socket?.on('car_driver_location_update_$userId', (data) {
      add(CarDriverLocationEvent(data.toString()));
    });

    _socket?.on('user_location_update_$userId', (data) {
      add(UserLocationEvent(data.toString()));
    });

    _socket?.on('ride_request_$userId', (data) {
      add(RideRequestEvent(data.toString()));
    });

    _socket?.on('ride_request_accepted_$userId', (_) {
      add(RideRequestAcceptedEvent());
    });

    _socket?.on('chat_message_$userId', (data) {
      add(RecieveChatMessageEvent(data.toString()));
    });
  }

  /// Unsubscribe from specific events
  void unsubscribeFromEvents(String? userId) {
    if (userId == null) return;
    _socket?.off('driver_location_update_$userId');
    _socket?.off('car_driver_location_update_$userId');
    _socket?.off('user_location_update_$userId');
    _socket?.off('ride_request_$userId');
    _socket?.off('ride_request_accepted_$userId');
    _socket?.off('chat_message_$userId');
  }

  @override
  Future<void> close() {
    _socket?.dispose();
    return super.close();
  }
}
