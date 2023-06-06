import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/auth.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/getstarted.dart';
import 'package:habbit_tracker/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogIn()),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.exit_to_app))
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: IconButton(
                      onPressed: () {
                        nextScreenReplace(context, const GetStarted());
                      },
                      icon: const Icon(Icons.grid_view)),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month_outlined)),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.grey[800],
                      child: const ListTile(
                        visualDensity: VisualDensity(vertical: 4),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/books.jpeg'),
                        ),
                        title: Text(
                          'Notification!',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Now is the time to read the book,\n you can change it in settings',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                // Container(
                //   padding: const EdgeInsets.all(8),
                //   height: 100,
                //   child: const DatesGrid(),
                // ),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.amber,
                  selectedTextColor: Colors.white,
                  dateTextStyle: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tuesday Habit'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey[400],
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}
