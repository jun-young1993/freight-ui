part of '../drive.dart';

class DriveForm extends StatefulWidget {
  final Drive? drive;
  final bool editable;

  const DriveForm({super.key, this.drive, this.editable = false});

  @override
  State<StatefulWidget> createState() => _DriveFormState();

}

class _DriveFormState extends State<DriveForm> {
  

  DriveBloc get driveBloc => context.read<DriveBloc>();
  DriveFormBloc get formBloc => context.read<DriveFormBloc>();

  Drive? get drive => widget.drive;
  bool get editable => widget.editable;
  late bool edit = editable;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


        formBloc.setValues(drive);



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
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //         backgroundColor: AppColors.blue,
                //         content: Text('성공적으로 등록되었습니다.'))
                // );
                AppNavigator.pop();
                final Map<String, dynamic> jsonData = json.decode(state.successResponse as String);
                final DriveDto dto = DriveDto.fromJson(jsonData);
                print(jsonData);
                if(drive == null){
                  driveBloc.add(DriveCreated(dto));
                }else{
                  final int driveId = drive!.id;
                  driveBloc.add(DriveUpdated(driveId,dto));
                }



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
                formBloc: formBloc,
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
                              formBloc.unloadingDate,
                              label: '상차일',
                              width: screenWidth * 0.4
                            ),
                            _buildDateTimeFiled(
                              formBloc.unloadingDate,
                              label: '하차일',
                              width: screenWidth * 0.4
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTextField(
                              formBloc.loadingPlace,
                              label: '상차지',
                              width: screenWidth * 0.4
                            ),
                            _buildTextField(
                              formBloc.unloadingPlace,
                              label: '하차지',
                              width: screenWidth * 0.4
                            )
                          ],
                        ),
                        _buildTextField(
                          formBloc.loadingRatio,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '요율'
                        ),
                        _buildTextField(
                          formBloc.transportationType,
                          label: '운송품목'
                        ),
                        _buildTextField(
                          formBloc.unitCost,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '품목단가'
                        ),
                        _buildTextField(
                          formBloc.transportationCosts,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          label: '운반비'
                        ),
                      (drive != null
                      ? _buildEditFooter()
                      :_buildFooter())
                    ],
                  )
                ),
              )
            ),
          );
  }

  Widget _buildEditFooter() {
    return (
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: (){
                  if(edit == true){
                    setState(() {
                      edit = false;
                    });
                  }else{
                    formBloc.submit();
                  }

                },
                child: Text(edit == true ? '수정하기' : '적용하기')
            ),
             TextButton(
                onPressed: (){
                  if(drive != null){
                    final int driveId = drive!.id;
                    _showDeleteConfirmationDialog(driveId);
                  }
                },
                child: Text('삭제하기')
            ),
             TextButton(
                onPressed: (){
                  if(edit == true){
                    AppNavigator.pop();
                  }else{
                    setState(() {
                      edit = true;
                    });
                  }
                },
                child: Text(edit == true ? '뒤로가기' : '수정취소')
            )
          ],
        )
    );
  }


  Widget _buildFooter(){

    return (
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
        readOnly: edit,
        isEnabled: !edit,
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
        isEnabled: !edit,
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
  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('정말 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 대화 상자 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                driveBloc.add(DriveDeleted(id));

              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
