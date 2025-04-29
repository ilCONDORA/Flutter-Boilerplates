// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:universal_boilerplate/layout_navigation_wrapper.dart' as _i9;
import 'package:universal_boilerplate/pages/cpus/cpu_type_children_navigation_router.dart'
    as _i1;
import 'package:universal_boilerplate/pages/cpus/cpu_type_list_page.dart'
    as _i2;
import 'package:universal_boilerplate/pages/cpus/cpus_children_navigation_router.dart'
    as _i3;
import 'package:universal_boilerplate/pages/cpus/cpus_page.dart' as _i4;
import 'package:universal_boilerplate/pages/cpus/single_cpu_page.dart' as _i10;
import 'package:universal_boilerplate/pages/devices/devices_children_navigation_router.dart'
    as _i5;
import 'package:universal_boilerplate/pages/devices/devices_page.dart' as _i6;
import 'package:universal_boilerplate/pages/devices/single_device_page.dart'
    as _i11;
import 'package:universal_boilerplate/pages/home_page.dart' as _i7;
import 'package:universal_boilerplate/pages/info_page.dart' as _i8;

/// generated route for
/// [_i1.CpuTypeChildrenNavigationRouter]
class CpuTypeChildrenNavigationRouter
    extends _i12.PageRouteInfo<CpuTypeChildrenNavigationRouterArgs> {
  CpuTypeChildrenNavigationRouter({
    _i13.Key? key,
    required String cpuType,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         CpuTypeChildrenNavigationRouter.name,
         args: CpuTypeChildrenNavigationRouterArgs(key: key, cpuType: cpuType),
         rawPathParams: {'cpuType': cpuType},
         initialChildren: children,
       );

  static const String name = 'CpuTypeChildrenNavigationRouter';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CpuTypeChildrenNavigationRouterArgs>(
        orElse:
            () => CpuTypeChildrenNavigationRouterArgs(
              cpuType: pathParams.getString('cpuType'),
            ),
      );
      return _i1.CpuTypeChildrenNavigationRouter(
        key: args.key,
        cpuType: args.cpuType,
      );
    },
  );
}

class CpuTypeChildrenNavigationRouterArgs {
  const CpuTypeChildrenNavigationRouterArgs({this.key, required this.cpuType});

  final _i13.Key? key;

  final String cpuType;

  @override
  String toString() {
    return 'CpuTypeChildrenNavigationRouterArgs{key: $key, cpuType: $cpuType}';
  }
}

/// generated route for
/// [_i2.CpuTypeListPage]
class CpuTypeListRoute extends _i12.PageRouteInfo<CpuTypeListRouteArgs> {
  CpuTypeListRoute({
    _i13.Key? key,
    required String cpuType,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         CpuTypeListRoute.name,
         args: CpuTypeListRouteArgs(key: key, cpuType: cpuType),
         rawPathParams: {'cpuType': cpuType},
         initialChildren: children,
       );

  static const String name = 'CpuTypeListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CpuTypeListRouteArgs>(
        orElse:
            () =>
                CpuTypeListRouteArgs(cpuType: pathParams.getString('cpuType')),
      );
      return _i2.CpuTypeListPage(key: args.key, cpuType: args.cpuType);
    },
  );
}

class CpuTypeListRouteArgs {
  const CpuTypeListRouteArgs({this.key, required this.cpuType});

  final _i13.Key? key;

  final String cpuType;

  @override
  String toString() {
    return 'CpuTypeListRouteArgs{key: $key, cpuType: $cpuType}';
  }
}

/// generated route for
/// [_i3.CpusChildrenNavigationRouter]
class CpusChildrenNavigationRouter extends _i12.PageRouteInfo<void> {
  const CpusChildrenNavigationRouter({List<_i12.PageRouteInfo>? children})
    : super(CpusChildrenNavigationRouter.name, initialChildren: children);

  static const String name = 'CpusChildrenNavigationRouter';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.CpusChildrenNavigationRouter();
    },
  );
}

