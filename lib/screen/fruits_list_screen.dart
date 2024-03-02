import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/model/fruits_info.dart';
import 'package:frufav/riverpod/fruits_info_provider.dart';
import 'package:frufav/screen/fruits_detail_screen.dart';

class FruitsListScreen extends ConsumerWidget {
  const FruitsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      fruitsListProvider,
      (previous, next) {
        addFavoriteFruitsListener(context, previous, next);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('フルーツ'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: ref.watch(fruitsListProvider).fruitsInfoList.length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (_, index) {
            return _FruitsListItem(
              fruitsInfo:
                  ref.read(fruitsListProvider).fruitsInfoList.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}

class _FruitsListItem extends ConsumerWidget {
  const _FruitsListItem({required this.fruitsInfo});

  final FruitsInfo fruitsInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onLongPressStart: (_) {
          if (ref
              .read(fruitsListProvider)
              .favoriteFruitsInfoList
              .any((f) => f.fruitsName == fruitsInfo.fruitsName)) {
            return;
          }
          ref
              .read(fruitsListProvider.notifier)
              .addFavoriteFruitsInfo(fruitsInfo);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ref.watch(fruitsListProvider).favoriteFruitsInfoList.any(
                        (f) => identical(f.fruitsName, fruitsInfo.fruitsName),
                      )
                  ? Colors.red
                  : Colors.grey,
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
