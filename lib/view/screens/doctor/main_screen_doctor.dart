import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/config/searchBar.dart';
import 'package:tabibi/view/screens/config/topBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unnecessary_import

class MainScreenDoctor extends StatelessWidget {
  const MainScreenDoctor({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageDoctor(),
    );
  }
}

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({Key? key}) : super(key: key);

  @override
  _HomePageDoctorState createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  int pageIndex = 0;

  final pages = [
    const Home(),
    const Patients(),
    const messages(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, -1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? Icon(
                    Icons.home_filled,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? Icon(
                    Icons.message_rounded,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.message_outlined,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? Icon(
                    Icons.person,
                    color: mainColor,
                    size: 37,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? Icon(
                    Icons.settings_applications,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.settings_applications_outlined,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

//home
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  String? email;
  List<dynamic> patients = [];

  @override
  void initState() {
    super.initState();
    getInfoUser();
    fetchPatients().then((fetchedPatients) {
      if (mounted) {
        setState(() {
          patients = fetchedPatients;
        });
      }
    }).catchError((error) {
      // Handle error when fetching patients
      print('Error: $error');
    });
  }

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    String? cachedEmail = cache.getString('email');
    String? cachedName = cache.getString('name');

    setState(() {
      name = cachedName;
      email = cachedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            AppName(
              name: name,
              email: email,
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: SizedBox(
                width: 323,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Trouvez vos patients ici',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: SizedBox(
                height: 45,
                child: MyCustomSearchBar(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: SizedBox(
                width: 323,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Liste des patients',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // add see all action here
                      },
                      child: Text(
                        'Voir tout',
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: patients.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: patients.length,
                              itemBuilder: (context, index) {
                                var patient = patients[index];
                                String patientName =
                                    patient['username'] ?? 'Unknown';
                                String patientUrgance =
                                    patient['urgence'] ?? 'Unknown';
                                return Container(
                                  margin: const EdgeInsets.only(
                                    top: 14,
                                    left: 15,
                                    right: 15,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.addUrgencyPage);
                                        },
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 100,
                                            height: 70,
                                            child: Image.asset(
                                              'assets/images/doctor.png',
                                              height: 70,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.addUrgencyPage);
                                              },
                                              child: Text(
                                                patientName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.addUrgencyPage);
                                              },
                                              child: Text(
                                                patientUrgance,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(mainColor),
                                              ),
                                              child: const Text(
                                                  'Details de patient'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
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

//messages

class Conversation {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  Conversation({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });
}

class Message {
  final String sender;
  final String message;
  final String time;
  final bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.message,
    required this.time,
    required this.isLiked,
    required this.unread,
  });
}

class messages extends StatefulWidget {
  const messages({super.key});

  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {
  final List<Conversation> _conversations = [
    Conversation(
      name: 'patient',
      message: 'Hello, how are you?',
      time: '12:30 PM',
      // avatarUrl: 'assets/images/doctor.png',
      avatarUrl: 'assets/images/doctor.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 1,
        title: const Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(conversation.avatarUrl),
            ),
            title: Text(conversation.name),
            subtitle: Text(conversation.message),
            trailing: Text(conversation.time),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversationScreen(
                    conversation: conversation,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ConversationScreen extends StatefulWidget {
  final Conversation conversation;

  const ConversationScreen({super.key, required this.conversation});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<Message> _messages = [
    Message(
      sender: 'patient',
      message: 'Hello, how are you?',
      time: '10:30 AM',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: 'doctor',
      message: 'Hello, how are you?',
      time: '10:30 AM',
      isLiked: false,
      unread: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: mainColor,
        title: Text(widget.conversation.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message,
                  isMe: message.sender == 'patient' ? false : true,
                );
              },
            ),
          ),
          MessageInput(
            onSendMessage: (String message) {
              Message newMessage = Message(
                sender: 'Me',
                message: message,
                time: '${DateTime.now().hour}:${DateTime.now().minute}',
                isLiked: false,
                unread: true,
              );
              setState(() {
                _messages.add(newMessage);
              });
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[200] : mainColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
          bottomLeft:
              isMe ? const Radius.circular(30.0) : const Radius.circular(0),
          bottomRight:
              isMe ? const Radius.circular(0) : const Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            message.message,
            style: TextStyle(
              color: isMe ? Colors.black : Colors.white,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            message.time,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInput({super.key, required this.onSendMessage});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      widget.onSendMessage(_textEditingController.text);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.mic_rounded),
            onPressed: () {},
            color: mainColor,
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Entrez un message...'),
              onSubmitted: (value) {
                _sendMessage();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
            color: mainColor,
          ),
        ],
      ),
    );
  }
}

//patients
class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  String? name;
  String? email;
  List<dynamic> patients = [];

  @override
  void initState() {
    super.initState();
    // getInfoUser();
    fetchPatients().then((fetchedPatients) {
      if (mounted) {
        setState(() {
          patients = fetchedPatients;
        });
      }
    }).catchError((error) {
      // Handle error when fetching patients
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Patients'),
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    child: SizedBox(
                      height: 45,
                      child: MyCustomSearchBar(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: patients.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: patients.length,
                                    itemBuilder: (context, index) {
                                      var patient = patients[index];
                                      String patientName =
                                          patient['username'] ?? 'Unknown';
                                      String patientUrgance =
                                          patient['urgence'] ?? 'Unknown';
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          top: 14,
                                          left: 15,
                                          right: 15,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.addUrgencyPage);
                                              },
                                              child: ClipOval(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 70,
                                                  child: Image.asset(
                                                    'assets/images/doctor.png',
                                                    height: 70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 40,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(Routes
                                                          .addUrgencyPage);
                                                    },
                                                    child: Text(
                                                      patientName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(Routes
                                                          .addUrgencyPage);
                                                    },
                                                    child: Text(
                                                      patientUrgance,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  mainColor),
                                                    ),
                                                    child: const Text(
                                                        'Details de patient'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//profile
class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController _authController = AuthController();

  String? name;
  String? email;

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    String? cachedemail = cache.getString('email');
    String? cachedName = cache.getString('name');

    setState(() {
      name = cachedName;
      email = cachedemail;
    });
  }

  @override
  void initState() {
    super.initState();
    getInfoUser();

    super.initState();
    Get.put(_authController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: mainColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/images/doctor.png"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$name",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$email",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Cardiologist",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.25),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: mainColor,
                      ),
                      title: const Text(
                        'Edit profile',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.25),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.people_alt,
                        color: mainColor,
                      ),
                      title: const Text(
                        'Mes patients',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.25),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: mainColor,
                      ),
                      title: const Text(
                        'Langue',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.05),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: mainColor,
                      ),
                      title: const Text(
                        'Se déconnecter',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