/// generated route for
/// [_i4.CpusPage]
class CpusRoute extends _i12.PageRouteInfo<void> {
  const CpusRoute({List<_i12.PageRouteInfo>? children})
    : super(CpusRoute.name, initialChildren: children);

  static const String name = 'CpusRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.CpusPage();
    },
  );
}

/// generated route for
/// [_i5.DevicesChildrenNavigationRouter]
class DevicesChildrenNavigationRouter extends _i12.PageRouteInfo<void> {
  const DevicesChildrenNavigationRouter({List<_i12.PageRouteInfo>? children})
    : super(DevicesChildrenNavigationRouter.name, initialChildren: children);

  static const String name = 'DevicesChildrenNavigationRouter';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.DevicesChildrenNavigationRouter();
    },
  );
}

/// generated route for
/// [_i6.DevicesPage]
class DevicesRoute extends _i12.PageRouteInfo<void> {
  const DevicesRoute({List<_i12.PageRouteInfo>? children})
    : super(DevicesRoute.name, initialChildren: children);

  static const String name = 'DevicesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.DevicesPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.InfoPage]
class InfoRoute extends _i12.PageRouteInfo<void> {
  const InfoRoute({List<_i12.PageRouteInfo>? children})
    : super(InfoRoute.name, initialChildren: children);

  static const String name = 'InfoRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.InfoPage();
    },
  );
}

/// generated route for
/// [_i9.LayoutNavigationWrapper]
class LayoutNavigationWrapper
    extends _i12.PageRouteInfo<LayoutNavigationWrapperArgs> {
  LayoutNavigationWrapper({_i13.Key? key, List<_i12.PageRouteInfo>? children})
    : super(
        LayoutNavigationWrapper.name,
        args: LayoutNavigationWrapperArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LayoutNavigationWrapper';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LayoutNavigationWrapperArgs>(
        orElse: () => const LayoutNavigationWrapperArgs(),
      );
      return _i9.LayoutNavigationWrapper(key: args.key);
    },
  );
}

class LayoutNavigationWrapperArgs {
  const LayoutNavigationWrapperArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'LayoutNavigationWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.SingleCpuPage]
class SingleCpuRoute extends _i12.PageRouteInfo<SingleCpuRouteArgs> {
  SingleCpuRoute({
    _i13.Key? key,
    required String cpuName,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         SingleCpuRoute.name,
         args: SingleCpuRouteArgs(key: key, cpuName: cpuName),
         rawPathParams: {'cpuName': cpuName},
         initialChildren: children,
       );

  static const String name = 'SingleCpuRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SingleCpuRouteArgs>(
        orElse:
            () => SingleCpuRouteArgs(cpuName: pathParams.getString('cpuName')),
      );
      return _i10.SingleCpuPage(key: args.key, cpuName: args.cpuName);
    },
  );
}

class SingleCpuRouteArgs {
  const SingleCpuRouteArgs({this.key, required this.cpuName});

  final _i13.Key? key;

  final String cpuName;

  @override
  String toString() {
    return 'SingleCpuRouteArgs{key: $key, cpuName: $cpuName}';
  }
}

/// generated route for
/// [_i11.SingleDevicePage]
class SingleDeviceRoute extends _i12.PageRouteInfo<SingleDeviceRouteArgs> {
  SingleDeviceRoute({
    _i13.Key? key,
    required String deviceId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         SingleDeviceRoute.name,
         args: SingleDeviceRouteArgs(key: key, deviceId: deviceId),
         rawPathParams: {'deviceId': deviceId},
         initialChildren: children,
       );

  static const String name = 'SingleDeviceRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SingleDeviceRouteArgs>(
        orElse:
            () => SingleDeviceRouteArgs(
              deviceId: pathParams.getString('deviceId'),
            ),
      );
      return _i11.SingleDevicePage(key: args.key, deviceId: args.deviceId);
    },
  );
}

class SingleDeviceRouteArgs {
  const SingleDeviceRouteArgs({this.key, required this.deviceId});

  final _i13.Key? key;

  final String deviceId;

  @override
  String toString() {
    return 'SingleDeviceRouteArgs{key: $key, deviceId: $deviceId}';
  }
}
