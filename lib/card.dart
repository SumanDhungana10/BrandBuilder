import 'package:card/email.dart';
import 'package:card/external.dart';
import 'package:card/giveaway.dart';
import 'package:flutter/material.dart';

class CardOne extends StatelessWidget {
  const CardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Giveaway(
            template: "Offers and Deals",
            title: 'Savor & Save: Enjoy 20% Off Your Next Culinary Adventure!',
            description:
                'Enter our exclusive giveaway for a chance to win amazing prizes! Simply follow the rules, participate, and you could be the lucky winner. Don’t miss out—join now and good luck!',
            // image:
            //     'https://png.pngtree.com/png-vector/20211027/ourmid/pngtree-it-s-time-for-a-giveaway-banner-png-image_4011203.png',
            // timestamp: '2024-09-3 13:59:59',
            isTepmlate1: false,
          ),
          Email(
            template: "Offers and Deals",
            title: 'Savor & Save: Enjoy 20% Off Your Next Culinary Adventure!',
            description:
                'Enter our exclusive giveaway for a chance to win amazing prizes! Simply follow the rules, participate, and you could be the lucky winner. Don’t miss out—join now and good luck!',
            // image:
            //     'https://png.pngtree.com/png-vector/20211027/ourmid/pngtree-it-s-time-for-a-giveaway-banner-png-image_4011203.png',
            isTepmlate1: false,
          ),
          External(
            template: "Offers and Deals",
            title: 'Savor & Save: Enjoy 20% Off Your Next Culinary Adventure!',
            description:
                'Enter our exclusive giveaway for a chance to win amazing prizes! Simply follow the rules, participate, and you could be the lucky winner. Don’t miss out—join now and good luck!',
            image:
                'https://png.pngtree.com/png-vector/20211027/ourmid/pngtree-it-s-time-for-a-giveaway-banner-png-image_4011203.png',
            isTepmlate1: false,
            // triangleColor: Color(0xFFA1D312),
          )
        ],
      ),
    ));
  }
}
