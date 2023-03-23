import 'package:animations/animations.dart';
import 'package:danny/widgets/dialogs/confirmation.dart';
import 'package:flutter/material.dart';

class BottomNavigationDotBar extends StatefulWidget {
  const BottomNavigationDotBar({
    required this.items,
    this.activeColor,
    this.color,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final List<BottomNavigationDotBarItem> items;
  final Color? activeColor;
  final Color? color;
  final ValueChanged<int> onSelect;

  @override
  State<StatefulWidget> createState() => _BottomNavigationDotBarState();
}

class _BottomNavigationDotBarState extends State<BottomNavigationDotBar> {
  final _keyBottomBar = GlobalKey();
  double _numPositionBase = 0;
  double _numDifferenceBase = 0;
  double _positionLeftIndicatorDot = 0;
  int _indexPageSelected = 0;
  late Color _color;
  late Color _activeColor;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(Duration _) {
    final sizeBottomBar =
        (_keyBottomBar.currentContext!.findRenderObject() as RenderBox?)
                ?.size ??
            Size.zero;
    _numPositionBase = sizeBottomBar.width / widget.items.length;
    _numDifferenceBase = _numPositionBase - (_numPositionBase / 2) + 2;
    setState(() {
      _positionLeftIndicatorDot = _numPositionBase - _numDifferenceBase;
    });
  }

  @override
  Widget build(BuildContext context) {
    _color = widget.color ?? Theme.of(context).primaryColor.withOpacity(0.25);
    _activeColor = widget.activeColor ?? Theme.of(context).primaryColor;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            key: _keyBottomBar,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _createNavigationIconButtonList(widget.items.asMap()),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                left: _positionLeftIndicatorDot,
                bottom: 13,
                child: CircleAvatar(radius: 2.5, backgroundColor: _activeColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_indexPageSelected == 0) {
      return (await showGeneralDialog<bool>(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Confirmation(
              title: 'Exit App',
              text: 'Are you sure you want to exit the App?',
            ),
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 300),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeScaleTransition(animation: animation, child: child);
            },
          )) ??
          false;
    }

    widget.onSelect(0);
    changeOptionBottomBar(0);

    return false;
  }

  List<_NavigationIconButton> _createNavigationIconButtonList(
    Map<int, BottomNavigationDotBarItem> mapItem,
  ) {
    final children = <_NavigationIconButton>[];
    mapItem.forEach(
      (index, item) => children.add(
        _NavigationIconButton(
          item.icon,
          (index == _indexPageSelected) ? _activeColor : _color,
          item.onTap,
          () => changeOptionBottomBar(index),
        ),
      ),
    );
    return children;
  }

  void changeOptionBottomBar(int indexPageSelected) {
    if (indexPageSelected != _indexPageSelected) {
      setState(() {
        _positionLeftIndicatorDot =
            (_numPositionBase * (indexPageSelected + 1)) - _numDifferenceBase;
      });
      _indexPageSelected = indexPageSelected;
    }
  }
}

class BottomNavigationDotBarItem {
  const BottomNavigationDotBarItem({required this.icon, required this.onTap});

  final IconData icon;
  final NavigationIconButtonTapCallback onTap;
}

typedef NavigationIconButtonTapCallback = void Function();

class _NavigationIconButton extends StatefulWidget {
  const _NavigationIconButton(
    this._icon,
    this._colorIcon,
    this._onTapInternalButton,
    this._onTapExternalButton, {
    Key? key,
  }) : super(key: key);

  final IconData _icon;
  final Color _colorIcon;
  final NavigationIconButtonTapCallback _onTapInternalButton;
  final NavigationIconButtonTapCallback _onTapExternalButton;

  @override
  _NavigationIconButtonState createState() => _NavigationIconButtonState();
}

class _NavigationIconButtonState extends State<_NavigationIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _opacityIcon = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.93).animate(_controller);
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTapDown: (_) {
            _controller.forward();
            setState(() {
              _opacityIcon = 0.7;
            });
          },
          onTapUp: (_) {
            _controller.reverse();
            setState(() {
              _opacityIcon = 1;
            });
          },
          onTapCancel: () {
            _controller.reverse();
            setState(() {
              _opacityIcon = 1;
            });
          },
          onTap: () {
            widget._onTapInternalButton();
            widget._onTapExternalButton();
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedOpacity(
              opacity: _opacityIcon,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 24),
                child: Icon(
                  widget._icon,
                  color: widget._colorIcon,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      );
}
