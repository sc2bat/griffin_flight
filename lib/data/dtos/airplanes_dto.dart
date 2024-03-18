class AirplanesDTO {
  final int? airplaneId;
  final int? firstClassSeat;
  final int? businessClassSeat;
  final int? economyClassSeat;
  final DateTime? createdAt;
  final int? isDeleted;

  AirplanesDTO({
    this.airplaneId,
    this.firstClassSeat,
    this.businessClassSeat,
    this.economyClassSeat,
    this.createdAt,
    this.isDeleted,
  });

  factory AirplanesDTO.fromJson(Map<String, dynamic> json) {
    return AirplanesDTO(
      airplaneId: json['airplane_id'] as int?,
      firstClassSeat: json['first_class_seat'] as int?,
      businessClassSeat: json['business_class_seat'] as int?,
      economyClassSeat: json['economy_class_seat'] as int?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      isDeleted: json['is_deleted'] as int?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'airplane_id': airplaneId,
      'first_class_seat': firstClassSeat,
      'business_class_seat': businessClassSeat,
      'economy_class_seat': economyClassSeat,
      'created_at': createdAt?.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }
}
