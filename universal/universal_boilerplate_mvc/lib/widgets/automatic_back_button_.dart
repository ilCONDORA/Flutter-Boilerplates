import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/pop_route/pop_route_cubit.dart';

class AutomaticBackButton extends StatelessWidget {
  const AutomaticBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopRouteCubit, bool>(
      builder: (context, canPop) {
        return Visibility(
          visible: canPop,
          child: BackButton(onPressed: () => GoRouter.of(context).pop()),
        );
      },
    );
  }
}
