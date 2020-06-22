
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setup(){
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
}