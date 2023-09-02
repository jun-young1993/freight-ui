import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onSelectMenu(Routes routeName){
    AppNavigator.push(routeName);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body : Center(
            child: Column(
              children: <Widget>[
                TextButton(
                    onPressed: () => _onSelectMenu(Routes.drive),
                    child: const Text('운행일지')
                ),
                TextButton(
                    onPressed: () => _onSelectMenu(Routes.expenditure),
                    child: const Text('지출내역')
                ),
                TextButton(
                    onPressed: () => _onSelectMenu(Routes.oil),
                    child: const Text('주유 내역')
                ),
                TextButton(
                    onPressed: () => _onSelectMenu(Routes.maintenance),
                    child: const Text('정비 내역')
                ),
              ],
            )
        )
    );
  }
}