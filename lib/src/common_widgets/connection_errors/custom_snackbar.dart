import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends StatefulWidget {
  final IconData iconData;
  final String message;
  final bool isVisible;
  final VoidCallback onDismissed;
  final Color iconColor;

  const CustomSnackbar({
    super.key,
    required this.iconData,
    required this.message,
    required this.isVisible,
    required this.onDismissed,
    this.iconColor = Colors.white,
  });

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: const Offset(0, 0.4),
    ).animate(_controller);

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomSnackbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.reverse().then((_) => widget.onDismissed());
    }
  }

  @override
  void dispose() {
    print('Dispose called on CustomSnackbar');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    widget.iconData,
                    size: 30,
                    color: widget.iconColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
              Positioned(
                  right: 0,
                  top: -10,
                  child: IconButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent),
                    ),
                    icon:
                        const Icon(CupertinoIcons.refresh, color: Colors.green),
                    onPressed: () {
                      _controller.reverse().then((_) => widget.onDismissed());
                    },
                  )
                  // child: TextButton(
                  //   onPressed: () {
                  //     _controller.reverse().then((_) => widget.onDismissed());
                  //   },
                  //   child: const Text(
                  //     'RETRY',
                  //     style: TextStyle(color: Colors.greenAccent),
                  //   ),
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
