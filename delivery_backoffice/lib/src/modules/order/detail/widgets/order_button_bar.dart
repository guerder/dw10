import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';

class OrderButtonBar extends StatelessWidget {
  const OrderButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        OrderButtonBarButton(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
          buttonColor: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          buttonLabel: 'FINALIZAR',
        ),
        OrderButtonBarButton(
          borderRadius: BorderRadius.zero,
          buttonColor: Colors.green,
          image: 'assets/images/icons/confirm_order_white_icon.png',
          buttonLabel: 'CONFIRMAR',
        ),
        OrderButtonBarButton(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
          buttonColor: Colors.red,
          image: 'assets/images/icons/cancel_order_white_icon.png',
          buttonLabel: 'CANCELAR',
        ),
      ],
    );
  }
}

class OrderButtonBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttonColor;
  final String image;
  final String buttonLabel;

  const OrderButtonBarButton({
    Key? key,
    required this.borderRadius,
    required this.buttonColor,
    required this.image,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(color: buttonColor),
            backgroundColor: buttonColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(width: 5),
              Text(
                buttonLabel,
                style: context.textStyles.textBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
