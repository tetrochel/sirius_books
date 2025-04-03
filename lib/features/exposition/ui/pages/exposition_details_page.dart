import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/constants.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';
import 'package:sirius_books/features/utils/enums.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class ExpositionDetailsPage extends StatefulWidget {
  final ExpositionModel exposition;
  final Mode mode;

  const ExpositionDetailsPage({
    required this.exposition,
    required this.mode,
    super.key,
  });

  @override
  State<ExpositionDetailsPage> createState() => _ExpositionDetailsPageState();
}

class _ExpositionDetailsPageState extends State<ExpositionDetailsPage> {
  late final ExpositionModel exposition;
  late final TextEditingController nameController;
  late final TextEditingController topicController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;
  late final TextEditingController endDateController;
  late final TextEditingController startDateController;
  late Mode mode;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
    exposition = widget.exposition;
    nameController = TextEditingController(text: exposition.name);
    topicController = TextEditingController(text: exposition.topic);
    descriptionController = TextEditingController(text: exposition.description);
    locationController = TextEditingController(text: exposition.location);
    startDateController = TextEditingController(
      text: defaultDateFormat.format(exposition.startDate),
    );
    endDateController = TextEditingController(
      text: defaultDateFormat.format(exposition.endDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = mode == Mode.view;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              titleSpacing: 0,
              pinned: true,
              shadowColor: Colors.black,
              backgroundColor: context.colors.white,
              surfaceTintColor: context.colors.white,
              title: AppBarWidget(
                title: widget.exposition.name,
                disablePadding: true,
                actions: [
                  if (mode == Mode.view)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mode = Mode.edit;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: context.colors.primary,
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                        color: context.colors.primary,
                      ),
                    ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.name,
                    textController: nameController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.topic,
                    textController: topicController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.description,
                    textController: descriptionController,
                    readOnly: readOnly,
                    textInputType: TextInputType.multiline,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.location,
                    textController: locationController,
                    readOnly: readOnly,
                  ),
                  DateFieldWidget(
                    onTap: mode == Mode.edit ? () => _selectDate(context, false) : null,
                    controller: startDateController,
                    label: AppLocalizations.of(context)!.startDate,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DateFieldWidget(
                    onTap: mode == Mode.edit ? () => _selectDate(context, true) : null,
                    controller: endDateController,
                    label: AppLocalizations.of(context)!.endDate,
                  ),
                ]),
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) => BookWidget(
                name: widget.exposition.books[index].name,
                authorName: widget.exposition.books[index].authorName,
                genre: widget.exposition.books[index].genre,
                onTap: () {
                  context.push(
                    '/books/details',
                    extra: widget.exposition.books[index],
                  );
                },
                onTapBookmark: () {},
              ),
              itemCount: widget.exposition.books.length,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isEndDate) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (!context.mounted) {
      return;
    }

    if (picked != null) {
      if (isEndDate) {
        if (startDate != null && picked.isBefore(startDate!)) {
          _showErrorDialog(
            AppLocalizations.of(context)!.errorStartDateAfterEndDate,
          );
          return;
        }
        endDate = picked;
        endDateController.text = defaultDateFormat.format(endDate!);
      } else {
        if (endDate != null && picked.isAfter(endDate!)) {
          _showErrorDialog(
            AppLocalizations.of(context)!.errorStartDateAfterEndDate,
          );
          return;
        }
        startDate = picked;
        startDateController.text = defaultDateFormat.format(startDate!);
      }
      setState(() {});
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ОК'),
          ),
        ],
      ),
    );
  }
}
