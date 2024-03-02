import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/screen/fruits_detail_screen.dart';
import 'package:frufav/screen/fruits_list_screen.dart';
import 'package:go_router/go_router.dart';

final _fruitsGoRouteList = [
  ('/list', (_) => const FruitsListScreen()),
  ('/detail', (fruitsInfo) => FruitsDetailScreen(fruitsInfo: fruitsInfo)),
];

final fruitsGoRouterProvider = Provider.autoDispose(
  (ref) => GoRouter(
    initialLocation: '/list',
    routes: _fruitsGoRouteList
        .map(
          (record) => GoRoute(
            path: record.$1,
            builder: (_, state) => record.$2.call(state.extra),
          ),
        )
        .toList(),
  ),
);
