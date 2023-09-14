part of '../drive.dart';


class _DriveGrid extends StatefulWidget {
  const _DriveGrid();

  @override
  State<StatefulWidget> createState() => _DriveGridState();
}

class _DriveGridState extends State<_DriveGrid> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  PickerDateRange pickerDateRange = PickerDateRange(
    SearchDate(SearchDateType.start),
    SearchDate(SearchDateType.end)
  );


  DriveBloc get driveBloc => context.read<DriveBloc>();

  @override
  void initState() {
    super.initState();

    driveBloc.add(const DriveLoadStarted());
  }



  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) => [
            MainSliverAppBar(
              // height: 200.0,
              // Text(AppRouteMap.getName(Routes.drive)),
              title : AppRouteMap.getName(Routes.drive),
              context: context,
              tailActions: _buildHeaderActions(context)
            ),
      ],
      body: DriveStateStatusSelector((status) {
        // ignore: avoid_print
        print('[DriveStateStatusSelector ] ${status}');
        switch(status){
          case DriveStateStatus.loadSuccess:
            return _buildGrid(context);
          default:
            return Container();
        }
        
      })
    );
  }

  Widget _buildDatePicker(BuildContext context){
    return  IconButton(
      padding: const EdgeInsets.symmetric(horizontal: MainAppBarConfig.mainAppBarPadding),
      icon: Icon(Icons.date_range,
      color: Theme.of(context).textTheme.bodyLarge!.color),
      onPressed: (){
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            
            return SfDateRangePicker(
              backgroundColor: AppColors.white,
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              onCancel: () => {
                Navigator.pop(context)
              },
              onSelectionChanged: (DateRangePickerSelectionChangedArgs rangeDate) {
                
                //  rangeDate - 
                // PickerDateRange#40037(startDate: 2023-09-14 00:00:00.000, endDate: null)
                // PickerDateRange#9a9aa(startDate: 2023-09-05 00:00:00.000, endDate: 2023-09-14 00:00:00.000)
                // if(rangeDate.startDate != null){

                // }
                if(rangeDate.value.endDate != null){
                  pickerDateRange = PickerDateRange(
                    SearchDate(
                      SearchDateType.start, 
                      dateTime: rangeDate.value.startDate
                    ), 
                    SearchDate(
                      SearchDateType.end, 
                      dateTime: rangeDate.value.endDate
                    )
                  );
                }
                

                
              },
              onSubmit: (p0)  {
                Navigator.pop(context);
              },
              // onSubmit: () => {
              //   // return Navigator.pop(context);
              // },
            );     
          }
        );
      },
    );
    // SfDateRangePicker();
  }
  

  List<Widget> _buildHeaderActions(BuildContext context) {
    return [
      _buildDatePicker(context)
                // IconButton(
                //   padding: EdgeInsets.symmetric(horizontal: MainAppBarConfig.mainAppBarPadding),
                //   icon: Icon(Icons.date_range,
                //       color: Theme.of(context).textTheme.bodyLarge!.color),
                //   onPressed: (){

                //   },
                // ),
    ];
  }

  void _onCardPress(Drive drive, context){
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            
            return DriveDetail(drive: drive);
          }
        );
    // print("onUserPress userId ${user.id}");
    // userBloc.add(UserSelectChanged(id: user.id));
    // print("onUserPress User ${user}");
    // AppNavigator.push(Routes.userInfo, user);
  }

  Widget _buildGrid(BuildContext context) {
    return CustomScrollView(

      slivers : [
        SliverPadding(
          padding: const EdgeInsets.all(2),
          sliver: DriveCountSelector((driveCount) {
            return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      child: DriveCard(
                        drive: drive,
                        onPress: () => _onCardPress(drive,context),
                      )
                      // Text('grid item $index ${drive.extra} ${drive.loadingDate} - ${drive.unLoadingDate}'),
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

