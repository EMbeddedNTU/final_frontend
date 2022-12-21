import 'package:final_frontend/data/client.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

setupService() async {
  await initClientDI(_getIt);
}
