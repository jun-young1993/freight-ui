// part of '../drive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/utills/date.dart';

class DriveForm extends StatefulWidget {
  final Drive? drive;
  const DriveForm({
    this.drive
  });

  @override
  _DriveFormState createState() => _DriveFormState();
}

class _DriveFormState extends State<DriveForm> {
  final _formKey = GlobalKey<_DriveFormState>();
  Drive? get drive => widget.drive;
  // String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // final TextEditingController _loadDateInput = TextEditingController();
  // final TextEditingController _unLoadDateInput = TextEditingController();
  final Map<String,TextEditingController> _formController = {
    "loadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "loadingPlace": TextEditingController(),
    "unloadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "unloadingPlace": TextEditingController(),
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

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              const ContainerTitle(title: '운행일지 신규등록'),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Text("TODAY: ${CurrentDate("yyyy-MM-dd")}"),
              ),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFormField("상차날짜:"),
                    _buildFormField("하차날짜:"),
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFormField("*상차지:"),
                    _buildFormField("*하차지:")
                  ]
                ),
              ),
              _buildBorderText('운송 품목:'),
              _buildBorderText('품목 단가:'),
              _buildBorderText('운반비:'),
            ]
          ),
        )
      )
    );
  }


  Widget _buildFormField(String title, {TextEditingController? textController}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth= MediaQuery.of(context).size.width;
    return Container(
      // height: screenHeight * 0.3,
      // width: screenWidth * 0.5,
      child: 
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     // Text(title),
          Expanded(
            child : TextFormField(
              decoration: InputDecoration(label: Text(title)),
              controller: textController,
            )
          )
        // ],
      // )
    );
  }
  
  Widget _buildBorderText( String title, {TextEditingController? textController }) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Container(
        padding: EdgeInsets.all(screenHeight * 0.05),
        // height: screenHeight * 0.05,
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
        ),
        child: _buildFormField(title, textController: textController)
      ),
    );
  }
}

// class _DriveForm extends StatefulWidget {
//   const _DriveForm({super.key});

//   @override
//   _DriveFormState createState() => _DriveFormState();
// }

// class _DriveFormState extends State<_DriveForm> {
//   final _formKey = GlobalKey<_DriveFormState>();
//   // String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   // final TextEditingController _loadDateInput = TextEditingController();
//   // final TextEditingController _unLoadDateInput = TextEditingController();
//   final Map<String,TextEditingController> _formController = {
//     "loadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
//     "loadingPlace": TextEditingController(),
//     "unloadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
//     "unloadingPlace": TextEditingController(),
//     "loadingRatio": TextEditingController(),
//     "transportationCosts": TextEditingController(),
//     "transportationDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
//     "transportationType": TextEditingController(),
//     "unitCost": TextEditingController(),
//     "extra": TextEditingController(), 
//   };
  
//   DriveBloc get driveBloc => context.read<DriveBloc>();

//   // loadDateInput.text = currentDate;
//   // unLoadDateInput.text = currentDate;
//   @override
//   void initState(){
//     super.initState();
//   }

//   @override
//   void dispose(){
//     _formController.forEach((_, value) { 
//       value.dispose();
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context){



//     return AlertDialog(
//       content: Stack(
//         children: <Widget>[
//           Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 DatePickerField(
//                   controller: _formController['loadingDate'],
//                   context: context,
//                   labelText: "상차일",
//                   onSelected: (selectedDate){
//                     // setState(() {
//                     //   loadDateInput.text = selectedDate;
//                     // });
//                   },
//                 ),
//                 TextFormField(
//                   controller: _formController['loadingPlace'],
//                   decoration: const InputDecoration(
//                       labelText: '상차지'
//                   ),
//                 ),
//                 DatePickerField(
//                   controller: _formController['unloadingDate'],
//                   context: context,
//                   labelText: "하차일",
//                   onSelected: (selectedDate){
//                     // setState(() {
//                     //   unLoadDateInput.text = selectedDate;
//                     // });
//                   },
//                 ),
//                 TextFormField(
//                   controller: _formController['unloadingPlace'],
//                   decoration: const InputDecoration(
//                       labelText: '하차지'
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _formController['loadingRatio'],
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [],
//                   decoration: const InputDecoration(
//                       labelText: '요율'
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _formController['transportationCosts'],
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [],
//                   decoration: const InputDecoration(
//                       labelText: '운반비'
//                   ),
//                 ),
//                 DatePickerField(
//                   controller: _formController['transportationDate'],
//                   context: context,
//                   labelText: "운행 날짜",
//                   onSelected: (selectedDate){
//                     // setState(() {
//                     //   unLoadDateInput.text = selectedDate;
//                     // });
//                   },
//                 ),
//                 TextFormField(
//                   controller: _formController['transportationType'],
//                   decoration: const InputDecoration(
//                       labelText: '운송 품'
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _formController['unitCost'],
//                   decoration: const InputDecoration(
//                       labelText: '운송 품목별 단가'
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _formController['extra'],
//                   decoration: const InputDecoration(
//                       labelText: '비고'
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       IconButton(
//                           onPressed: (){
//                         // Validate will return true if the form is valid, or false if
//                         // the form is invalid.
//                         // if (_formKey.currentState!.validate()) {
//                         //   // Process data.
//                         // }
//                           Map<String, dynamic> jsonMap = {};
//                           _formController.forEach((key, controller) => jsonMap[key] = controller.text);
                          
//                           driveBloc.add(DriveCreated(DriveDto.fromJson(jsonMap)));
//                           AppNavigator.pop();
//                         },
//                         icon: const Icon(Icons.add)
//                       ),
//                       const IconButton(
//                           onPressed: AppNavigator.pop,
//                           icon: Icon(Icons.cancel)
//                       )
//                     ],
//                   )
//                 ),
//               ],
//             ),
//           )
//         ],
//       )
//     );
//   }
// }