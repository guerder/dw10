import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import 'menu_enum.dart';

class MenuButton extends StatelessWidget {
  final Menu menu;
  final bool isSelected;
  final ValueChanged<Menu> onPressed;

  const MenuButton({
    Key? key,
    required this.menu,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Visibility(
          visible: constraints.maxWidth != 90,
          replacement: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFFF5E2),
                  )
                : null,
            child: IconButton(
              tooltip: menu.label,
              onPressed: () => onPressed(menu),
              icon: Image.asset(
                'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onPressed(menu),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFF5E2),
                      )
                    : null,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        menu.label,
                        overflow: TextOverflow.ellipsis,
                        style: isSelected
                            ? context.textStyles.textBold
                            : context.textStyles.textRegular,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
