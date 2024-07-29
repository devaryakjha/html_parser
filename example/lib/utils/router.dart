import 'package:go_router/go_router.dart';
import 'package:html_to_flutter_example/lib.dart';

/// The global router instance.
final router = GoRouter(initialLocation: '/showcase', routes: [
  GoRoute(
    path: '/showcase',
    builder: (context, state) => const HtmlShowcase(),
  )
]);
