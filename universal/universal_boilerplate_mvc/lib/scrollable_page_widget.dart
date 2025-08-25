import 'package:flutter/material.dart';

import 'widgets/footer.dart';

/// Abstract class used by almost every page, it replaces [StatelessWidget].
/// 
/// Here in the [build] method we create a [SingleChildScrollView] and it creates a
/// layout so that in a row we have a side menu and the page content and below them
/// there's a footer that is displayed only on large screens.
/// 
/// The [buildPageContent] method will be used by every class that extends this class
/// and it 'replaces' the standard [build] method.
/// 
/// All this is because we can flawlessly have side menu and footer on every page without
/// breaking everything or using heavy widgets.
/// 
abstract class ScrollablePageWidget extends StatelessWidget {
  const ScrollablePageWidget({super.key});

  Widget buildPageContent(BuildContext context);

  // Opzional: every page can have its own scroll controller.
  ScrollController? get scrollController => null;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.green,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Side Menu',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: buildPageContent(context)),
            ],
          ),
          if (MediaQuery.sizeOf(context).width > 600) Footer(),
        ],
      ),
    );
  }
}
