import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ExamplePage extends StatelessWidget {
  const ExamplePage({
    super.key,
    required this.input,
    required this.title,
  });

  final String input;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        surfaceTintColor: Colors.black,
        scrolledUnderElevation: 10,
      ),
      body: Html(
        input,
        config: HtmlConfig(
          styles: BlogStyles(),
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
