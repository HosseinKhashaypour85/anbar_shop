import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three/number_to_three.dart';
import '../../public_features/widget/empty_screen_widget.dart';
import '../../public_features/widget/snack_bar_widget.dart';
import '../logic/cart_bloc.dart';
import '../model/show_cart_model.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList(
      {super.key, required this.showCartModel, required this.totalPrice});

  final ShowCartModel showCartModel;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final items = showCartModel.items ?? [];

    if (items.isEmpty) {
      return EmptyWidget(
        title: 'سبد خرید شما خالی است',
      );
    }

    return Row(
      children: [
        Container(
          width: getAllWidth(context),
          height: getHeight(context, 0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      item.image!,
                      height: getAllHeight(context),
                    ),
                    title: Text(
                      item.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sahel',
                      ),
                    ),
                    subtitle: Text(
                      item.price.toString() + '\$',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'sahel',
                      ),
                    ),
                    trailing: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CallDeleteProduct(id: item.id!),
                        );
                        getSnackBarWidget(
                            context, 'محصول از سبد خرید حذف شد', Colors.green);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
