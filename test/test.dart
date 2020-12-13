import 'package:mockito/annotations.dart';
import 'package:pokedex/src/data/news/data_source.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/repository.dart';
import 'package:pokedex/src/domain/news/usecase.dart';

@GenerateMocks([
  PageKey,
  NewsRepository,
  RemoteNewsSource,
  LocalNewsSource,
  GetNewsList,
  Exception,
])
void main() {}
