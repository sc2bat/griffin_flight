class PaymentDataDTO {
  List<PaymentData>? result;

  PaymentDataDTO({this.result});

  PaymentDataDTO.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <PaymentData>[];
      json['result'].forEach((v) {
        result!.add(PaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentData {
  int? bookId;
  int? userId;
  int? flightId;
  String? classSeat;
  int? status;
  int? payStatus;
  double? payAmount;
  String? createdAt;
  String? userName;
  String? flightDate;
  String? departureTime;
  String? departureCode;
  String? departureName;
  String? arrivalCode;
  String? arrivalName;
  String? firstName;
  String? lastName;

  PaymentData(
      {this.bookId,
        this.userId,
        this.flightId,
        this.classSeat,
        this.status,
        this.payStatus,
        this.payAmount,
        this.createdAt,
        this.userName,
        this.flightDate,
        this.departureTime,
        this.departureCode,
        this.departureName,
        this.arrivalCode,
        this.arrivalName,
        this.firstName,
        this.lastName});

  PaymentData.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    userId = json['user_id'];
    flightId = json['flight_id'];
    classSeat = json['class_seat'];
    status = json['status'];
    payStatus = json['pay_status'];
    payAmount = json['pay_amount'];
    createdAt = json['created_at'];
    userName = json['user_name'];
    flightDate = json['flight_date'];
    departureTime = json['departure_time'];
    departureCode = json['departure_code'];
    departureName = json['departure_name'];
    arrivalCode = json['arrival_code'];
    arrivalName = json['arrival_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = bookId;
    data['user_id'] = userId;
    data['flight_id'] = flightId;
    data['class_seat'] = classSeat;
    data['status'] = status;
    data['pay_status'] = payStatus;
    data['pay_amount'] = payAmount;
    data['created_at'] = createdAt;
    data['user_name'] = userName;
    data['flight_date'] = flightDate;
    data['departure_time'] = departureTime;
    data['departure_code'] = departureCode;
    data['departure_name'] = departureName;
    data['arrival_code'] = arrivalCode;
    data['arrival_name'] = arrivalName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}