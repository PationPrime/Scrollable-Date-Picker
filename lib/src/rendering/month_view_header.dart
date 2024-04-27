part of 'days_view_leaf_render_object_widget.dart';

class MonthViewHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final BoxDecoration? headerDecoration;
  final Color? headerColor;
  final bool disabled;

  const MonthViewHeader({
    super.key,
    required this.title,
    this.onTap,
    this.textStyle,
    this.headerDecoration,
    this.headerColor,
    this.disabled = false,
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
                  color: headerColor ?? Colors.white10,
                  borderRadius: BorderRadius.circular(100),
                ),
            child: Text(
              title,
              style: textStyle ??
                  TextStyle(
                    fontSize: 16,
                    color: disabled ? Colors.grey[500] : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      );
}
