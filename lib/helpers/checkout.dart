import 'package:bkash_payment_gateway/helpers/payment_helper.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? selected;

  List<Map> gateways = [
    {
      'name': 'bKash',
      'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0TtlhLx9Kiis00qZMMz5gJfVhjkWS-0HjRQ&s',
    },
    {
      'name': 'Amar Pay',
      'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShWw_R4GbinupFzdIcsYL7l2SNTSeY0UCf0w&s',
    },
    {
      'name': 'surjo',
      'logo': 'https://shurjomukhi.com.bd/images/shurjoPay-Logo-01.png',
    },
    {
      'name': 'email',
      'logo': 'https://w7.pngwing.com/pngs/4/365/png-transparent-computer-icons-email-email-miscellaneous-trademark-logo-thumbnail.png',
    },
    {
      'name': 'coding',
      'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSGwI0o5UsPXuRWfwbTd8EGaQJdYtUWm4Cg&s',
    },
    {
      'name': 'location',
      'logo': 'https://static-00.iconduck.com/assets.00/geolocation-icon-2048x2048-901a1d8m.png',
    },
    {
      'name': 'local_auth',
      'logo': 'https://cdn-icons-png.flaticon.com/512/13435/13435294.png',
    },
    {
      'name': '3d',
      'logo': 'https://static.vecteezy.com/system/resources/previews/026/703/115/non_2x/illustration-of-3d-icon-in-dark-color-and-white-background-vector.jpg',

    },
    {
      'name': 'pdf',
      'logo': 'https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/22/c3/28/22c328ae-aa86-56e3-bf92-f2f62fdace6e/ReleaseAppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/1200x630wa.png',

    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: false,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Select a payment method',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      return PaymentMethodTile(
                        logo: gateways[index]['logo'],
                        name: gateways[index]['name'],
                        selected: selected ?? '',
                        onTap: () {
                          selected = gateways[index]['name']; // Matches exact name
                          setState(() {});
                        },
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(height: 10),
                    itemCount: gateways.length,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: selected == null ? null : () => onButtonTap(selected ?? ''),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selected == null
                      ? Colors.blueAccent.withOpacity(.5)
                      : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Continue to payment',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PaymentMethodTile extends StatelessWidget {
  final String logo;
  final String name;
  final Function()? onTap;
  final String selected;

  const PaymentMethodTile({
    super.key,
    required this.logo,
    required this.name,
    this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected == name
                ? Colors.blueAccent
                : Colors.black.withOpacity(.1),
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Image.network(
            logo,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(name),
        ),
      ),
    );
  }
}

