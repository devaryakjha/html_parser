import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter_example/utils/blog_styles.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    super.key,
    required this.input,
    required this.title,
  });

  final String input;

  final String title;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        surfaceTintColor: Colors.black,
        scrolledUnderElevation: 10,
      ),
      body: Html(
        widget.input,
        config: HtmlConfig(
          styles: const BlogStyles(),
          onLinkTap: (href) {
            if (href != null) {
              final uri = Uri.tryParse(href);
              if (uri != null) {
                url_launcher.canLaunchUrl(uri).then((canLaunch) {
                  if (canLaunch) {
                    url_launcher.launchUrl(uri);
                  } else {
                    log('Could not launch $href');
                  }
                });
              }
            }
            log('Tapped on anchor: $href');
          },
        ),
      ),
    );
  }
}
