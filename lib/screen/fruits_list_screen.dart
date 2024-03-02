import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/riverpod/fruits_info_provider.dart';

class FruitsListScreen extends ConsumerWidget {
  const FruitsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              thumbnailUrl: ref
                  .watch(fruitsListProvider)
                  .fruitsInfoList
                  .elementAt(index)
                  .thumbnailUrl!,
            );
          },
        ),
      ),
    );
  }
}

class _FruitsListItem extends StatelessWidget {
  const _FruitsListItem({required this.thumbnailUrl});

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(thumbnailUrl).image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
