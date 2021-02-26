import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:spot_discovery/app/locator.config.dart';

final locator = GetIt.I;

@injectableInit
void setupLocator() => $initGetIt(locator);
