import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/domain/entities/drive.dart';

class DriveCard extends StatelessWidget {
  final Drive drive;
  final void Function()? onPress;
  const DriveCard({super.key,
    required this.drive, this.onPress
  });


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        const Color color = AppColors.lightBlue;

        return Container(
              decoration: BoxDecoration(
              color:  color,
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(child: Text("${drive.loadingDate} - ${drive.unLoadingDate}"),),
            Center(child: Text("${drive.loadingPlace} - ${drive.unLoadingPlace}"),),
            // Center(child: Text(drive.extra),),
            // Center(child: Text(drive.transportationCosts.toString()),),
          ],
        ),
      ),
    );
  }

}