part of 'days_view_leaf_render_object_widget.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final BoxDecoration? headerDecoration;

  const Header({
    super.key,
    required this.title,
    this.onTap,
    this.textStyle,
    this.headerDecoration,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: headerDecoration ??
                BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(100),
                ),
            child: Text(
              title,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      );
}
