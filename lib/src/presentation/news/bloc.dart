import 'package:bloc/bloc.dart';

import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';
import '../../domain/news/usecase.dart';
import '../common/state.dart';
import 'event.dart';

class NewsListBloc extends Bloc<NewsListEvent, AsyncState> {
  NewsListBloc(
    this._refreshNewsList,
    this._getNewsList,
  ) : super(Initial());

  final RefreshNewsList _refreshNewsList;
  final GetNewsList _getNewsList;

  @override
  Stream<AsyncState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsListRequested) {
      yield* _mapSearchTermChangedToState(event, state);
    }
  }

  Stream<AsyncState> _mapSearchTermChangedToState(
    NewsListRequested event,
    AsyncState state,
  ) async* {
    if (state is Loading) {
      return;
    }

    yield Loading();

    try {
      Page<News> result;
      if (event.refresh) {
        result = await _refreshNewsList();
      } else {
        result = await _getNewsList();
      }
      yield LoadSuccess(result);
    } on Exception catch (e, s) {
      // TODO: improve error handling
      yield LoadFailure(e, s);
    }
  }
}
