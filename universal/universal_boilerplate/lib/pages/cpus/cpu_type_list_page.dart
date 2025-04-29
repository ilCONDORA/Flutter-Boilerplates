import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../routes/router.gr.dart';

@RoutePage()
class CpuTypeListPage extends StatelessWidget {
  const CpuTypeListPage({super.key, @PathParam() required this.cpuType});
  final String cpuType;

  List<Map<String, dynamic>> _getCpuList() {
    switch (cpuType) {
      case 'desktop':
        return [
          {
            'id': 'intel-i9-13900k',
            'name': 'Intel Core i9-13900K',
          },
          {
            'id': 'amd-ryzen-9-7950x',
            'name': 'AMD Ryzen 9 7950X',
          },
          {
            'id': 'intel-i7-13700k',
            'name': 'Intel Core i7-13700K',
          },
        ];
      case 'laptop':
        return [
          {
            'id': 'intel-i9-13980hx',
            'name': 'Intel Core i9-13980HX',
          },
          {
            'id': 'amd-ryzen-9-7945hx',
            'name': 'AMD Ryzen 9 7945HX',
          },
          {
            'id': 'apple-m2-pro',
            'name': 'Apple M2 Pro',
          },
        ];
      case 'mobile':
        return [
          {
            'id': 'snapdragon-8-gen-3',
            'name': 'Qualcomm Snapdragon 8 Gen 3',
          },
          {
            'id': 'exynos-2400',
            'name': 'Samsung Exynos 2400',
          },
          {
            'id': 'mediatek-dimensity-9300',
            'name': 'MediaTek Dimensity 9300',
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final cpuList = _getCpuList();

    return Scaffold(
      body: cpuList.isEmpty
          ? Center(
              child: Text(
                'Nessuna CPU trovata per il tipo: ${toBeginningOfSentenceCase(cpuType)}',
              ),
            )
          : ListView.builder(
              itemCount: cpuList.length,
              itemBuilder: (context, index) {
                final cpu = cpuList[index];
                return ListTile(
                  title: Text(cpu['name']),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigazione alla CPU specifica
                    context.router.push(SingleCpuRoute(cpuName: cpu['id']));
                  },
                );
              },
            ),
    );
  }
}
