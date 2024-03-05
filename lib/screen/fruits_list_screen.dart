import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/model/fruits_info.dart';
import 'package:frufav/riverpod/fruits_list_notifier.dart';
import 'package:frufav/screen/fruits_detail_screen.dart';

final _fruitsListProvider =
    StateNotifierProvider<FruitsListNotifier, FruitsListState>(
        (_) => FruitsListNotifier());

class FruitsListScreen extends StatelessWidget {
  const FruitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('フルーツ'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return Center(
            child: ListView.builder(
              itemCount: ref.watch(_fruitsListProvider).fruitsInfoList.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (_, index) {
                final fruitsListState = ref.watch(_fruitsListProvider);
                final fruitsInfo =
                    fruitsListState.fruitsInfoList.elementAt(index);
                return _FruitsListItem(
                  fruitsInfo: fruitsInfo,
                  favorite: fruitsListState.favoriteFruitsInfoList.any(
                      (f) => identical(f.fruitsName, fruitsInfo.fruitsName)),
                  onLongPressStart: () =>
                      _longPressStart(context, ref, fruitsInfo),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _longPressStart(
    BuildContext context,
    WidgetRef ref,
    FruitsInfo fruitsInfo,
  ) {
    if (!ref.read(_fruitsListProvider).checkFavoriteFruitsInfo(fruitsInfo)) {
      ref.read(_fruitsListProvider.notifier).addFavoriteFruitsInfo(fruitsInfo);
      _showSnackBar(
        context,
        '${fruitsInfo.fruitsName!}をお気に入りに登録しました。',
      );
      return;
    }
    ref.read(_fruitsListProvider.notifier).removeFavoriteFruitsInfo(fruitsInfo);
    _showSnackBar(
      context,
      '${fruitsInfo.fruitsName!}をお気に入りから外しました。',
    );
  }

  void _showSnackBar(
    BuildContext context,
    String contextText,
  ) {
    final snackBar = SnackBar(
      content: Container(
        alignment: AlignmentDirectional.center,
        child: Text(contextText),
      ),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _FruitsListItem extends StatelessWidget {
  const _FruitsListItem({
    required this.fruitsInfo,
    required this.favorite,
    required this.onLongPressStart,
  });

  final FruitsInfo fruitsInfo;
  final bool favorite;
  final VoidCallback onLongPressStart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FruitsDetailScreen(fruitsInfo: fruitsInfo);
              },
            ),
          );
        },
        onLongPressStart: (_) => onLongPressStart.call(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: favorite ? Colors.red : Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(fruitsInfo.thumbnailUrl!).image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
