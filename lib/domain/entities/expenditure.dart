import 'package:freight_ui/domain/dto/expenditure.dart';

class Expenditure {
  final int id;
  final String userId;
  final String paymentDate;
  final int price;
  final String paymentDetail;
  final String extra;
  final String createdAt;
  final String delYn;

  const Expenditure({
    required this.id,
    required this.userId,
    required this.paymentDate,
    required this.price,
    required this.paymentDetail,
    required this.extra,
    required this.createdAt,
    required this.delYn
  });

  factory Expenditure.fromDto(ExpenditureDto expenditureDto){
      return Expenditure(
        id: expenditureDto.id,
        userId: expenditureDto.userId,
        paymentDate: expenditureDto.paymentDate,
        price: expenditureDto.price, 
        paymentDetail: expenditureDto.paymentDetail, 
        extra: expenditureDto.extra, 
        createdAt: expenditureDto.createdAt, 
        delYn: expenditureDto.delYn
      );
  }

}