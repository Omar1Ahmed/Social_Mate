import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';

Future<void> saveToken(String token) async {
  final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
  if (token.isNotEmpty ) {
    
  await _sharedPrefHelper.saveString(SharedPrefKeys.saveKey, token);
  }
}
Future<void> logout() async {
  final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
  await _sharedPrefHelper.remove(SharedPrefKeys.saveKey);
}