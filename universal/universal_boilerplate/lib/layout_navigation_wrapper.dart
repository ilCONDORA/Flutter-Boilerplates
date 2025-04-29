import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'routes/router.dart';

@RoutePage()
class LayoutNavigationWrapper extends StatelessWidget {
  const LayoutNavigationWrapper({super.key});

  static const double mobileTabletPortraitBreakpoint = 654; //600
  static const double webSmallBreakpoint = 1221; //1200
  static const double webAppBarHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;

    bool showSideNavByButton = false;
    final bool showSideNavByWidth =
        currentWidth > mobileTabletPortraitBreakpoint;
    final bool showBottomNav = currentWidth <= mobileTabletPortraitBreakpoint;

    return AutoTabsRouter(
      // list of your tab routes
      // routes used here must be declared as children routes of LayoutNavigationWrapper
      routes: [
        ...listOfNavigationRoutesAndChildren
            .map((individualRoute) => individualRoute.route)
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final scrollController = ScrollController();

        return Scaffold(
          bottomNavigationBar: kIsWeb
              ? null
              : Offstage(
                  offstage: !showBottomNav,
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.black,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.grey[100]!,
                    color: Colors.black,
                    tabs: listOfNavigationRoutesAndChildren
                        .map((individualRoute) {
                      final navProps = individualRoute.navigationProperties;

                      return GButton(
                        icon: navProps!.icon,
                        text: navProps.label(context),
                        leading: navProps.otherThingInsteadOfIcon,
                      );
                    }).toList(),
                    selectedIndex: tabsRouter.activeIndex,
                    onTabChange: (index) {
                      if (index == tabsRouter.activeIndex) {
                        final rootRoute =
                            listOfNavigationRoutesAndChildren[index].route;
                        context.router.navigate(rootRoute);
                      } else {
                        tabsRouter.setActiveIndex(index);
                      }
                    },
                  ),
                ),
          appBar: !kIsWeb
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(webAppBarHeight),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: webAppBarHeight,
                    width: double.infinity,
                    color: Colors.amber,
                    child: webSmallBreakpoint < currentWidth
                        ? Row(
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 200,
                                height: double.infinity,
                                child: Placeholder(),
                              ),
                              Expanded(
                                child: Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: listOfNavigationRoutesAndChildren
                                      .map((individualRoute) {
                                    final navProps =
                                        individualRoute.navigationProperties;
                                    final isSelected = tabsRouter.activeIndex ==
                                        listOfNavigationRoutesAndChildren
                                            .indexOf(individualRoute);

                                    return TextButton(
                                      onPressed: () {
                                        if (isSelected) {
                                          final rootRoute =
                                              individualRoute.route;
                                          context.router.navigate(rootRoute);
                                        } else {
                                          tabsRouter.setActiveIndex(
                                              listOfNavigationRoutesAndChildren
                                                  .indexOf(individualRoute));
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: isSelected
                                            ? Colors.black
                                            : Colors.grey,
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      child: Text(
                                        navProps!.label(context),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.account_circle_rounded),
                                onPressed: () {},
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(showSideNavByButton
                                    ? Icons.close_rounded
                                    : Icons.menu_rounded),
                                onPressed: () {
                                  if (showSideNavByButton) {
                                    showSideNavByButton = false;
                                  } else {
                                    showSideNavByButton = true;
                                  }
                                },
                              ),
                              SizedBox(
                                width: 200,
                                height: double.infinity,
                                child: Placeholder(),
                              ),
                              //SizedBox.shrink(),
                              IconButton(
                                icon: Icon(Icons.account_circle_rounded),
                                onPressed: () {},
                              ),
                            ],
                          ),
                  ),
                ),
          body: LayoutBuilder(
            builder: (context, constraints) => Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Offstage(
                    offstage: !showSideNavByWidth || !showSideNavByButton,
                    child: Container(
                      height: double.infinity,
                      color: Colors.amber,
                      child: Text('Side Navigation'),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 8,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          if (!kIsWeb)
                            SizedBox(
                              height: constraints.maxHeight,
                              width: 300,
                              child: child,
                            ),
                          if (kIsWeb)
                            SizedBox(
                              height: constraints.maxHeight - 32,
                              width: double.infinity,
                              child: child,
                            ),
                          if (kIsWeb)
                            Container(
                              height: 400,
                              width: double.infinity,
                              color: Colors.green,
                              child: Center(
                                child:
                                    Text('Web Footer, ${constraints.maxWidth}'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
