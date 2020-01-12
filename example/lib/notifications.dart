import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class NotificationsExample extends StatefulWidget {
  @override
  _NotificationsExampleState createState() => _NotificationsExampleState();
}

class _NotificationsExampleState extends State<NotificationsExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications Test"),
      ),

      // Building the [NotificationProvider]
      body: NotificationsListener(
        // What to do when a notification arrives when the app is in foreground
        onMessage: (BuildContext context, Map<String, dynamic> message) {
          
          // showing snackbar
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(message.toString()),
            )
          );
        },

        // the rest of the app
        child: page1(),
      ),
    );
  }

  /// Random home page
  Widget page1() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(height: 20,),

          // title
          Text("Home"),

          // gap
          SizedBox(height: 40),
          
          // button to subscribe to notifications of event
          SubscribeButton(),

          // gap
          SizedBox(height: 40,),

          // button to unsubscribe to notifications of event
          UnsubscribeButton(),

          // gap
          SizedBox(height: 40,),

          // button to clear announcements
          DeleteButton(),

          // gap
          SizedBox(height: 40,),
          
          // title
          Text("announcements:"),

          // gap
          SizedBox(height: 40,),

          // the previous announcements
          Expanded(
            child: AnnouncementsBuilder(
              builder: (BuildContext context, List<Announcement> announcements) {
                return ListView.builder(
                  itemCount: announcements.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(announcements[index].title),
                      subtitle: Text(announcements[index].body),
                    );
                  },
                );
              },
            )
          )
        ],
      )
    );
  }
}

/// Button to subscribe to notifications for events. 
/// In a separate widget so that [NotificationsListener.of] can 
/// work properly.
class SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Subscribe to test event"),
      onPressed: () {
        NotificationsListener.of(context).subscribe(topic: "t12")
        .then((value) => Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Subscribed"),)
        ));
      },
    );
  }
}

/// Button to unsubscribe from notifications for events. 
/// In a separate widget so that [NotificationsListener.of] can 
/// work properly.
class UnsubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Unsubscribe from test event"),
      onPressed: () {
        NotificationsListener.of(context).unsubscribe(topic: "t12")
        .then((value) => Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Unsubscribed"),)
        ));
      },
    );
  }
}

/// Button to clear events. In a separate widget so 
/// that [NotificationsListener.of] can work properly.
class DeleteButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Clear announcements"),
      onPressed: () {
        NotificationsListener.of(context).deletePersistent()
        .then((_) => Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Deleted all announcements."),)
        ));
      },
    );
  }
}