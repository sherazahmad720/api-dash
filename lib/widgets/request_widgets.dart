import 'package:flutter/material.dart';
import 'package:apidash/consts.dart';

class RequestPane extends StatefulWidget {
  const RequestPane({
    super.key,
    required this.activeId,
    required this.codePaneVisible,
    this.tabIndex,
    this.onPressedCodeButton,
    this.onTapTabBar,
    required this.children,
  });

  final String? activeId;
  final bool codePaneVisible;
  final int? tabIndex;
  final void Function()? onPressedCodeButton;
  final void Function(int)? onTapTabBar;
  final List<Widget> children;

  @override
  State<RequestPane> createState() => _RequestPaneState();
}

class _RequestPaneState extends State<RequestPane>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      animationDuration: kTabAnimationDuration,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex != null) {
      _controller.index = widget.tabIndex!;
    }
    return Column(
      children: [
        Padding(
          padding: kPh20v10,
          child: SizedBox(
            height: kHeaderHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FilledButton.tonalIcon(
                  onPressed: widget.onPressedCodeButton,
                  icon: Icon(
                    widget.codePaneVisible
                        ? Icons.code_off_rounded
                        : Icons.code_rounded,
                  ),
                  label: SizedBox(
                    width: 75,
                    child: Text(
                        widget.codePaneVisible ? "Hide Code" : "View Code"),
                  ),
                ),
              ],
            ),
          ),
        ),
        TabBar(
          key: Key(widget.activeId!),
          controller: _controller,
          overlayColor: kColorTransparentState,
          onTap: widget.onTapTabBar,
          tabs: const [
            SizedBox(
              height: kTabHeight,
              child: Center(
                child: Text(
                  'URL Params',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: kTextStyleButton,
                ),
              ),
            ),
            SizedBox(
              height: kTabHeight,
              child: Center(
                child: Text(
                  'Headers',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: kTextStyleButton,
                ),
              ),
            ),
            SizedBox(
              height: kTabHeight,
              child: Center(
                child: Text(
                  'Body',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: kTextStyleButton,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.children,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
