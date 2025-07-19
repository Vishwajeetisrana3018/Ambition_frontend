import 'package:ambition_delivery/domain/entities/ambition_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Consts {
  // static const baseUrl ='https://ambitionbackend-258e6c7522d2.herokuapp.com/api/';
  // static const baseUrl = 'http://192.168.1.106:5000/api/';
    static const baseUrl ='https://demo.innoplixit.com/api/';
  
  static List<AmbitionService> ambitionServices = [
    AmbitionService(
      title: 'Events',
      image: "assets/car.png",
      icon: FontAwesomeIcons.calendarDays,
      isFullWidth: false,
      isEvent: true,
    ),
    AmbitionService(
      title: 'House Move',
      image: "assets/car.png",
      icon: FontAwesomeIcons.house,
      isFullWidth: false,
      isEvent: false,
    ),
    AmbitionService(
      title: 'Waste Disposal',
      image: "assets/car.png",
      icon: FontAwesomeIcons.trash,
      isFullWidth: false,
      isEvent: true,
    ),
    AmbitionService(
      title: 'Storage Move',
      image: "assets/car.png",
      icon: FontAwesomeIcons.box,
      isFullWidth: true,
      isEvent: false,
    ),
    AmbitionService(
      title: 'Shopping',
      image: "assets/car.png",
      icon: FontAwesomeIcons.cartShopping,
      isFullWidth: false,
      isEvent: true,
    ),
    AmbitionService(
      title: 'Transport Items',
      image: "assets/car.png",
      icon: FontAwesomeIcons.boxOpen,
      isFullWidth: false,
      isEvent: false,
    ),
    AmbitionService(
      title: 'Office Relocation',
      image: "assets/car.png",
      icon: FontAwesomeIcons.building,
      isFullWidth: false,
      isEvent: false,
    ),
    AmbitionService(
      title: 'Other Services',
      image: "assets/car.png",
      icon: FontAwesomeIcons.ellipsis,
      isFullWidth: true,
      isEvent: false,
    ),
  ];

  static Map<String, IconData> vehicleTypeIcons = {
    "van": FontAwesomeIcons.truck,
    "environment van": FontAwesomeIcons.truckMedical,
    "car": FontAwesomeIcons.car,
    "refrigeration van": FontAwesomeIcons.truckFront,
    "luton van": FontAwesomeIcons.truckMoving,
  };

  static Icon getVehicleIcon(String? type,
      {double size = 24.0, Color color = Colors.black}) {
    // Convert the type to lowercase and search the map, defaulting to FontAwesomeIcons.truck
    IconData iconData =
        vehicleTypeIcons[type?.toLowerCase() ?? ""] ?? FontAwesomeIcons.truck;
    return Icon(iconData, size: size, color: color);
  }

  static bool isEventRequest(String title) {
    return ambitionServices
        .where((service) => service.title == title)
        .first
        .isEvent;
  }
}
