import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogStyles implements IHtmlStyles {
  @override
  Styles? getStyle(String? tag) => switch (tag) {
        'p' => const Styles(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            textStyle: TextStyle(fontSize: 16),
          ),
        'a' => const Styles(
            textStyle: TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0xff1669c9),
              decorationColor: Color(0xff1669c9),
            ),
          ),
        'em' || 'i' => const Styles(
            textStyle: TextStyle(fontStyle: FontStyle.italic),
          ),
        'b' || 'strong' => const Styles(
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        'h2' => const Styles(
            textStyle: TextStyle(fontSize: 27.2),
          ),
        _ => const Styles(
            textStyle: TextStyle(fontSize: 16),
          ),
      };

  @override
  List<Object?> get props => [styles];

  @override
  bool? get stringify => true;

  @override
  StylesMap get styles => const {};
}
