import 'package:flutter/material.dart';
import 'package:frufav/model/fruits_info.dart';

class FruitsDetailScreen extends StatelessWidget {
  const FruitsDetailScreen({
    super.key,
    required this.fruitsInfo,
  });

  final FruitsInfo fruitsInfo;

  @override
  Widget build(BuildContext context) {
    final fruitsDetailListItemList = fruitsInfo._fruitsDetailListItemList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('フルーツ'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.asset(fruitsInfo.thumbnailUrl!),
          ...fruitsDetailListItemList,
        ],
      ),
    );
  }
}

class _FruitsDetailListItem extends StatelessWidget {
  const _FruitsDetailListItem({
    required this.title,
    required this.detail,
    this.imageUrl,
  });

  final String title;
  final String detail;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Column(
            children: [
              if (!imageUrl._isNullOrEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(imageUrl!),
                ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(detail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on String? {
  bool get _isNullOrEmpty => !(this != null && this!.isNotEmpty);
}

extension on FruitsInfo {
  List<_FruitsDetailListItem> get _fruitsDetailListItemList => [
        _FruitsDetailListItem(
          title: "$fruitsName!の概要",
          detail: overview!,
        ),
        _FruitsDetailListItem(
          title: "$fruitsName!の歴史",
          detail: history!,
        ),
        _FruitsDetailListItem(
          title: "$fruitsName!の選び方",
          detail: select!,
          imageUrl: selectImageUrl,
        ),
        _FruitsDetailListItem(
          title: "$fruitsName!の保存方法",
          detail: save!,
          imageUrl: saveImageUrl,
        )
      ];
}
