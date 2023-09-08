part of '../drive.dart';

class _DriveForm extends StatefulWidget {
  const _DriveForm({super.key});

  @override
  _DriveFormState createState() => _DriveFormState();
}

class _DriveFormState extends State<_DriveForm> {
  final _formKey = GlobalKey<_DriveFormState>();

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
                TextFormField(
                  
                )
              ],
            )
          )
        ],
      )
    );
  }
}