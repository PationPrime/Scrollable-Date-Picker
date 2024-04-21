part of 'days_view_leaf_render_object_widget.dart';

class MonthTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const MonthTitle({
    super.key,
    required this.title,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
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
