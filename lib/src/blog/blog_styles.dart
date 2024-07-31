import 'package:collection/collection.dart';
import 'package:csslib/parser.dart' as css;
import 'package:csslib/visitor.dart' as visitor;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogStyles implements IHtmlStyles {
  const BlogStyles({
    this.cssStyles,
  });

  static Map<String, dynamic> _getStylesOfSelectors(
    List<String> selectors,
    Iterable<visitor.StyleSheet?>? styleSheets,
  ) {
    final Map<String, dynamic> styles = {}; // Results (styles).

    if (styleSheets == null || styleSheets.isEmpty) return styles;

    // Collect the rules of the specified selectors from [styleSheets].
    for (visitor.StyleSheet styleSheet in styleSheets.whereNotNull()) {
      final List<visitor.RuleSet> rules = styleSheet.topLevels
          .whereType<visitor.RuleSet>()
          .where((visitor.RuleSet ruleSet) {
        if (ruleSet.selectorGroup == null) return false;
        return (ruleSet.selectorGroup!.selectors.where(
          (visitor.Selector selector) {
            return (selector.simpleSelectorSequences.where(
              (visitor.SimpleSelectorSequence simpleSelectorSequence) {
                return selectors
                    .contains(simpleSelectorSequence.simpleSelector.name);
              },
            ).isNotEmpty);
          },
        ).isNotEmpty);
      }).toList();

      // Collect all the styles of the specified selectors.
      for (final visitor.RuleSet rule in rules) {
        for (final visitor.TreeNode node
            in rule.declarationGroup.declarations) {
          final visitor.Declaration declaration = (node as visitor.Declaration);
          final String value =
              (declaration.expression as visitor.Expressions).expressions.fold(
            '',
            (String value, visitor.Expression expression) {
              final text =
                  expression is visitor.LiteralTerm ? expression.text : '';

              return (value + text);
            },
          );
          styles.addAll({
            declaration.property: value,
          });
        }
      }
    }

    return styles;
  }

  factory BlogStyles.fromCss(List<dynamic> inputs) {
    if (inputs.isEmpty) return const BlogStyles();
    final styleSheets = inputs.whereType<String>().map((input) {
      return css.compile(
        input,
        options: const css.PreprocessorOptions(
          useColors: false,
          checked: true,
          warningsAsErrors: true,
          inputFile: 'memory',
        ),
      );
    }).toList();

    Map<String, Map<String, dynamic>> cssStyles = {};

    try {
      for (final tag in [
        'p',
        'a',
        'em',
        'i',
        'b',
        'strong',
        'h2',
        'hr',
      ]) {
        cssStyles.addAll({
          tag: _getStylesOfSelectors([tag], styleSheets),
        });
      }
    } catch (e) {
      //
    }

    return BlogStyles(cssStyles: cssStyles);
  }

  final Map<String, Map<String, dynamic>>? cssStyles;

  static const String defaultFontFamily = 'Inter';

  @override
  Styles? getStyle(String? tag, dom.Node node) {
    final fontFamily = cssStyles?[tag]?['font-family'] ?? defaultFontFamily;
    final defaultTextStyle = GoogleFonts.getFont(fontFamily);
    return switch (tag) {
      'p' => Styles(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          textStyle: defaultTextStyle.copyWith(fontSize: 16),
        ),
      'a' => Styles(
          textStyle: defaultTextStyle.copyWith(
            decoration: TextDecoration.underline,
            color: const Color(0xff1669c9),
            decorationColor: const Color(0xff1669c9),
          ),
        ),
      'em' || 'i' => Styles(
          textStyle: defaultTextStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      'b' || 'strong' => Styles(
          textStyle: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      'h2' => Styles(
          margin: const EdgeInsets.only(top: 30),
          textStyle: defaultTextStyle.copyWith(fontSize: 27.2),
        ),
      'hr' => const Styles(),
      _ => Styles(
          textStyle: defaultTextStyle.copyWith(fontSize: 16),
        ),
    };
  }

  @override
  List<Object?> get props => [styles];

  @override
  bool? get stringify => true;

  @override
  StylesMap get styles => const {};
}
