import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widgets_from_html/widgets_from_html.dart';
import 'package:widgets_from_html_example/utils/blog_styles.dart';
import 'package:widgets_from_html_example/widgets/custom_image.dart';
import 'package:widgets_from_html_example/widgets/iframe.dart';

final class BlogConfig extends HtmlConfig {
  BlogConfig()
      : super(
          customFactories: _createCustomFactories(),
        );

  static WidgetFactoryMap _createCustomFactories() {
    return {
      'img': (node, _) => CustomImageFactory.fromNode(node),
      'iframe': (node, _) => IframeHtmlWidgetFactory.fromNode(node),
    };
  }

  @override
  TextStyle get defaultTextStyle {
    return const TextStyle(
      fontSize: 16,
      height: 1.4,
      color: Color(0xFF444444),
      fontWeight: FontWeight.normal,
    );
  }

  @override
  OnLinkTap? get onLinkTap => (href) {
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
      };
  @override
  IHtmlStyles get styles => const BlogStyles();
}
