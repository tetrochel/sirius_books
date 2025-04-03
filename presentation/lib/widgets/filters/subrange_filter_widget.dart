import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class SubrangeFilterWidget extends StatefulWidget {
  final String id;
  final String name;
  final int min;
  final int max;
  final void Function((int, int)) onChanged;

  const SubrangeFilterWidget({
    super.key,
    required this.id,
    required this.name,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  State<SubrangeFilterWidget> createState() => _SubrangeFilterWidgetState();
}

class _SubrangeFilterWidgetState extends State<SubrangeFilterWidget> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues =
        RangeValues(widget.min.toDouble(), widget.max.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: context.textStyles.s16w600,
            ),
            Text(
              '${_currentRangeValues.start.round()} — ${_currentRangeValues.end.round()}',
              style: context.textStyles.s16w600,
            ),
          ],
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          onChanged: (values) {
            final newValues = RangeValues(
              values.start.round().toDouble(),
              values.end.round().toDouble(),
            );
            if (newValues != _currentRangeValues) {
              setState(() {
                _currentRangeValues = newValues;
              });
              widget.onChanged((_currentRangeValues.start.round(), _currentRangeValues.end.round()));
            }
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
