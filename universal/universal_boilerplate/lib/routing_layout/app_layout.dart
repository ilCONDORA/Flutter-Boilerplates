/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:universal_boilerplate/routing_layout/app_router.dart';
import 'package:universal_boilerplate/routing_layout/app_router.gr.dart';

@RoutePage()
class AppLayout extends StatelessWidget {
  const AppLayout({super.key});
  final Axis directionOfIconAndLabel = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // In the guides it says to use the routes property, but I don't use the index to navigate so I will comment it out.
      /* routes: listOfRoutes
          .where((element) => element.isVisible)
          .map((e) => e.widget)
          .toList(), */
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return SelectionArea(
          child: PieCanvas(
            theme: PieTheme(
              delayDuration: Duration
                  .zero, // delayDuration is how much time you need to press the button for the menu to appear. So 'zero' is a tap.
              pointerSize:
                  0, // By setting this to 0, the circle that indicates where you clicked will not appear.
              buttonTheme: const PieButtonTheme(
                // These are the default values, quite ugly.
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
              ),
              buttonThemeHovered: PieButtonTheme(
                // These are the default values, quite ugly.
                backgroundColor: Colors.green,
                iconColor: Colors.white,
              ),
            ),
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(child: child),
                  Container(
                    color: Colors.white,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...listOfRouteProperties
                            .asMap()
                            .entries
                            .where(
                              (element) => element.value.showWidget,
                            )
                            .map((entry) {
                          final route = entry.value;
                          final isSelected = tabsRouter.current.name ==
                              route.pageWidget.routeName;

                          return TextButton(
                            onPressed: () => AutoRouter.of(context)
                                .navigate(route.pageWidget),
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing:
                                  directionOfIconAndLabel == Axis.horizontal
                                      ? 5
                                      : 0,
                              direction: directionOfIconAndLabel,
                              children: [
                                // I don't use Visibility because it takes up space even if it's not visible.
                                if (route.showIcons)
                                  Icon(
                                    isSelected && route.selectedIcon != null
                                        ? route.selectedIcon!
                                        : route.unselectedIcon,
                                    color:
                                        isSelected ? Colors.black : Colors.grey,
                                  ),
                                if (route.showLabel && isSelected)
                                  Text(
                                    route.label(context),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
 */