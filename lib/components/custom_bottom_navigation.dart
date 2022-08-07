import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({
    Key? key,
    required this.itemIcons,
    this.selectedItem = 0,
    this.onSelect,
  }) : super(key: key);

  final List<Icon> itemIcons;
  final int selectedItem;
  final ValueChanged<int>? onSelect;

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemStates>(
      create: (BuildContext context) => ItemStates(widget.itemIcons.length),
      builder: (builder, child) => Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            for (int i = 0; i < widget.itemIcons.length; i++)
              Consumer<ItemStates>(
                builder: (__, value, _) => ItemButton(
                  selected: i == widget.selectedItem,
                  icon: widget.itemIcons[i],
                  index: i,
                  onSelect: widget.onSelect,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ItemButton extends StatefulWidget {
  final bool selected;
  final Icon icon;
  final int index;
  final ValueChanged<int>? onSelect;

  const ItemButton({
    Key? key,
    required this.selected,
    required this.icon,
    required this.index,
    this.onSelect,
  }) : super(key: key);

  @override
  State<ItemButton> createState() => _ItemButtonState();
}

class _ItemButtonState extends State<ItemButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemStates>(
      builder: (BuildContext context, value, Widget? child) => Expanded(
        child: GestureDetector(
          onTap: () {
            value.selects(widget.index);
            if(widget.onSelect != null) {
              widget.onSelect!(widget.index);
            }
          },
          child: AnimatedContainer(
            alignment: Alignment.center,
            margin: EdgeInsets.all(value.bABItemsPadding[widget.index]),
            constraints: BoxConstraints(maxWidth: 20),
            curve: Curves.bounceIn,
            padding: EdgeInsets.all(value.bABItemsPadding[widget.index]),
            decoration: BoxDecoration(
              color: widget.selected
                  ? Theme.of(context).colorScheme.primary
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(milliseconds: 200),
            child: IconTheme(data: IconThemeData(
              color: widget.selected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary
            ),
            child: widget.icon),
          ),
        ),
      ),
    );
  }
}

class ItemStates with ChangeNotifier {
  int selectedIndex = 0;
  List<double> bABItemsPadding = [];

  ItemStates(int noOfItems) {
    bABItemsPadding.add(8);
    for (int i = 1; i < noOfItems; i++) {
      bABItemsPadding.add(0);
    }
  }

  selects(int selectedIndex) {
    bABItemsPadding[this.selectedIndex] = 0;
    this.selectedIndex = selectedIndex;
    bABItemsPadding[this.selectedIndex] = 8;
    notifyListeners();
  }
}
