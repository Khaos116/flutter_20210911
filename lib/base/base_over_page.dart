import 'package:flutter/cupertino.dart';
import 'package:flutter_20210911/base/base_state_page.dart';

class OverPage extends BaseWidgetStateful {
  const OverPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _OverPage();
}

class _OverPage extends BaseStatefulState<OverPage> {
  @override
  Widget initPage(BuildContext context) {
    final Overlay overlay = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(
          builder: (BuildContext ctx) {
            return widget.child;
          },
        ),
      ],
    );

    final Widget w = Directionality(
      child: overlay,
      textDirection: TextDirection.ltr,
    );
    return _InheritedWidget(child: w);
  }
}

class _InheritedWidget extends InheritedWidget {
  const _InheritedWidget({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
