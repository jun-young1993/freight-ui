import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';

class DriveDetail extends StatelessWidget {
  final Drive drive;

  DriveDetail({super.key, required this.drive});


  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
      return Container(
        color: AppColors.white,
        child: NestedScrollView(
          key: _scrollKey,
          headerSliverBuilder: (_, __) => [
              MainSliverAppBar(
                // color: AppColors.white,
                // height: 200.0,
                // Text(AppRouteMap.getName(Routes.drive)),
                title : "${AppRouteMap.getName(Routes.drive)} 상세보기",
                context: context,
              ),
          ],
          body: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('상차날짜:'),
                      Text('상차날짜:')
                    ],
                  ),
                  Row(
                    children: [
                      Text('하차날짜')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
      
        
  }

}