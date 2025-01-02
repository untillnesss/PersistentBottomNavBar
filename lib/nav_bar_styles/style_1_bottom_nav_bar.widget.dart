part of persistent_bottom_nav_bar;

class _BottomNavStyle1 extends StatelessWidget {
  const _BottomNavStyle1({
    required this.navBarEssentials,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: isSelected ? 230 : 50,
              height: height! / 1.6,
              duration: navBarEssentials.itemAnimationProperties.duration,
              curve: navBarEssentials.itemAnimationProperties.curve,
              padding: EdgeInsets.all(item.contentPadding),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffDCECCC)
                    : navBarEssentials.backgroundColor.withOpacity(0),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Container(
                alignment: Alignment.center,
                height: height / 1.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: item.title == null ? 0.0 : 8),
                        child: IconTheme(
                          data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? const Color(0xff50A000)
                                  : item.inactiveColorPrimary ??
                                      item.activeColorPrimary),
                          child: isSelected
                              ? item.icon
                              : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                    ),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      isSelected
                          ? Flexible(
                              child: Material(
                                type: MaterialType.transparency,
                                child: FittedBox(
                                    child: Text(
                                  item.title!,
                                  style: item.textStyle != null
                                      ? (item.textStyle!.apply(
                                          color: isSelected
                                              ? Colors.black
                                              : item.inactiveColorPrimary))
                                      : const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                )),
                              ),
                            )
                          : const SizedBox.shrink()
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) => Container(
      width: double.infinity,
      height: navBarEssentials.navBarHeight,
      padding: navBarEssentials.padding,
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
        children: navBarEssentials.items.map((final item) {
          final int index = navBarEssentials.items.indexOf(item);
          return Flexible(
            flex: navBarEssentials.selectedIndex == index ? 2 : 1,
            child: GestureDetector(
              onTap: () {
                if (index != navBarEssentials.selectedIndex) {
                  navBarEssentials.items[index].iconAnimationController
                      ?.forward();
                  navBarEssentials.items[navBarEssentials.selectedIndex]
                      .iconAnimationController
                      ?.reverse();
                }
                if (navBarEssentials.items[index].onPressed != null) {
                  navBarEssentials.items[index]
                      .onPressed!(navBarEssentials.selectedScreenBuildContext);
                } else {
                  navBarEssentials.onItemSelected?.call(index);
                }
              },
              child: _buildItem(item, navBarEssentials.selectedIndex == index,
                  navBarEssentials.navBarHeight),
            ),
          );
        }).toList(),
      ));
}
