import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibi/languages/language_controller.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/services/message.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/detail_user.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/patient/searchBar.dart';
import 'package:tabibi/view/screens/config/topBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/view/screens/profile.dart';

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
    const Messages(),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: SizedBox(
                width: 323,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'findYourPatient'.tr,
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
                    Expanded(
                      child: Text(
                        'listePatients'.tr,
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
                        'seeAll'.tr,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetailsScreen(
                                                id: patient['id'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 100,
                                            height: 70,
                                            child: Image.network(
                                              patient['avatar'],
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailsScreen(
                                                      id: patient['id'],
                                                    ),
                                                  ),
                                                );
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailsScreen(
                                                      id: patient['id'],
                                                    ),
                                                  ),
                                                );
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
                                            SizedBox(
                                              width: 180,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserDetailsScreen(
                                                        id: patient['id'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(mainColor),
                                                ),
                                                child: Text('detailPatient'.tr),
                                              ),
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
  final int id;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  Conversation({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });
}

class Message {
  final int id;
  final String sender;
  final String senderName; // Add the sender's name property
  final String receiver;
  final String message;
  final String time;

  Message({
    required this.id,
    required this.sender,
    required this.senderName,
    required this.receiver,
    required this.message,
    required this.time,
  });

  String get formattedTime {
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(time);
    final formatter = DateFormat('yy/MM/dd HH:mm');
    return formatter.format(dateTime);
  }
}

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<dynamic> patients = [];
  List<Conversation> _conversations = [];
  int currentUserID = 0; // Replace 0 with the actual current user ID

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        currentUserID = prefs.getInt('id') ?? 0;
      });
    });
    fetchPatients().then((fetchedPatients) {
      if (mounted) {
        setState(() {
          patients = fetchedPatients;
        });
        fetchLastMessages().then((lastMessages) {
          if (mounted) {
            setState(() {
              _conversations = generateConversations(lastMessages);
            });
          }
        }).catchError((error) {
          print('Error fetching last messages: $error');
          if (mounted) {
            setState(() {
              _conversations = [];
            });
          }
        });
      }
    }).catchError((error) {
      print('Error fetching patients: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchLastMessages() async {
    final List<Future<Map<String, dynamic>>> futures = [];
    for (var patient in patients) {
      if (patient['id'] != null) {
        futures.add(fetchLastMessage(
            currentUserID.toString(), patient['id'].toString()));
      }
    }
    return await Future.wait(futures);
  }

  List<Conversation> generateConversations(
      List<Map<String, dynamic>> lastMessages) {
    List<Conversation> conversations = [];
    for (var i = 0; i < patients.length; i++) {
      final patient = patients[i];
      final lastMessage = lastMessages[i];
      final message = lastMessage['message'] != null
          ? lastMessage['message']
          : 'noMessage'.tr;
      final time = lastMessage['created_at'] != null
          ? formatDateTime(lastMessage['created_at'])
          : '';

      conversations.add(
        Conversation(
          id: patient['id'],
          name: patient['username'],
          message: message,
          time: time,
          avatarUrl: patient['avatar'],
        ),
      );
    }
    return conversations;
  }

  String formatDateTime(String timestamp) {
    final DateTime dateTime = DateTime.parse(timestamp);
    final DateFormat formatter = DateFormat.yMd().add_jm();
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text('messages'.tr),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversation.avatarUrl),
            ),
            title: Text(conversation.name),
            subtitle: Text(
              conversation.message.length > 20
                  ? '${conversation.message.substring(0, 30)}...'
                  : conversation.message,
            ),
            trailing: Text(
              conversation.time,
              style: TextStyle(fontSize: 11),
            ),
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

  const ConversationScreen({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<Message> _messages = [];
  int currentUserID = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        currentUserID = prefs.getInt('id') ?? 0;
      });
      fetchMessages(currentUserID, widget.conversation.id)
          .then((fetchedMessages) {
        if (mounted) {
          setState(() {
            _messages = fetchedMessages
                .map((message) => Message(
                      id: message.id,
                      sender: message.sender,
                      senderName: message.senderName,
                      receiver: message.receiver,
                      message: message.message,
                      time: message.time,
                    ))
                .toList();
          });
        }
      }).catchError((error, stackTrace) {
        print('Error fetching messages: $error');
        print('Stack trace: $stackTrace');
        print('Conversation ID: ${widget.conversation.id}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int conversationId = widget.conversation.id;
    print("the sender: $currentUserID");
    print("the receiver: $conversationId");

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
            child: _messages.isEmpty
                ? Center(
                    child: Text('noMessage'.tr),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = _messages[index];
                      final bool isMe =
                          message.sender == currentUserID.toString();
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: MessageBubble(
                          message: message,
                          isMe: isMe,
                          conversationName: widget.conversation.name,
                        ),
                      );
                    },
                  ),
          ),
          MessageInput(
            onMessageSent: (String message) {
              final currentTime = DateTime.now();
              Message newMessage = Message(
                id: _messages.length + 1,
                sender: currentUserID.toString(),
                message: message,
                receiver: conversationId.toString(),
                time: currentTime.toString(),
                senderName: '',
              );
              setState(() {
                _messages.add(newMessage);
              });
            },
            currentUserID: currentUserID.toString(),
            conversation: widget.conversation,
            onSendMessage: (String message) {
              _handleSendMessage(
                  currentUserID.toString(), conversationId.toString(), message);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleSendMessage(
      String senderId, String receiverId, String message) async {
    try {
      await sendMessage(senderId, receiverId, message);
      print('Message sent successfully');
      // Fetch the updated message list after sending a new message
      fetchMessages(currentUserID, widget.conversation.id)
          .then((fetchedMessages) {
        if (mounted) {
          setState(() {
            _messages = fetchedMessages
                .map((message) => Message(
                      id: message.id,
                      sender: message.sender,
                      senderName: message.senderName,
                      receiver: message.receiver,
                      message: message.message,
                      time: message.time,
                    ))
                .toList();
          });
        }
      }).catchError((error, stackTrace) {
        print('Error fetching messages: $error');
        print('Stack trace: $stackTrace');
        print('Conversation ID: ${widget.conversation.id}');
      });
    } catch (error) {
      print('Failed to send the message. Error: $error');
    }
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String conversationName;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.conversationName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[200] : mainColor,
        borderRadius: BorderRadius.only(
          topLeft:
              isMe ? const Radius.circular(30.0) : const Radius.circular(0),
          topRight:
              isMe ? const Radius.circular(0) : const Radius.circular(30.0),
          bottomLeft: const Radius.circular(30.0),
          bottomRight: const Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMe
                ? 'Moi'
                : conversationName, // Display 'Me' for current user, otherwise display the conversation name
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            message.message,
            style: TextStyle(
              color: isMe ? Colors.black : Colors.white,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            DateFormat('yy/MM/dd HH:mm').format(DateTime.parse(message.time)),
            style: const TextStyle(
              color: Color.fromARGB(255, 117, 117, 117),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final String currentUserID;
  final Conversation conversation;
  final Function(String) onMessageSent; // Callback function

  MessageInput({
    required this.currentUserID,
    required this.conversation,
    required this.onMessageSent,
    required Null Function(String message) onSendMessage,
  });

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      final senderId = widget.currentUserID.toString();
      final receiverId = widget.conversation.id.toString();
      final message = _textEditingController.text;

      _handleSendMessage(senderId, receiverId, message);
      _textEditingController.clear();
    }
  }

  Future<void> _handleSendMessage(
      String senderId, String receiverId, String message) async {
    try {
      await sendMessage(senderId, receiverId, message);
      print('Message sent successfully');
      widget.onMessageSent(
          message); // Pass the message to the conversation screen
    } catch (error) {
      print('Failed to send the message. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {},
            color: mainColor,
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'enterMessage'.tr,
              ),
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
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('allPatients'.tr),
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0,
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
                                      String patientAvatar =
                                          patient['avatar'] ?? 'Unknown';
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailsScreen(
                                                      id: patient['id'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ClipOval(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 70,
                                                  child: Image.network(
                                                    '$patientAvatar',
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
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserDetailsScreen(
                                                            id: patient['id'],
                                                          ),
                                                        ),
                                                      );
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
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserDetailsScreen(
                                                            id: patient['id'],
                                                          ),
                                                        ),
                                                      );
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
                                                  SizedBox(
                                                    width: 180,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserDetailsScreen(
                                                              id: patient['id'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    mainColor),
                                                      ),
                                                      child: Text(
                                                          'detailPatient'.tr),
                                                    ),
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
  String? avatar;
  String? speciality;
  @override
  void initState() {
    super.initState();
    getInfoUser();

    super.initState();
    Get.put(_authController);
  }

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    String? cachedemail = cache.getString('email');
    String? cachedName = cache.getString('name');
    String? cachedAvatar = cache.getString('avatar');
    String? cachedSpeciality = cache.getString('speciality');

    setState(() {
      name = cachedName;
      email = cachedemail;
      avatar = cachedAvatar;
      speciality = cachedSpeciality;
    });
  }

  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('settings'.tr),
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
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage('$avatar'),
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
                  Text(
                    "$speciality",
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
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
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
                      title: Text(
                        'profile'.tr,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<LanguageController>(
                  init: LanguageController(),
                  builder: (value) {
                    return Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: mainColor,
                              ),
                              SizedBox(width: 35),
                              Text(
                                'language'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: value.savedLang.value,
                            icon: Icon(
                              Icons.arrow_downward,
                              size: 20,
                            ),
                            onChanged: (String? newValue) {
                              print('Selected language: $newValue');
                              if (newValue != null) {
                                value.savedLang.value = newValue;
                                Get.updateLocale(
                                    Locale(newValue.toLowerCase()));
                                value.saveLocale();
                              }
                            },
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem<String>(
                                value: 'ar',
                                child: Text('العربية'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'fr',
                                child: Text('Français'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {},
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
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: Text(
                            'darkMode'.tr,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          secondary: Icon(
                            Icons.dark_mode,
                            color: mainColor,
                          ),
                          value: true,
                          onChanged: (value) {
                            setState(() {
                              // isDarkMode = value;
                              // Call a function to change the theme mode based on the value
                              // changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dangerous,
                                color: Colors.red,
                                size: 50,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'confirmationLogoutTitle'.tr,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          content: Text(
                            'confirmationLogoutMessage'.tr,
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('cancel'.tr,
                                  style: TextStyle(color: Colors.blueGrey)),
                            ),
                            TextButton(
                              onPressed: () async {
                                SharedPreferences cache =
                                    await SharedPreferences.getInstance();
                                await cache.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Text(
                                'logout'.tr,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
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
                        Icons.logout,
                        color: mainColor,
                      ),
                      title: Text(
                        'logout'.tr,
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
