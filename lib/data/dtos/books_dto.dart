class BooksDTO {
  int? bookId;
  String? classSeat;
  int? status;
  int? payStatus;
  double? payAmount;
  String? createdAt;
  int? isDeleted;
  int? userId;
  int? flightId;

  BooksDTO(
      {this.bookId,
        this.classSeat,
        this.status,
        this.payStatus,
        this.payAmount,
        this.createdAt,
        this.isDeleted,
        this.userId,
        this.flightId});

  BooksDTO.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    classSeat = json['class_seat'];
    status = json['status'];
    payStatus = json['pay_status'];
    payAmount = json['pay_amount'];
    createdAt = json['created_at'];
    isDeleted = json['is_deleted'];
    userId = json['user_id'];
    flightId = json['flight_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = bookId;
    data['class_seat'] = classSeat;
    data['status'] = status;
    data['pay_status'] = payStatus;
    data['pay_amount'] = payAmount;
    data['created_at'] = createdAt;
    data['is_deleted'] = isDeleted;
    data['user_id'] = userId;
    data['flight_id'] = flightId;
    return data;
  }
}