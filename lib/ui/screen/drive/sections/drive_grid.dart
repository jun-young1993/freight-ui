part of '../drive.dart';


class _DriveGrid extends StatefulWidget {
  const _DriveGrid();

  @override
  State<StatefulWidget> createState() => _DriveGridState();
}

class _DriveGridState extends State<_DriveGrid> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) => [
            MainSliverAppBar(
              title : AppRouteMap.getName(Routes.drive),
              context: context,
            ),
      ],
      body: Container(
        child: Text('drive'),
      )
    );
  }
  
}

