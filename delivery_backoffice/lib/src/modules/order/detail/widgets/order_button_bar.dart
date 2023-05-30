import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dto/order/order_dto.dart';
import '../../../../models/orders/order_status.dart';
import '../../order_controller.dart';

class OrderButtonBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;

  const OrderButtonBar({
    Key? key,
    required this.controller,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OrderButtonBarButton(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10),
          ),
          buttonColor: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          buttonLabel: 'FINALIZAR',
          onPressed: order.status == OrderStatus.confirmado
              ? () => controller.changeStatus(OrderStatus.finalizado)
              : null,
        ),
        OrderButtonBarButton(
          borderRadius: BorderRadius.zero,
          buttonColor: Colors.green,
          image: 'assets/images/icons/confirm_order_white_icon.png',
          buttonLabel: 'CONFIRMAR',
          onPressed: order.status == OrderStatus.pendente
              ? () => controller.changeStatus(OrderStatus.confirmado)
              : null,
        ),
        OrderButtonBarButton(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(10),
          ),
          buttonColor: Colors.red,
          image: 'assets/images/icons/cancel_order_white_icon.png',
          buttonLabel: 'CANCELAR',
          onPressed: order.status != OrderStatus.cancelado &&
                  order.status != OrderStatus.finalizado
              ? () => controller.changeStatus(OrderStatus.cancelado)
              : null,
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
  final VoidCallback? onPressed;

  const OrderButtonBarButton({
    Key? key,
    required this.borderRadius,
    required this.buttonColor,
    required this.image,
    required this.buttonLabel,
    required this.onPressed,
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
            side: onPressed != null ? BorderSide(color: buttonColor) : null,
            backgroundColor: buttonColor,
          ),
          onPressed: onPressed,
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
