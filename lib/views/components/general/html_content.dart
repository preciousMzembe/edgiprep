import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class HtmlContent extends StatelessWidget {
  final String htmlContent;
  final TextStyle? textStyle;

  const HtmlContent({
    super.key,
    required this.htmlContent,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final parsed = html_parser.parse(htmlContent);
    final body = parsed.body;

    if (body == null) return const SizedBox();

    final defaultStyle = textStyle ??
        GoogleFonts.inter(
          fontSize: 16,
          color: const Color.fromRGBO(52, 74, 106, 1),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _parseBlockLevel(body, defaultStyle),
    );
  }

  List<Widget> _parseBlockLevel(dom.Node node, TextStyle style) {
    final List<Widget> blocks = [];

    for (var child in node.nodes) {
      if (child.nodeType == dom.Node.TEXT_NODE) {
        final text = child.text?.trim();
        if (text != null && text.isNotEmpty) {
          blocks.add(RichText(
            text: TextSpan(text: text, style: style),
          ));
        }
      } else if (child.nodeType == dom.Node.ELEMENT_NODE) {
        final element = child as dom.Element;

        switch (element.localName) {
          case 'p':
            blocks.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: RichText(
                  text: TextSpan(
                    style: style,
                    children: _buildInlineSpans(element, style),
                  ),
                ),
              ),
            );
            break;

          case 'ul':
            blocks.add(
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: element.children
                      .where((li) => li.localName == 'li')
                      .map((li) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• "),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: style,
                                    children: _buildInlineSpans(li, style),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
            break;

          case 'ol':
            int count = 1;
            blocks.add(
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: element.children
                      .where((li) => li.localName == 'li')
                      .map((li) {
                    final widget = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$count. "),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: style,
                              children: _buildInlineSpans(li, style),
                            ),
                          ),
                        ),
                      ],
                    );
                    count++;
                    return widget;
                  }).toList(),
                ),
              ),
            );
            break;

          default:
            // For span, strong, em etc inside divs or unknown tags
            blocks.add(RichText(
              text: TextSpan(
                style: style,
                children: _buildInlineSpans(element, style),
              ),
            ));
            break;
        }
      }
    }

    return blocks;
  }

  List<InlineSpan> _buildInlineSpans(dom.Node node, TextStyle style) {
    final List<InlineSpan> spans = [];

    for (var child in node.nodes) {
      if (child.nodeType == dom.Node.TEXT_NODE) {
        final text = child.text;
        if (text != null && text.isNotEmpty) {
          spans.add(TextSpan(text: text, style: style));
        }
      } else if (child.nodeType == dom.Node.ELEMENT_NODE) {
        final element = child as dom.Element;

        if (element.localName == 'span' &&
            element.classes.contains('ql-formula')) {
          final latex = element.attributes['data-value'] ?? '';
          spans.add(WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Math.tex(
              latex,
              mathStyle: MathStyle.text,
              textStyle: style,
            ),
          ));
        } else if (element.localName == 'b' || element.localName == 'strong') {
          spans.addAll(_buildInlineSpans(
            element,
            style.merge(const TextStyle(fontWeight: FontWeight.bold)),
          ));
        } else if (element.localName == 'i' || element.localName == 'em') {
          spans.addAll(_buildInlineSpans(
            element,
            style.merge(const TextStyle(fontStyle: FontStyle.italic)),
          ));
        } else if (element.localName == 'u') {
          spans.addAll(_buildInlineSpans(
            element,
            style.merge(
              const TextStyle(decoration: TextDecoration.underline),
            ),
          ));
        } else if (element.localName == 'br') {
          spans.add(const TextSpan(text: '\n'));
        } else if (element.localName == 'sub') {
          spans.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: const Offset(0, 4), // shift down
              child: Text(
                element.text,
                style: style.merge(const TextStyle(fontSize: 12)),
              ),
            ),
          ));
        } else {
          spans.addAll(_buildInlineSpans(element, style));
        }
      }
    }

    return spans;
  }
}
