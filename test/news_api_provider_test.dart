import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';

main() {
  test(('Fetch top ids returns a list of ids'), () async {
    //setup of test case
    final newsAPI = NewsApiProvider();

    newsAPI.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    //expectation

    final ids = await newsAPI.fetchTopIds();

    expect(ids, [1, 2, 3, 4, 5]);
  });

  test('Fetch item returns an item model', () async {
    final newsAPI = NewsApiProvider();

    newsAPI.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsAPI.fetchItem(999);

    expect(item.id, 123);
  });
}
