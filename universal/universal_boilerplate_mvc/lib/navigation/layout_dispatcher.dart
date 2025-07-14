import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/pop_route/pop_route_cubit.dart';
import '../widgets/automatic_back_button_.dart';
import '../widgets/navigation_buttons.dart';

/// [LayoutDispatcher] is the 'big guy', this widget is responsible for:
/// - Dynamically rendering the arrow back button in the app bar
/// - Rendering the bottom navigation bar
/// - Rendering the side navigation bar
/// - Rendering the app bar
/// - Rendering the pages
/// I also have to mantion that we use [navigationShell] and [GoRouter] to
/// navigate between the pages.
///
class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    /// Update the state of PopRouteCubit.
    /// This is done to ensure that the back button visibility is updated when the user navigates
    /// to a new page or pops a page from the stack.
    /// Use this with [AutomaticBackButton] to show/hide the back button 'automatically'.
    ///
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopRouteCubit>().updateCanPop(GoRouter.of(context).canPop());
    });

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(4),
            height: double.infinity,
            child: Row(
              spacing: 8,
              children: [
                /// Here we don't use the [AutomaticBackButton] widget to show/hide the back button
                /// because appBar rebuilds differently than the body of the app.
                /// In the body we must use [AutomaticBackButton] while here it's not necessary.
                ///
                ListenableBuilder(
                  listenable: GoRouter.of(context).routerDelegate,
                  builder:
                      (context, _) => Visibility(
                        visible: GoRouter.of(context).canPop(),
                        child: BackButton(
                          onPressed: () => GoRouter.of(context).pop(),
                        ),
                      ),
                ),
                Expanded(
                  child: NavigationButtons(navigationShell: navigationShell),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NavigationButtons(navigationShell: navigationShell),
        ),
        body: LayoutBuilder(
          builder:
              (context, constraints) => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 20,
                      ),
                      // By using this the height of the side navigation is determined by the biggest child.
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              color: Colors.amber,
                              child: Column(
                                children: [
                                  AutomaticBackButton(),
                                  Text('Side Navigation'),
                                ],
                              ),
                            ),
                            VerticalDivider(width: 1, thickness: 1),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: navigationShell,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      color: Colors.teal,
                      child: Center(child: const Text("Footer")),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
