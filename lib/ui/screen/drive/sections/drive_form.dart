part of '../drive.dart';

class _DriveForm extends StatefulWidget {
  const _DriveForm({super.key});

  @override
  _DriveFormState createState() => _DriveFormState();
}

class _DriveFormState extends State<_DriveForm> {
  final _formKey = GlobalKey<_DriveFormState>();
  // String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // final TextEditingController _loadDateInput = TextEditingController();
  // final TextEditingController _unLoadDateInput = TextEditingController();
  final Map<String,TextEditingController> _formController = {
    "loadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "loadingPlace": TextEditingController(),
    "unLoadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "unLoadingPlace": TextEditingController(),
    "loadingRatio": TextEditingController(),
    "transportationCosts": TextEditingController(),
    "transportationDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "transportationType": TextEditingController(),
    "unitCost": TextEditingController(),
    "extra": TextEditingController(), 
  };
  
  DriveBloc get driveBloc => context.read<DriveBloc>();

  // loadDateInput.text = currentDate;
  // unLoadDateInput.text = currentDate;
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _formController.forEach((_, value) { 
      value.dispose();
    });
    super.dispose();
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
                  controller: _formController['loadingDate'],
                  context: context,
                  labelText: "상차일",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   loadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  controller: _formController['loadingPlace'],
                  decoration: const InputDecoration(
                      labelText: '상차지'
                  ),
                ),
                DatePickerField(
                  controller: _formController['unLoadingDate'],
                  context: context,
                  labelText: "하차일",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   unLoadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  controller: _formController['unLoadingPlace'],
                  decoration: const InputDecoration(
                      labelText: '하차지'
                  ),
                ),
                TextFormField(
                  controller: _formController['loadingRatio'],
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  decoration: const InputDecoration(
                      labelText: '요율'
                  ),
                ),
                TextFormField(
                  controller: _formController['transportationCosts'],
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  decoration: const InputDecoration(
                      labelText: '운반비'
                  ),
                ),
                DatePickerField(
                  controller: _formController['transportationDate'],
                  context: context,
                  labelText: "운행 날짜",
                  onSelected: (selectedDate){
                    // setState(() {
                    //   unLoadDateInput.text = selectedDate;
                    // });
                  },
                ),
                TextFormField(
                  controller: _formController['transportationType'],
                  decoration: const InputDecoration(
                      labelText: '운송 품'
                  ),
                ),
                TextFormField(
                  controller: _formController['unitCost'],
                  decoration: const InputDecoration(
                      labelText: '운송 품목별 단가'
                  ),
                ),
                TextFormField(
                  controller: _formController['extra'],
                  decoration: const InputDecoration(
                      labelText: '비고'
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
                          Map<String, dynamic> jsonMap = {};
                          _formController.forEach((key, controller) => jsonMap[key] = controller.text);
                          
                          driveBloc.add(DriveCreated(DriveDto.fromJson(jsonMap)));
                          AppNavigator.pop();
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