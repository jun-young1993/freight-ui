class ExpenditureDto {
  final int id;
  final String userId;
  final String paymentDate;
  final int price;
  final String paymentDetail;
  final String extra;
  final String createdAt;
  final String delYn;
  final int totalCount;
  final int totalMount;

  const ExpenditureDto({
    required this.id,
    required this.userId,
    required this.paymentDate,
    required this.price,
    required this.paymentDetail,
    required this.extra,
    required this.createdAt,
    required this.delYn,
    required this.totalCount,
    required this.totalMount,
  });

  factory ExpenditureDto.fromJson(Map<String, dynamic> json) {
  return ExpenditureDto(
    id: json['id'] as int? ?? 0,
    userId: json['userId'] as String? ?? '',
    paymentDate: json['paymentDate'] as String? ?? '',
    price: json['price'] as int? ?? 0,
    paymentDetail: json['paymentDetail'] as String? ?? '',
    extra: json['extra'] as String? ?? '',
    createdAt: json['createdAt'] as String? ?? '',
    delYn: json['delYn'] as String? ?? '',
    totalCount: json['totalCount'] as int? ?? 0,
    totalMount: json['totalMount'] as int? ?? 0,
  );
  }

}