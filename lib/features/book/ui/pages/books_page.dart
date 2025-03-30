import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class BooksPage extends StatelessWidget {
  final Widget appBar;
  final List<Widget> children;

  const BooksPage({
    required this.appBar,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.black,
          backgroundColor: context.colors.white,
          surfaceTintColor: context.colors.white,
          title: appBar,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => children[index],
              childCount: children.length,
            ),
          ),
        ),
      ],
    );
  }
}
