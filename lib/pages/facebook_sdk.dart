import 'package:flutter/material.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class FacebookSdk extends StatelessWidget {
  static final facebookAppEvents = FacebookAppEvents();

  FacebookSdk({super.key});

  @override
  Widget build(BuildContext context) {
    facebookAppEvents;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: facebookAppEvents.getAnonymousId(),
            builder: (context, snapshot) {
              final id = snapshot.data ?? '???';
              return Text('Anonymous ID: $id');
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Click me!"),
            onPressed: () {
              facebookAppEvents.logEvent(
                name: 'button_clicked',
                parameters: {
                  'button_id': 'the_clickme_button',
                },
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Set user data"),
            onPressed: () {
              facebookAppEvents.setUserData(
                email: 'opensource@oddbit.id',
                firstName: 'Oddbit',
                dateOfBirth: '2019-10-19',
                city: 'Denpasar',
                country: 'Indonesia',
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Test logAddToCart"),
            onPressed: () {
              facebookAppEvents.logAddToCart(
                id: '1',
                type: 'product',
                price: 99.0,
                currency: 'TRY',
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Test purchase!"),
            onPressed: () {
              facebookAppEvents.logPurchase(amount: 1, currency: "USD");
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Enable advertise tracking!"),
            onPressed: () {
              facebookAppEvents.setAdvertiserTracking(enabled: true);
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text("Disabled advertise tracking!"),
            onPressed: () {
              facebookAppEvents.setAdvertiserTracking(enabled: false);
            },
          ),
        ],
      ),
    );
  }
}
