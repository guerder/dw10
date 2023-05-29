import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/orders/order_model.dart';
import '../order_controller.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return InkWell(
      onTap: () {
        context.read<OrderController>().showDetailModal(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Text('Pedido ', style: textStyles.textBold),
                  Text('${order.id}', style: textStyles.textExtraBold),
                  Expanded(
                    child: Text(
                      order.status.name,
                      style: textStyles.textExtraBold.copyWith(
                        fontSize: 20,
                        color: order.status.color,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(height: double.infinity, width: 5),
                ],
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, color: Colors.grey)
        ],
      ),
    );
  }
}
