import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/domain/entities/drive.dart';

class DriveCard extends StatelessWidget {
  final Drive drive;
  final void Function()? onPress;
  const DriveCard({
    super.key,
    required this.drive, 
    this.onPress
  });


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        const Color color = AppColors.whiteGrey;

        return Container(
              decoration: BoxDecoration(
              color:  color,
              border: Border.all(),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _DriveCard(drive: drive)
                  ]
                )
              ),
            ),
        );
      }
    );
  }}


class _DriveCard extends StatelessWidget {
  final Drive drive;

  const _DriveCard({
    required this.drive
  });

  @override
  Widget build(BuildContext context) {

    return _buildDriveCard(context);
  }
  Widget _buildDriveCard(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.015,
            left: 10,
            right: 10,
          ),
          // padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child:_buildDriveRow()
      ),
    );
  }

  Widget _buildDriveRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildDateText(drive.loadingDate),
            const Text('/', textAlign: TextAlign.center,),
            _buildDateText(drive.unloadingDate),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(drive.loadingPlace),
            const Text('/', textAlign: TextAlign.center,),
            Text(drive.unloadingPlace),
          ],
        ),
        _buildDateText(drive.transportationDate),
        Text(drive.transportationType),
        Text(drive.unitCost.toString())
      ],
    );
  }

  Widget _buildDateText(DateTime driveProperty){
   return Text("${driveProperty.month.toString()}월 ${driveProperty.day.toString()}일");
  }
}