import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HtmlShowcase extends StatelessWidget {
  const HtmlShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Html to Flutter Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                context.push('/example/basic');
              },
              child: const Text('Basic Example'),
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: () {
                context.push('/example/advanced');
              },
              child: const Text('Advanced Example'),
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: () {
                context.push('/example/blog-post');
              },
              child: const Text('Blog Post Example'),
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: () {
                context.push('/example/custom');
              },
              child: const Text('Custom Example'),
            ),
          ],
        ),
      ),
    );
  }
}
