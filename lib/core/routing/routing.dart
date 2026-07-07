import 'package:go_router/go_router.dart';
import 'package:partfolio_app/core/routing/route_constants.dart';

final class AppRouting {
  GoRouter goRoute = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteConstants.loader,
        //
      ),
      GoRoute(
        path: '/login',
        name: RouteConstants.loader,
        //
      ),
      GoRoute(
        path: '/register',
        name: RouteConstants.loader,
        //
      ),
      GoRoute(
        path: '/homeScreen',
        name: RouteConstants.loader,
        //
      ),
    ],
  );
}
