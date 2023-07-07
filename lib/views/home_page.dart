import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllers/helpers/database_helper.dart';
import '../controllers/helpers/notification_helper.dart';
import '../controllers/providers/theme_provider.dart';
import '../models/globals/globals.dart';
import '../models/reminder_model.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  DateTime ddd = DateTime.now();
  Future? storedData;

  @override
  void initState() {
    storedData = DataBaseHelper.dataBaseHelper.initDB();
    storedData = DataBaseHelper.dataBaseHelper.fetchAllRecode();
    NotificationHelper.notificationHelper.NotificationInitialize();
    String dd = ddd.toString();

    DateTime? ds = DateTime.tryParse(dd);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminder App',
          style: GoogleFonts.raleway(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: Icon(
              (Provider.of<ThemeProvider>(context, listen: false)
                          .themeModal
                          .isDark ==
                      false)
                  ? Icons.wb_sunny_outlined
                  : Icons.sunny,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${month[dateTime.month - 1]} ${dateTime.day},${dateTime.year}',
                        style: GoogleFonts.robotoFlex(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Text(
                          '${week[dateTime.weekday - 1]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20, right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Reminders',
                        style: GoogleFonts.robotoFlex(
                          fontSize: 22,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: DataBaseHelper.dataBaseHelper.fetchAllRecode(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error :${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<reminderModel> allData =
                      snapshot.data as List<reminderModel>;
                  if (allData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_clock,
                            size: 300,
                            color: Colors.grey.shade300,
                          ),
                          Text(
                            'No Task Exists',
                            style: GoogleFonts.alata(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        allData[index].time;
                        DataBaseHelper.dataBaseHelper
                            .dummy(id: allData[index].id);
                        DateTime t = DateTime.parse(allData[index].time);
                        NotificationHelper.notificationHelper.showNotification(
                          id: allData[index].id,
                          title: allData[index].title,
                          description: allData[index].description,
                          scheduleTime: allData[index].time,
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            color: Color(
                              int.parse(allData[index].color),
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              leading: Text(
                                '${index + 1})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              title: Text(
                                allData[index].title,
                                style: const TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allData[index].description,
                                    style: GoogleFonts.robotoFlex(
                                      letterSpacing: 0.3,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  (t.hour > 12)
                                      ? Text(
                                          '⏰ ${t.hour - 12} :${t.minute} PM',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      : Text(
                                          '⏰ ${t.hour} :${t.minute} AM',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                ],
                              ),
                              trailing: SizedBox(
                                height: 300,
                                width: 97,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 0,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            width: 0.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          currentColor = Color(
                                              int.parse(allData[index].color));
                                          myColor1 = allData[index].color;
                                        });
                                        Navigator.pushNamed(
                                          context,
                                          'Update_Page',
                                          arguments: allData[index],
                                        );
                                        st = allData[index].title;
                                        sid = allData[index].id;
                                        sd = allData[index].description;
                                        stt = allData[index].time;
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 25,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await DataBaseHelper.dataBaseHelper
                                            .deleteData(
                                          id: allData[index].id,
                                        );
                                        setState(() {
                                          storedData;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade900,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple.shade800,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Navigator.pushNamed(context, 'Detail_Page');
        },
        label: const Text(
          'Add Task',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        icon: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}
