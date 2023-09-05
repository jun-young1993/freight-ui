import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';

abstract class DriveRepository {
  Future<List<Drive>> get();
  Future<Drive> update(Drive drive);
  Future<Drive> create(DriveDto dto);
}

class DriveDefaultRepository extends DriveRepository {
  DriveDefaultRepository()



  @override
  Future<Drive> create(DriveDto dto) async {
    return const Drive(
      description: 'test', 
      endDate: '20210102', 
      startDate: '20210101'
    );
  }

  @override
  Future<List<Drive>> get() async {
    return [
      Drive(
      description: 'test', 
      endDate: '20210102', 
      startDate: '20210101'
    ),
    Drive(
      description: 'test2', 
      endDate: '20210102', 
      startDate: '20210101'
    )
    ];
  }

  @override
  Future<Drive> update(Drive drive) async {
        return const Drive(
      description: 'test', 
      endDate: '20210102', 
      startDate: '20210101'
    );
  }}