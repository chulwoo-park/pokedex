abstract class NewsListEvent {}

class NewsListRequested implements NewsListEvent {
  const NewsListRequested({this.refresh = false});

  final bool refresh;
}
