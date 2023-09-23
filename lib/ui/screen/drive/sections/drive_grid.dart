part of '../drive.dart';


class _DriveGrid extends StatefulWidget {
  const _DriveGrid();

  @override
  State<StatefulWidget> createState() => _DriveGridState();
}

class _DriveGridState extends State<_DriveGrid> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();
  String? _headerText = '';
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
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [

          _buildHeader(),
          _buildGrid()
        ]
      ),
    );
    // return NestedScrollView(
    //   key: _scrollKey,
    //   headerSliverBuilder: (_, __) => [
    //         MainSliverAppBar(
    //           // height: 200.0,
    //           // Text(AppRouteMap.getName(Routes.drive)),
    //           title : AppRouteMap.getName(Routes.drive),
    //           context: context,
    //           tailActions: _buildHeaderActions(context)
    //         ),
    //   ],
    //   body: DriveStateStatusSelector((status) {
    //     // ignore: avoid_print
        
    //     print('[DriveStateStatusSelector ] ${status}');
    //     switch(status){
    //       case DriveStateStatus.loadSuccess:
    //         return _buildGrid(context);
    //       case DriveStateStatus.loadFailure:
    //         _showErrorSnackBar(context);
    //         return Container();
    //       default:
    //         return Container();
    //     }
        
    //   })
    // );
  }

  Widget _buildHeader(){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeaderButton(
                    const Icon(Icons.add),
                    (){}
                  ),
                  SizedBox(width: screenWidth * 0.07),
                  _buildDatePicker(),
                  SizedBox(width: screenWidth * 0.07),
                  _buildHeaderButton(
                    const Image(image: AppImages.excel,),
                    (){}
                  )
                ],
              ),
            )
          );
  }


  Widget _buildHeaderButton(Widget icon, VoidCallback callback){
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenHeight * 0.05,
      height: screenHeight * 0.05,
      child: IconButton(
        icon: icon,
        onPressed: callback,
      ),
    );
  }

  Widget _buildDatePicker(){
   double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all()
      ),
      child: TextButton(
          onPressed: () {
            _showDatePicker();
          },
          child: Text(
            style: TextStyle(
              color: AppColors.black,
              fontSize: screenHeight * 0.03
            ),
            CurrentDate('yyyy-MM')
          )
      ),
    );
    // SfDateRangePicker();
  }


  void _showDatePicker(){
      showDialog(
          context: context, 
          builder: (BuildContext context) {
            
            return SfDateRangePicker(
              
              backgroundColor: AppColors.white,
              view: DateRangePickerView.year,
              showNavigationArrow: true,
              onViewChanged: (DateRangePickerViewChangedArgs rageDate) {
                // print(rageDate.view);
                print(rageDate.visibleDateRange);
                if(rageDate.view == DateRangePickerView.month){
                  AppNavigator.pop();
                }
              },

              // onSubmit: () => {
              //   // return Navigator.pop(context);
              // },
            );     
          }
        );
  }
  
  void _showErrorSnackBar(BuildContext context){
    Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
            backgroundColor: AppColors.red,
            content: const Text('Awesome SnackBar!'),
            duration: const Duration(milliseconds: 1500),
            width: 280.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
      );
    });
  
  }

  List<Widget> _buildHeaderActions() {
    return [
      _buildDatePicker()
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

  Widget _buildGrid() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.7,
      width: screenWidth * 0.97,
      child: CustomScrollView(
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
                        // color: Colors.teal[100 * (index % 9)],
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
      ),
    );

  }
  
}

