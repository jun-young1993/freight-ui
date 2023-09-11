part of '../drive.dart';

class _DriveForm extends StatefulWidget {
  const _DriveForm({super.key});

  @override
  _DriveFormState createState() => _DriveFormState();
}

class _DriveFormState extends State<_DriveForm> {
  final _formKey = GlobalKey<_DriveFormState>();
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController loadDateInput = TextEditingController();
  TextEditingController unLoadDateInput = TextEditingController();

  
  DriveBloc get driveBloc => context.read<DriveBloc>();

  // loadDateInput.text = currentDate;
  // unLoadDateInput.text = currentDate;
  @override
  void initState(){
    loadDateInput.text = currentDate;
    unLoadDateInput.text = currentDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context){



    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DatePickerField(
                  controller: loadDateInput,
                  context: context,
                  labelText: "상차일",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   loadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '상차지'
                  ),
                ),
                DatePickerField(
                  controller: unLoadDateInput,
                  context: context,
                  labelText: "하차일",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   unLoadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '하차지'
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  decoration: const InputDecoration(
                      labelText: '요율'
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  decoration: const InputDecoration(
                      labelText: '운반비'
                  ),
                ),
                DatePickerField(
                  controller: unLoadDateInput,
                  context: context,
                  labelText: "운행 날짜",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   unLoadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '운송 품'
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '운송 품목별 단가'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IconButton(
                          onPressed: (){
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        // if (_formKey.currentState!.validate()) {
                        //   // Process data.
                        // }
                            // DriveDto driveDto = new DriveDto(
                                // loadingDate: loadDateInput.text, 
                                // loadingPlace: loadDateInput.text, 
                                // unLoadingDate: loadDateInput.text, 
                                // unLoadingPlace: loadDateInput.text, 
                                // loadingRatio: 100, 
                                // transportationDate: loadDateInput.text, 
                                // transportationType: loadDateInput.text, 
                                // unitCost: 100, 
                                // extra: loadDateInput.text
                            //   );
                            
                          driveBloc.add(
                            const DriveCreated(
                              DriveDto(
                                loadingDate: '20210808', 
                                loadingPlace: '20210808', 
                                unLoadingDate: '20210808', 
                                unLoadingPlace: '20210808', 
                                loadingRatio: 100, 
                                transportationDate: '20210808', 
                                transportationType: '20210808', 
                                unitCost: 100, 
                                extra: '20210808'
                              )
                            )
                          );
                        },
                        icon: const Icon(Icons.add)
                      ),
                      const IconButton(
                          onPressed: AppNavigator.pop,
                          icon: Icon(Icons.cancel)
                      )
                    ],
                  )
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}