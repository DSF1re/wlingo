import 'package:flutter/material.dart';

class MicrophoneIndicatorButton extends StatefulWidget {
  final bool isActive;
  final Future<String> Function() onRecordAndCheck;
  final Future<void> Function()? onStopListen;
  final void Function(bool isActive)? onStateChanged;

  const MicrophoneIndicatorButton({
    super.key,
    required this.isActive,
    required this.onRecordAndCheck,
    this.onStateChanged,
    this.onStopListen,
  });

  @override
  State<MicrophoneIndicatorButton> createState() =>
      _MicrophoneIndicatorButtonState();
}

class _MicrophoneIndicatorButtonState extends State<MicrophoneIndicatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(MicrophoneIndicatorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.isActive) {
      // Если микрофон уже активен — останавливаем слушанье
      await widget.onStopListen?.call();
      widget.onStateChanged?.call(false);
      return;
    }
    widget.onStateChanged?.call(true);
    await widget.onRecordAndCheck();
    widget.onStateChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isActive ? Colors.redAccent : Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: [
              if (widget.isActive)
                BoxShadow(
                  color: Colors.redAccent,
                  blurRadius: 32,
                  spreadRadius: 6,
                ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Icon(
            Icons.mic,
            size: 38,
            color: widget.isActive ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
