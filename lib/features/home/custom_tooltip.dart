import 'package:flutter/material.dart';
class CustomTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final void Function()? onTap;



  CustomTooltip({required this.child, required this.message, required this.onTap});

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () async {
        _showTooltip();
        widget.onTap!();
      },
      child: widget.child,
    );
  }

  void _showTooltip() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final targetOffset = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: targetOffset.dx + (targetSize.width / 2) - 75,
        top: targetOffset.dy - 45, // Adjust this value to position the tooltip
        child: Material(
          color: const Color.fromARGB(0, 41, 41, 41),
          child: CustomPaint(
            painter: TooltipPainter(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(bottom: 10), // Adjust this for V shape spacing
              child: Text(
                widget.message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(seconds: 2), () {
      _overlayEntry?.remove();
    });
  }
}

class TooltipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 39, 39, 39)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height - 10), // Adjust height for the V shape
        Radius.circular(20),
      ));

    Path vPath = Path()
      ..moveTo(size.width / 2 - 10, size.height - 10)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 + 10, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(vPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}