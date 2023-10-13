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
          DriveStateStatusSelector((status) {

            switch(status) {
              case DriveStateStatus.loading:
                return const Loader();
              case DriveStateStatus.loadSuccess:
                return Column(
                  children: [
                    _buildGrid(),
                    _buildFooter(),
                    _buildPagenation()
                  ],
                );
              default:

                return Container();
            }
          }),
        ]
      ),
    );
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
                    () => _onAddPress()
                  ),
                  SizedBox(width: screenWidth * 0.07),
                  _buildDatePicker(),
                  SizedBox(width: screenWidth * 0.07),
                  PopupMenuButton<String>(
                    position: PopupMenuPosition.under,
                    icon: Image(image: AppImages.excel),
                    onSelected: (String choice) {

                      driveBloc.add(DriveExcelDownload(
                        (ExcelDownloadItems.YearItem == choice) ? DriveExcelDownloadType.YEAR : DriveExcelDownloadType.MONTH
                      ));
                      
                    },
                    itemBuilder: (BuildContext context) {
                      return ExcelDownloadItems.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  // _buildHeaderButton(
                  //   const Image(image: AppImages.excel,),
                  //   (){
                  //     driveBloc.add(const DriveExcelDownload());
                  //   }
                  // )
                ],
              ),
            )
          );
  }

  Widget _buildFooter() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DriveTotalCountSelector((driveCount){
            return Container(
              padding: EdgeInsets.only(left: screenWidth * 0.1),
              width:screenWidth * 0.6 ,
              child: Text("총 ${driveCount}건"),
            );
          }),
          Container(
            width:screenWidth * 0.3 ,
            child: TextButton(
                onPressed: AppNavigator.pop,
                child: Text('처음으로')
            ),
          )
        ],
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
          child:
          DriveDateSelector((selectedDate){
            return Text(
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: screenHeight * 0.03
                ),
                CurrentDate('yyyy-MM',dateTime: selectedDate)
            );
          })

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

                if(rageDate.view == DateRangePickerView.month){
                  AppNavigator.pop();

                  if(rageDate.visibleDateRange.startDate != null){
                    driveBloc.add(DriveSelectedDateChanged(DateTime.parse(rageDate.visibleDateRange.startDate.toString())));
                  }


                }
              },
            );     
          }
        );
  }
  
  void _showErrorSnackBar(BuildContext context){
    Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
    ];
  }

  void _onAddPress(){
    showDialog(
          context: context, 
          builder: (BuildContext context) {
            return DriveForm();
          }
        );
  }

  void _onCardPress(Drive drive, context){
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            // return Container();
            // return DriveDetail(drive: drive);
            return DriveForm(
              drive: drive,
              editable: true,
            );
          }
        );
  }

  _buildPagenation(){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DrivePageSelector((currentPage,totalPage){

        return NumberPaginator(
          numberPages: totalPage + 1,
          initialPage: currentPage -1,
          onPageChange: (int index) {
            print("page ${index}");
            driveBloc.add(DrivePageChanged(index+1));
            // handle page change...
          },
        );

    });

  }

  Widget _buildGrid() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
            height: screenHeight * 0.6,
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
                                      // Text('grid item $index ${drive.extra} ${drive.loadingDate} - ${drive.unloadingDate}'),
                                    );
                                  });
                                },
                                childCount : driveCount
                            )
                        );
                      })
                  )
                ],
            ),
    );
  }
  
}

