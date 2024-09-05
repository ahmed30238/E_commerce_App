import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/extensions/widget_extension.dart';
import 'package:e_commerce_app/presentation/controller/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/presentation/controller/cart_cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    CartCubit.get(context).getCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = CartCubit.get(context);
    var item = cubit.getCartEntity?.data.cartItems;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) => state is GetCartSuccessState && item!=null
                ? SizedBox(
                    height: 600,
                    child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    item[index].product.image))),
                        child: Text(
                          "${cubit.getCartEntity?.data.cartItems[0].product.name}",
                        ),
                      ),
                      separatorBuilder: (context, index) => 10.ph,
                      itemCount: cubit.getCartEntity!.data.cartItems.length,
                    ),
                  )
                : const CircularProgressIndicator().center(),
          ),
          // ...{
          //   for (int i = 0;
          //       i < cubit.getCartEntity!.data.cartItems.length;
          //       i++) ...{
          //     Text("${cubit.getCartEntity!.data.cartItems[i].product.price}"),
          //   }
          // },
          // Text("${cubit.getCartEntity!.data.total}"),
        ],
      ),
    );
  }
}
