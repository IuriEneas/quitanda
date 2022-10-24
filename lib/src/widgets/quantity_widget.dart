import 'package:flutter/material.dart';
import 'package:quitanda/src/config/custom_color.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.value,
    required this.sufixText,
    required this.result,
    this.isRemovable = false,
  });

  final int value;
  final String sufixText;
  final Function(int quantity) result;
  final bool isRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Colors.grey.shade300,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          !isRemovable || value > 1
              ? _QuatityWidget(
                  color: Colors.grey,
                  icon: Icons.remove,
                  onPressed: () {
                    if (value == 1) return;
                    int resultCount = value - 1;
                    result(resultCount);
                  },
                )
              : _QuatityWidget(
                  color: Colors.red,
                  icon: Icons.delete_forever,
                  onPressed: () {
                    if (value == 0) return;
                    int resultCount = value - 1;
                    result(resultCount);
                  },
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '$value$sufixText',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _QuatityWidget(
            color: CustomColors.customSwatchColor,
            icon: Icons.add,
            onPressed: () {
              int resultCount = value + 1;
              result(resultCount);
            },
          )
        ],
      ),
    );
  }
}

class _QuatityWidget extends StatelessWidget {
  const _QuatityWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        splashColor: Colors.black.withOpacity(0.3),
        onTap: onPressed,
        child: Ink(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
