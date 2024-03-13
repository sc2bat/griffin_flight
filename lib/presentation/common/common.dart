import 'dart:math';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
}

double calculateDistance(
    {required double lat1,
    required double lon1,
    required double lat2,
    required double lon2}) {
  const double earthRadius = 6371.0; // 지구 반지름 (단위: km)

  // 위도 및 경도를 라디안으로 변환
  double lat1Rad = _degreesToRadians(lat1);
  double lon1Rad = _degreesToRadians(lon1);
  double lat2Rad = _degreesToRadians(lat2);
  double lon2Rad = _degreesToRadians(lon2);

  // 위도 및 경도 간의 차이 계산
  double dLat = lat2Rad - lat1Rad;
  double dLon = lon2Rad - lon1Rad;

  // Haversine 공식을 사용하여 거리 계산
  double a = pow(sin(dLat / 2), 2) +
      cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double calculatePrice({
  required double distance,
  required String flightDate,
  required String arrivalTime,
}) {
  double price = _calculateBasePrice(distance);

  int dayOfWeek = _isWeekDay(flightDate);
  if (dayOfWeek == DateTime.saturday || dayOfWeek == DateTime.sunday) {
    price *= 1.1;
  } else if (dayOfWeek == DateTime.tuesday) {
    price *= 0.9;
  }
  if (_isNight(arrivalTime)) {
    price *= 0.95;
  } else if (_isAfternoon(arrivalTime)) {
    price *= 1.05;
  }
  return price.ceilToDouble();
}

double _calculateBasePrice(double distance) {
  if (distance < 500) {
    return 100.0;
  } else if (distance >= 500 && distance < 1000) {
    return 150.0;
  } else {
    return 10.0 * (distance / 100).ceil();
  }
}

bool _isAfternoon(String arrivalTime) {
  int hour = int.parse(arrivalTime.substring(0, 2));
  return hour >= 12 && hour <= 15 ? true : false;
}

bool _isNight(String arrivalTime) {
  int hour = int.parse(arrivalTime.substring(0, 2));
  return (hour >= 21 && hour <= 23) && (hour >= 0 && hour <= 5) ? true : false;
}

int _isWeekDay(String date) {
  String year = date.substring(0, 4);
  String month = date.substring(4, 6);
  String day = date.substring(6);
  DateTime datetime = DateTime.parse('$year-$month-$day');
  return datetime.weekday;
}

String numberWithCommas(double amount, bool isDoller) {
  return '${isDoller ? '\$ ' : '₩ '} ${(isDoller ? amount : amount * 1300).ceil().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
      )}';
}

String calculateDuration(String startTime, String endTime) {
  int startHour = int.parse(startTime.substring(0, 2));
  int startMinute = int.parse(startTime.substring(2));
  int endHour = int.parse(endTime.substring(0, 2));
  int endMinute = int.parse(endTime.substring(2));

  int totalStartMinutes = startHour * 60 + startMinute;
  int totalEndMinutes = endHour * 60 + endMinute;

  if (totalEndMinutes < totalStartMinutes) {
    totalEndMinutes += 24 * 60;
  }

  int diffMinutes = totalEndMinutes - totalStartMinutes;

  int hours = diffMinutes ~/ 60;
  int minutes = diffMinutes % 60;

  String result = '$hours h $minutes m';
  return result;
}
