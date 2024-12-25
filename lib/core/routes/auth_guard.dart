import 'package:auto_route/auto_route.dart';
import 'app_router.dart';
import '../../features/auth/domain/usecases/is_auth_use_case.dart';
import '../../injection_container.dart' as ic;

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final isAuth = await ic.sl<IsAuthUseCase>().call();

    isAuth.fold(
      (_) => resolver.next(true),
      (r) {
        if (r) {
          router.pushAndPopUntil(
            const AppRoute(),
            predicate: (_) => false,
          );
        } else {
          resolver.next(true);
        }
      },
    );
  }
}
