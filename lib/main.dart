import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
          surface: Colors.grey.shade50,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.deepPurple.shade900,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple.shade900),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shadowColor: Colors.deepPurple.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

//////////////////// LOGIN PAGE ////////////////////

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.deepPurpleAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Card(
              elevation: 20,
              shadowColor: Colors.black.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.auto_awesome, size: 50, color: Colors.deepPurple),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.deepPurple.shade900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sign in to continue", 
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.deepPurple.shade300),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.deepPurple.shade300),
                        suffixIcon: IconButton(
                          icon: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              key: ValueKey(_obscureText),
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                        },
                        child: Text("LOGIN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////// HOME WITH BOTTOM NAV ////////////////////

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  
  List<Map<String, dynamic>> tasks = [];
  List<String> notes = [];

  void addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task);
    });
  }

  void toggleTask(Map<String, dynamic> task) {
    setState(() {
      task["done"] = !task["done"];
    });
  }

  void removeTask(Map<String, dynamic> task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void addNote(String note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      TasksPage(
        tasks: tasks,
        onTaskAdded: addTask,
        onTaskToggled: toggleTask,
        onTaskRemoved: removeTask,
      ),
      SchedulePage(
        tasks: tasks,
        onTaskToggled: toggleTask,
        onTaskRemoved: removeTask,
      ),
      NotesPage(
        notes: notes,
        onAddNote: addNote,
      ),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        elevation: 10,
        backgroundColor: Colors.white,
        indicatorColor: Colors.deepPurple.shade100,
        onDestinationSelected: (i) {
          setState(() {
            index = i;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline), 
            selectedIcon: Icon(Icons.check_circle, color: Colors.deepPurple),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined), 
            selectedIcon: Icon(Icons.calendar_today, color: Colors.deepPurple),
            label: "Schedule",
          ),
          NavigationDestination(
            icon: Icon(Icons.sticky_note_2_outlined), 
            selectedIcon: Icon(Icons.sticky_note_2, color: Colors.deepPurple),
            label: "Notes",
          ),
        ],
      ),
    );
  }
}

