import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/drop_down_button_type.dart';
import 'package:frufav/model/fruits_info.dart';
import 'package:frufav/riverpod/fruits_go_router_provider.dart';
import 'package:frufav/riverpod/fruits_list_notifier.dart';
import 'package:frufav/riverpod/snack_bar_notifier.dart';

final _fruitsListProvider =
    StateNotifierProvider<FruitsListNotifier, FruitsListState>(
        (_) => FruitsListNotifier());

class FruitsListScreen extends StatelessWidget {
  const FruitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final fruitsListState = ref.watch(_fruitsListProvider);
        final fruitsListProvider = ref.read(_fruitsListProvider.notifier);
        final fruitsInfoList = fruitsListState._fruitsInfoList;
        return Scaffold(
          appBar: AppBar(
            title: const Text('フルーツ'),
            centerTitle: true,
            actions: [
              _FruitsListSortButtonWidget(
                selectedItemType: fruitsListState.lastSortedInfoListType,
                onSelectedItem: (type) {
                  fruitsListProvider.updateLastSortedInfoList(DropDownButtonType
                      .values
                      .firstWhere((d) => identical(d, type)));
                },
              ),
            ],
          ),
          body: Center(
            child: ListView.builder(
              itemCount: fruitsInfoList.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (_, index) {
                final fruitsInfo = fruitsInfoList.elementAt(index);
                return _FruitsListItem(
                  fruitsInfo: fruitsInfo,
                  favorite: fruitsListState.favoriteFruitsInfoList.any(
                      (f) => identical(f.fruitsName, fruitsInfo.fruitsName)),
                  onTapItem: (info) {
                    ref
                        .read(fruitsGoRouterProvider)
                        .push('/detail', extra: info);
                  },
                  onLongPressStart: () =>
                      _longPressStart(context, ref, fruitsInfo),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _longPressStart(
    BuildContext context,
    WidgetRef ref,
    FruitsInfo fruitsInfo,
  ) {
    final fruitsListNotifier = ref.read(_fruitsListProvider.notifier);
    final snackBarNotifier = ref.read(snackBarProvider.notifier);
    if (!ref.read(_fruitsListProvider).checkFavoriteFruitsInfo(fruitsInfo)) {
      fruitsListNotifier.addFavoriteFruitsInfo(fruitsInfo);
      snackBarNotifier._addSnackBar(
        fruitsName: fruitsInfo.fruitsName!,
        suffixContentText: 'をお気に入りに登録しました。',
      );
      return;
    }
    fruitsListNotifier.removeFavoriteFruitsInfo(fruitsInfo);
    snackBarNotifier._addSnackBar(
      fruitsName: fruitsInfo.fruitsName!,
      suffixContentText: 'をお気に入りから外しました。',
    );
  }
}

class _FruitsListSortButtonWidget extends StatelessWidget {
  const _FruitsListSortButtonWidget({
    required this.selectedItemType,
    required this.onSelectedItem,
  });

  final DropDownButtonType selectedItemType;
  final void Function(DropDownButtonType) onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: DropdownButton(
        underline: Container(),
        value: selectedItemType,
        items: DropDownButtonType.values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item.text),
              ),
            )
            .toList(),
        onChanged: (value) {
          onSelectedItem.call(value!);
        },
      ),
    );
  }
}

class _FruitsListItem extends StatelessWidget {
  const _FruitsListItem({
    required this.fruitsInfo,
    required this.favorite,
    required this.onTapItem,
    required this.onLongPressStart,
  });

  final FruitsInfo fruitsInfo;
  final bool favorite;
  final void Function(FruitsInfo) onTapItem;
  final VoidCallback onLongPressStart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          onTapItem.call(fruitsInfo);
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

extension on SnackBarNotifier {
  void _addSnackBar({
    required String fruitsName,
    required String suffixContentText,
  }) {
    addSnackBar(
      SnackBar(
        content: Container(
          alignment: AlignmentDirectional.center,
          child: Text('$fruitsName$suffixContentText'),
        ),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension on FruitsListState {
  List<FruitsInfo> get _fruitsInfoList =>
      identical(lastSortedInfoListType, DropDownButtonType.all)
          ? fruitsInfoList
          : favoriteFruitsInfoList;
}
