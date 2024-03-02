enum DropDownButtonType {
  all(text: 'デフォルト'),
  favorites(text: 'お気に入り');

  const DropDownButtonType({
    required this.text,
  });

  final String text;
}
