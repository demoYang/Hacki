import 'package:get_it/get_it.dart';
import 'package:hacki/repositories/repositories.dart';
import 'package:hacki/services/services.dart';

/// Global [GetIt.instance].
final locator = GetIt.instance;

/// Set up [GetIt] locator.
Future<void> setUpLocator() async {
  locator
    ..registerSingleton<StoriesRepository>(StoriesRepository())
    ..registerSingleton<CacheService>(CacheService());
}