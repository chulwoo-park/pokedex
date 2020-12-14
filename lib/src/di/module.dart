import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/src/data/news/repository.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/repository.dart';

import '../data/news/data_source.dart';
import '../domain/news/usecase.dart';
import '../pokemon_official/news/api.dart';

final getIt = GetIt.instance;

void setUpDomain() {
  getIt.registerFactory(() => GetNewsList(getIt.get()));
}

void setUpData() {
  getIt.registerSingleton<LocalNewsSource>(MockLocalNewsSource());
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

class MockLocalNewsSource implements LocalNewsSource {
  @override
  Future<Page<News>> getNewsList(PageKey? pageKey) async {
    // TODO: implement getNewsList
    throw UnimplementedError();
  }

  @override
  Future<void> setNewsList(PageKey? pageKey, Page<News> page) {
    // TODO: implement setNewsList
    throw UnimplementedError();
  }
}
