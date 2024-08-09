import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// The `HtmlExtension` class is the base class for all extensions.
///
/// Extensions are used to add custom functionality to the `Html` widget.
/// They can be used to add support for new tags, attributes, and more.
@immutable
abstract class HtmlExtension {
  /// Creates a new instance of [HtmlExtension].
  const HtmlExtension();

  /// The set of supported tags.
  Set<String> get supportedTags;

  /// Returns `true` if the node is supported
  bool isNodeSupported(Node node) =>
      node is HTMLElement && isElementSupported(node);

  /// Returns `true` if the element is supported
  bool isElementSupported(HTMLElement element) =>
      isTagSupported(element.localName);

  /// Returns `true` if the tag is supported
  bool isTagSupported(String? tag) => supportedTags.contains(tag);

  /// Parses an [Node] and
  /// If supported returns [ParsedResult]
  /// else return [Null].
  ParsedResult? parseNode(Node node, HtmlConfig config);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlExtension &&
          runtimeType == other.runtimeType &&
          supportedTags == other.supportedTags;

  @override
  int get hashCode => Object.hashAll([supportedTags]);

  @override
  String toString() => '$runtimeType($supportedTags)';

  ///
  @internal
  static Widget createPlaceholderWidget(String tag) => const Text(
        'Unsupported Tag: figure',
        style: TextStyle(
          color: Colors.red,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
}
