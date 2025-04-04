import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class EnumFilterWidget<Enum> extends StatefulWidget {
  final String id;
  final String name;
  final List<Enum> enums;
  final List<String> names;
  final void Function(List<Enum>) onChanged;

  const EnumFilterWidget({
    required this.id,
    required this.name,
    required this.enums,
    required this.names,
    required this.onChanged,
    super.key,
  });

  @override
  State<EnumFilterWidget<Enum>> createState() => _EnumFilterWidgetState<Enum>();
}

class _EnumFilterWidgetState<Enum> extends State<EnumFilterWidget<Enum>> {
  Set<Enum> _selection = {};

  @override
  void initState() {
    super.initState();
    _selection = widget.enums.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.name,
          style: context.textStyles.s16w600,
        ),
        SizedBox(height: 4),
        SegmentedButton<Enum>(
          selected: _selection,
          segments: List.generate(
            widget.enums.length,
            (index) => ButtonSegment(
              value: widget.enums[index],
              label: Text(
                widget.names[index],
                style: context.textStyles.s12w400,
              ),
            ),
          ),
          onSelectionChanged: (Set<Enum> newSelection) {
            widget.onChanged(newSelection.toList());
            setState(
              () {
                _selection = newSelection;
              },
            );
          },
          multiSelectionEnabled: true,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
