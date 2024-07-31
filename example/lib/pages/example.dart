import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
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
  final List<String> _cssInput = [];

  void _loadStyleSheet() async {
    final response = await Future.wait([
      Dio()
          .get(
              'https://zerodha.com/z-connect/wp-includes/css/dist/block-library/style.min.css?ver=6.4.5')
          .then((res) => res.data),
      Dio()
          .get(
              'https://zerodha.com/z-connect/wp-content/themes/zconnect2/style.css?v=1.55')
          .then((res) => res.data),
    ]);
    _cssInput.addAll(response.map((a) => a as String));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadStyleSheet();
  }

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
          styles: _cssInput.isEmpty
              ? const BlogStyles()
              : BlogStyles.fromCss(_cssInput),
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
