import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _toMain();
      case '/details':
        return _toDetails(settings.arguments as int);
    }

    return null;
  }

  Route _toMain() {
    return MaterialPageRoute(
      builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();

        return NewsList();
      },
    );
  }

  Route _toDetails(int id) {
    return MaterialPageRoute(
      builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        commentsBloc.fetchItemWithComments(id);

        return NewsDetail(id: id);
      },
    );
  }
}
