// part of '../drive.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/states/drive/drive_form_bloc.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/ui/widgets/loader.dart';
import 'package:freight_ui/utills/date.dart';

class DriveForm extends StatelessWidget {
  final Drive? drive;
  final bool editable;
  const DriveForm({
    super.key, 
    this.drive,
    this.editable = false
  });
  
  @override
  Widget build(BuildContext context) {
        final _formBloc = BlocProvider.of<DriveFormBloc>(context);
        _formBloc.setValues(drive);
        
        

        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;


        return Scaffold(
            body: FormBlocListener<DriveFormBloc, String, String>(
              onSubmitting: (context, state) {
                if(state.isValid()){
                  LoadingDialog.show(context);
                }
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                AppNavigator.pop();
              
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.red,
                      content: Text(state.failureResponse!))
                    );
              },
              child: ScrollableFormBlocManager(
                formBloc: _formBloc,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget>[
                          const ContainerTitle(title: '운행일지 신규등록'),
                          Container(
                            padding: EdgeInsets.all(screenHeight * 0.02),
                            child: Text("TODAY: ${CurrentDate("yyyy-MM-dd")}"),
                          ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDateTimeFiled(
                              _formBloc.unLoadingDate,
                              label: '상차일',
                              width: screenWidth * 0.4
                            ),
                            _buildDateTimeFiled(
                              _formBloc.unLoadingDate,
                              label: '하차일',
                              width: screenWidth * 0.4
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTextField(
                              _formBloc.loadingPlace,
                              label: '상차지',
                              width: screenWidth * 0.4
                            ),
                            _buildTextField(
                              _formBloc.unLoadingPlace,
                              label: '하차지',
                              width: screenWidth * 0.4
                            )
                          ],
                        ),
                        _buildTextField(
                          _formBloc.loadingRatio,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '요율'
                        ),
                        _buildTextField(
                          _formBloc.transportationType,
                          label: '운송품목'
                        ),
                        _buildTextField(
                          _formBloc.unitCost,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '품목단가'
                        ),
                        _buildTextField(
                          _formBloc.transportationCosts,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '운반비'
                        ),
                        _buildFooter(_formBloc)
                        
                    ],
                  )
                ),
              )
            ),
          );
  }

  Widget _buildFooter(DriveFormBloc formBloc){
    
    return (
        editable
            ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: formBloc.submit,
                child: const Text('수정하기')
            ),
            const TextButton(
                onPressed: AppNavigator.pop,
                child: Text('삭제')
            ),
            const TextButton(
                onPressed: AppNavigator.pop,
                child: Text('목록으로')
            )
          ],
        )
            :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: formBloc.submit,
                child: const Text('등록하기')
            ),
            const TextButton(
                onPressed: AppNavigator.pop,
                child: Text('뒤로가기')
            )
          ],
        )
    );
  }

  Widget _buildTextField(TextFieldBloc<dynamic> textFieldBloc,  {double? width, String? label, TextInputType? keyboardType, List<TextInputFormatter>? inputFormatters}){
    return SizedBox(
      width: width,
      child: TextFieldBlocBuilder(
        readOnly: editable,
        isEnabled: !editable,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        textFieldBloc: textFieldBloc,
        decoration: InputDecoration(
          labelText: label
        )
      ),
    );
  }

  Widget _buildDateTimeFiled(InputFieldBloc<DateTime?, dynamic> dateTimeFieldBloc, {double? width, String? label}){
    return SizedBox(
      width: width,
      child: DateTimeFieldBlocBuilder(
        showClearIcon: false,
        isEnabled: !editable,
        dateTimeFieldBloc: dateTimeFieldBloc,
        format: DateFormat(AppConstant.publicDateFormat),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        decoration: InputDecoration(
          labelText: label,
          // prefixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
  
}

// class _DriveFormState extends State<DriveForm> {
//   final _formKey = GlobalKey<_DriveFormState>();
//   Drive? get drive => widget.drive;
//   // String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   // final TextEditingController _loadDateInput = TextEditingController();
//   // final TextEditingController _unLoadDateInput = TextEditingController();
//   final Map<String,TextEditingController> _formController = {
//     "loadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
//     "loadingPlace": TextEditingController(),
//     "unLoadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
//     "unLoadingPlace": TextEditingController(),
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

//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           child: Column(
//             children: [
//               const ContainerTitle(title: '운행일지 신규등록'),
//               Container(
//                 padding: EdgeInsets.all(screenHeight * 0.02),
//                 child: Text("TODAY: ${CurrentDate("yyyy-MM-dd")}"),
//               ),
//               Container(
//                 padding: EdgeInsets.all(screenHeight * 0.02),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildFormField("상차날짜:"),
//                     _buildFormField("하차날짜:"),
//                   ]
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(screenHeight * 0.02),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildFormField("*상차지:"),
//                     _buildFormField("*하차지:")
//                   ]
//                 ),
//               ),
//               _buildBorderText('운송 품목:'),
//               _buildBorderText('품목 단가:'),
//               _buildBorderText('운반비:'),
//             ]
//           ),
//         )
//       )
//     );
//   }


//   Widget _buildFormField(String title, {TextEditingController? textController}) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth= MediaQuery.of(context).size.width;
//     return Container(
//       // height: screenHeight * 0.3,
//       // width: screenWidth * 0.5,
//       child: 
//       // Row(
//       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //   children: [
//       //     // Text(title),
//           Expanded(
//             child : TextFormField(
//               decoration: InputDecoration(label: Text(title)),
//               controller: textController,
//             )
//           )
//         // ],
//       // )
//     );
//   }
  
//   Widget _buildBorderText( String title, {TextEditingController? textController }) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: EdgeInsets.all(screenHeight * 0.01),
//       child: Container(
//         padding: EdgeInsets.all(screenHeight * 0.05),
//         // height: screenHeight * 0.05,
//         decoration: BoxDecoration(
//           border: Border.all(width: 2.0),
//         ),
//         child: _buildFormField(title, textController: textController)
//       ),
//     );
//   }
// }