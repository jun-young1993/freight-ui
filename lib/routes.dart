import 'package:flutter/cupertino.dart';
import 'package:freight_ui/ui/screen/expenditure/expenditure.dart';
import 'package:freight_ui/ui/screen/home/home.dart';
// import 'package:freight_ui/ui/screen/user/sections/user_sign_up.dart';
import 'package:freight_ui/ui/screen/user/user.dart';
import 'core/fade_page_route.dart';
import 'ui/screen/drive/drive.dart';
import 'ui/screen/maintenance/maintenance.dart';
import 'ui/screen/oil/oil.dart';
// import 'ui/screen/user/sections/user_auth_login.dart';

enum Routes {
  home,
  drive,
  expenditure,
  oil,
  maintenance,
  simpleLogin,
  authLogin,
  signUp
}

class _Paths {
  static const String home = 'home';
  static const String drive = 'drive';
  static const String expenditure = 'expenditure';
  static const String oil = 'oil';
  static const String maintenance = 'maintenance';
  static const String simpleLogin = 'simpleLogin';
  static const String authLogin = 'authLogin';
  static const String signUp = 'signUp';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.drive: _Paths.drive,
    Routes.expenditure: _Paths.expenditure,
    Routes.oil: _Paths.oil,
    Routes.maintenance: _Paths.maintenance,
    Routes.simpleLogin: _Paths.simpleLogin,
    Routes.authLogin: _Paths.authLogin,
    Routes.signUp: _Paths.signUp
  };

  static String of(Routes route) => _pathMap[route] ?? home;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {

    print("generate Route settings name ${settings.name}");
    
    switch (settings.name) {
      case _Paths.home:
        return FadeRoute(page: const HomeScreen());
      case _Paths.drive:
        return FadeRoute(page: const DriveScreen());
      case _Paths.expenditure:
        return FadeRoute(page: const ExpenditureScreen());
      case _Paths.oil:
        return FadeRoute(page: const OilScreen());
      case _Paths.maintenance:
        return FadeRoute(page: const MaintenanceScreen());
      case _Paths.simpleLogin:
        return FadeRoute(page: const UserScreen());
      case _Paths.authLogin:
        return FadeRoute(page: const UserAuthLogin());
      case _Paths.signUp:
        return FadeRoute(page: const UserSignUp());
      default:
        return FadeRoute(page: const UserScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}