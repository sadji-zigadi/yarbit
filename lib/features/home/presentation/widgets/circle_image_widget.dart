import 'package:auto_route/auto_route.dart';
import 'package:client/core/routes/app_router.dart';

import '../../../auth/presentation/controller/profile_info/profile_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CircleImage extends StatefulWidget {
  const CircleImage({super.key});

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileInfoCubit>().getProfileInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
            AccountSettingsRoute(cubit: context.read<ProfileInfoCubit>()));
      },
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoSuccess) {
            return Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(state.user.pictureUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
            );
          }
        },
      ),
    );
  }
}
