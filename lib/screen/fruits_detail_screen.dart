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
    return Scaffold(
      appBar: AppBar(
        title: const Text('フルーツ'),
        centerTitle: true,
      ),
      body: _FruitsDetailContent(fruitsInfo: fruitsInfo),
    );
  }
}

class _FruitsDetailContent extends StatelessWidget {
  const _FruitsDetailContent({required this.fruitsInfo});

  final FruitsInfo fruitsInfo;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(fruitsInfo.thumbnailUrl!),
        _FruitsDetailListItem(
          title: "${fruitsInfo.fruitsName!}の概要",
          detail: fruitsInfo.overview!,
        ),
        _FruitsDetailListItem(
          title: "${fruitsInfo.fruitsName!}の歴史",
          detail: fruitsInfo.history!,
        ),
        _FruitsDetailListItem(
          title: "${fruitsInfo.fruitsName!}の選び方",
          detail: fruitsInfo.select!,
          imageUrl: fruitsInfo.selectImageUrl,
        ),
        _FruitsDetailListItem(
          title: "${fruitsInfo.fruitsName!}の保存方法",
          detail: fruitsInfo.save!,
          imageUrl: fruitsInfo.saveImageUrl,
        )
      ],
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
              if (imageUrl != null || imageUrl?.isNotEmpty == true)
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
