part of '../drive.dart';


class _DriveGrid extends StatefulWidget {
  const _DriveGrid();

  @override
  State<StatefulWidget> createState() => _DriveGridState();
}

class _DriveGridState extends State<_DriveGrid> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();


  DriveBloc get driveBloc => context.read<DriveBloc>();

  @override
  void initState() {
    super.initState();

    driveBloc.add(DriveLoadStarted());
  }


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
      body: DriveStateStatusSelector((status) {
        // ignore: avoid_print
        print('[DriveStateStatusSelector ] ${status}');
        switch(status){
          case DriveStateStatus.loadSuccess:
            return _buildGrid();
          default:
            return Container();
        }
        
      })
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers : [
        SliverPadding(
          padding: EdgeInsets.all(2),
          sliver: DriveCountSelector((driveCount) {
            
            return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  
                  return DriveSelector(index, (drive, _) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('grid item $index ${drive.description} ${drive.startDate} - ${drive.endDate}'),
                    );
                  });
                },
                childCount : driveCount
              )
            );
          })
        )
      ]
    );
  }
  
}