//////////////////// TASKS PAGE ////////////////////
class TasksPage extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(Map<String, dynamic>) onTaskAdded;
  final Function(Map<String, dynamic>) onTaskToggled;
  final Function(Map<String, dynamic>) onTaskRemoved;

  TasksPage({
    required this.tasks,
    required this.onTaskAdded,
    required this.onTaskToggled,
    required this.onTaskRemoved,
  });

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  void addTask() async {
    TextEditingController controller = TextEditingController();
    DateTime? date;
    TimeOfDay? time;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text("Add New Task", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade900)),
                  SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "What needs to be done?",
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setModalState(() => date = pickedDate);
                            }
                          },
                          icon: Icon(Icons.date_range),
                          label: Text(date == null ? "Date" : "${date!.day}/${date!.month}/${date!.year}"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade50,
                            foregroundColor: Colors.deepPurple,
                            elevation: 0,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setModalState(() => time = pickedTime);
                            }
                          },
                          icon: Icon(Icons.access_time),
                          label: Text(time == null ? "Time" : time!.format(context)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade50,
                            foregroundColor: Colors.deepPurple,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          widget.onTaskAdded({
                            "title": controller.text,
                            "done": false,
                            "date": date,
                            "time": time,
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Added 🚀"),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Create Task", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTask,
        label: Text("New Task", style: TextStyle(fontWeight: FontWeight.bold)),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: widget.tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_outlined, size: 80, color: Colors.grey.shade300),
                  SizedBox(height: 16),
                  Text("No tasks yet 💤", style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 80),
              itemCount: widget.tasks.length,
              itemBuilder: (context, i) {
                final task = widget.tasks[i];
                String dateStr = task["date"] != null ? "${(task["date"] as DateTime).day}/${(task["date"] as DateTime).month}/${(task["date"] as DateTime).year}" : "";
                String timeStr = task["time"] != null ? (task["time"] as TimeOfDay).format(context) : "";
                String subtitle = "$dateStr $timeStr".trim();

                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: GestureDetector(
                      onTap: () => widget.onTaskToggled(task),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: task["done"] ? Colors.green.shade50 : Colors.transparent,
                          border: Border.all(
                            color: task["done"] ? Colors.green : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 18,
                            color: task["done"] ? Colors.green : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      task["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: task["done"] ? Colors.grey : Colors.black87,
                        decoration: task["done"] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: subtitle.isNotEmpty 
                        ? Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: Colors.deepPurple.shade300),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    subtitle, 
                                    style: TextStyle(color: Colors.deepPurple.shade700, fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ) 
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                      onPressed: () => widget.onTaskRemoved(task),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

//////////////////// SCHEDULE PAGE ////////////////////
class SchedulePage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(Map<String, dynamic>) onTaskToggled;
  final Function(Map<String, dynamic>) onTaskRemoved;

  SchedulePage({
    required this.tasks,
    required this.onTaskToggled,
    required this.onTaskRemoved,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    List<Map<String, dynamic>> todayTasks = tasks.where((task) {
      if (task["date"] == null) return false;
      DateTime taskDate = task["date"] as DateTime;
      return taskDate.year == today.year && taskDate.month == today.month && taskDate.day == today.day;
    }).toList();

    List<Map<String, dynamic>> upcomingTasks = tasks.where((task) {
      if (task["date"] == null) return false;
      DateTime taskDate = task["date"] as DateTime;
      return taskDate.isAfter(DateTime(today.year, today.month, today.day, 23, 59, 59));
    }).toList();

    Widget buildTaskList(List<Map<String, dynamic>> taskList, String emptyMessage, IconData emptyIcon) {
      if (taskList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(emptyIcon, size: 80, color: Colors.grey.shade300),
              SizedBox(height: 16),
              Text(emptyMessage, style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
            ],
          ),
        );
      }
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: taskList.length,
        itemBuilder: (context, i) {
          final task = taskList[i];
          String dateStr = task["date"] != null ? "${(task["date"] as DateTime).day}/${(task["date"] as DateTime).month}/${(task["date"] as DateTime).year}" : "";
          String timeStr = task["time"] != null ? (task["time"] as TimeOfDay).format(context) : "";
          String subtitle = "$dateStr $timeStr".trim();

          return Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: GestureDetector(
                onTap: () => onTaskToggled(task),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task["done"] ? Colors.green.shade50 : Colors.transparent,
                    border: Border.all(
                      color: task["done"] ? Colors.green : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: task["done"] ? Colors.green : Colors.transparent,
                    ),
                  ),
                ),
              ),
              title: Text(
                task["title"],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: task["done"] ? Colors.grey : Colors.black87,
                  decoration: task["done"] ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: subtitle.isNotEmpty 
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.deepPurple.shade300),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              subtitle, 
                              style: TextStyle(color: Colors.deepPurple.shade700, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ) 
                  : null,
              trailing: IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                onPressed: () => onTaskRemoved(task),
              ),
            ),
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Schedule"),
          bottom: TabBar(
            indicatorColor: Colors.deepPurple,
            indicatorWeight: 3,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: "Today"),
              Tab(text: "Upcoming"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildTaskList(todayTasks, "No tasks for today 🌴", Icons.wb_sunny_outlined),
            buildTaskList(upcomingTasks, "No upcoming tasks 🏖️", Icons.beach_access_outlined),
          ],
        ),
      ),
    );
  }
}

//////////////////// NOTES PAGE ////////////////////
class NotesPage extends StatefulWidget {
  final List<String> notes;
  final Function(String) onAddNote;

  NotesPage({required this.notes, required this.onAddNote});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  void addNote() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("New Note", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple.shade900)),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Type your note here...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(24),
          actionsPadding: EdgeInsets.only(right: 20, bottom: 20),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  widget.onAddNote(controller.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text("Save"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: widget.notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note_rounded, size: 80, color: Colors.grey.shade300),
                  SizedBox(height: 16),
                  Text("No notes yet 📝", style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                ],
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: widget.notes.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple.shade400, Colors.deepPurpleAccent.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.format_quote_rounded, color: Colors.white54, size: 24),
                      SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          widget.notes[i],
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}