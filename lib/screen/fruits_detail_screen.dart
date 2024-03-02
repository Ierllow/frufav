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
      body: ListView(
        children: [
          Image.asset(fruitsInfo.thumbnailUrl!),
          _FruitsDetailListItem(
            title: "${fruitsInfo.fruitsName!}の概要",
            subtitle: fruitsInfo.overview!,
          ),
          _FruitsDetailListItem(
            title: "${fruitsInfo.fruitsName!}の歴史",
            subtitle: fruitsInfo.history!,
          ),
          _FruitsDetailListItem(
            title: "${fruitsInfo.fruitsName!}の選び方",
            subtitle: fruitsInfo.select!,
            imageUrl: fruitsInfo.selectImageUrl,
          ),
          _FruitsDetailListItem(
            title: "${fruitsInfo.fruitsName!}の保存方法",
            subtitle: fruitsInfo.save!,
            imageUrl: fruitsInfo.saveImageUrl,
          ),
        ],
      ),
    );
  }
}

class _FruitsDetailListItem extends StatelessWidget {
  const _FruitsDetailListItem({
    required this.title,
    required this.subtitle,
    this.imageUrl,
  });

  final String title;
  final String subtitle;
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
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(imageUrl!),
                ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(subtitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
