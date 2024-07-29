import 'package:go_router/go_router.dart';
import 'package:html_to_flutter_example/lib.dart';

/// The global router instance.
final router = GoRouter(initialLocation: '/showcase', routes: [
  GoRoute(
    path: '/showcase',
    builder: (context, state) => const HtmlShowcase(),
  ),
  GoRoute(
    path: '/example/:type',
    builder: (context, state) {
      final type = state.pathParameters['type']!;
      return ExamplePage(
        title: {
              'basic': 'Basic Example',
              'advanced': 'Advanced Example',
              'blog-post': 'Blog Post Example',
              'custom': 'Custom Example',
            }[type] ??
            'Example',
        input: HtmlInputs.typeToInput[type] ?? '<p>Invalid input</p>',
      );
    },
  ),
]);
