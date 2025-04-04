import 'package:presentation/theme/theme_picker.dart';
import 'package:flutter/material.dart';
import 'package:presentation/utils/placeholder_painter.dart';

class ExpositionWidget extends StatelessWidget {
  final String name;
  final Image? image;
  final String startDate;
  final String endDate;
  final bool isSubscribed;
  final void Function() onTap;
  final void Function() onTapSubscribe;

  const ExpositionWidget({
    super.key,
    required this.name,
    this.image,
    required this.onTap,
    required this.onTapSubscribe,
    required this.isSubscribed,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.white,
      margin: const EdgeInsets.all(0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: PlaceholderPainter(
                    seed: name,
                    isVertical: false,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            name,
                            style: context.textStyles.s24w400.copyWith(
                              color: context.colors.primary,
                              height: 1,
                            ),
                          ),
                        ),
                        Text(
                          "$startDate — $endDate",
                          style: context.textStyles.s14w400.copyWith(color: context.colors.grey),
                        ),
                      ],
                    ),
                  ),
                  _SubscribeButton(
                    isSubscribed: isSubscribed,
                    onTapSubscribe: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscribeButton extends StatelessWidget {
  final bool isSubscribed;
  final void Function() onTapSubscribe;

  const _SubscribeButton({
    required this.isSubscribed,
    required this.onTapSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTapSubscribe,
      icon: Icon(
        isSubscribed ? Icons.notifications : Icons.notifications_none,
        size: 32,
        color: isSubscribed ? context.colors.primary : context.colors.grey,
      ),
    );
  }
}
