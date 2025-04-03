import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class EnumSelectorWidget<Enum> extends StatefulWidget {
  final String label;
  final List<Enum> enums;
  final List<String> names;
  final Enum? selectedEnum;

  const EnumSelectorWidget({
    super.key,
    required this.label,
    required this.enums,
    this.selectedEnum,
    required this.names,
  });

  @override
  State<EnumSelectorWidget> createState() => _EnumSelectorWidgetState();
}

class _EnumSelectorWidgetState extends State<EnumSelectorWidget> {
  Set<Enum> _selection = {};

  @override
  void initState() {
    super.initState();
    _selection = {widget.selectedEnum ?? widget.enums.first};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: context.textStyles.s16w600,
        ),
        SizedBox(height: 4),
        SegmentedButton<Enum>(
          style: ButtonStyle(),
          selected: _selection,
          segments: List.generate(
            widget.enums.length,
            (index) => ButtonSegment(
              value: widget.enums[index],
              label: Text(
                widget.names[index],
                // TODO(ivan): добавить стиль тексту
              ),
            ),
          ),
          onSelectionChanged: (Set<Enum> newSelection) {
            setState(
              () {
                _selection = newSelection;
              },
            );
          },
          multiSelectionEnabled: false,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
