import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/news/data_source.dart';
import '../data/news/repository.dart';
import '../domain/news/repository.dart';
import '../domain/news/usecase.dart';
import '../hive/news/source.dart';
import '../pokemon_official/news/api.dart';

final getIt = GetIt.instance;

void setUpDomain() {
  getIt.registerFactory(() => GetNewsList(getIt.get()));
  getIt.registerFactory(() => RefreshNewsList(getIt.get()));
}

void setUpData() {
  getIt.registerSingleton<LocalNewsSource>(HiveNewsSource());
  getIt.registerSingleton<RemoteNewsSource>(
    NewsApi(getIt.get(instanceName: 'pokemon-official')),
  );

  getIt.registerSingleton<NewsRepository>(
    NewsRepositoryImpl(getIt.get(), getIt.get()),
  );
}

void setUpPokemonOfficialApi() {
  getIt.registerFactory(
    () => Dio(BaseOptions(baseUrl: 'https://api.pokemon.com')),
    instanceName: 'pokemon-official',
  );
}
