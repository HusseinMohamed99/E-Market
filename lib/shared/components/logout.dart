import 'package:super_marko/Screens/login/login_screen.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/shared/components/navigator.dart';

void logOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, const LoginScreen());
    }
  });
}
