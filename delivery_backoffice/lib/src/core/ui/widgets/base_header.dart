import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttonLabel;
  final VoidCallback? buttonPressed;
  final bool addButton;
  final Widget? filterWidget;

  const BaseHeader({
    Key? key,
    required this.title,
    this.searchChange,
    this.buttonLabel = '',
    this.buttonPressed,
    this.addButton = true,
    this.filterWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          children: [
            Visibility(
              visible: filterWidget == null,
              replacement: filterWidget ?? const SizedBox.shrink(),
              child: SizedBox(
                width: constraints.maxWidth * .15,
                child: TextFormField(
                  onChanged: searchChange,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search,
                      size: constraints.maxWidth * .02,
                    ),
                    label: Text(
                      'Buscar',
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: constraints.maxWidth * .65,
              child: Text(
                title,
                style: context.textStyles.textTitle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: addButton,
              child: SizedBox(
                width: constraints.maxWidth * .15,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: buttonPressed,
                  icon: Icon(
                    Icons.add,
                    size: constraints.maxWidth * .02,
                  ),
                  label: Text(buttonLabel),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
