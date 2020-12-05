import 'package:bloc/bloc.dart';

import '../../domain/news/usecase.dart';
import '../common/state.dart';
import 'event.dart';

class NewsListBloc extends Bloc<NewsListEvent, AsyncState> {
  NewsListBloc(this._getNewsList) : super(Initial());

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
      final result = await _getNewsList();
      yield LoadSuccess(result);
    } on Exception catch (e, s) {
      // TODO: improve error handling
      yield LoadFailure(e, s);
    }
  }
}
