import 'package:final_frontend/data/client/gesture_service.dart';
import 'package:final_frontend/environments/environment_singleton.dart';
import 'package:get_it/get_it.dart';

initClientDI(GetIt getIt) async {
  String url = Environment().config.baseUrl;
  print('Base Url: $url');
  getIt.registerLazySingleton(() => GestureService(url: url));

  // final sharedPrefs = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton(() => LocalDataStore(prefs: sharedPrefs));
}
