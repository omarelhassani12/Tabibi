import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/languages/language_controller.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/message.dart';
import 'package:tabibi/services/urgance.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/detail_user.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/config/horizontalScroll.dart';
import 'package:tabibi/view/screens/patient/searchBar.dart';
import 'package:tabibi/view/screens/config/topBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/view/screens/profile.dart';
import 'package:intl/intl.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 2;

  final pages = [
    Favorites(),
    const urgance(),
    const Home(),
    const Messages(),
    const profile(),
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
                    Icons.favorite_outlined,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
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
                    Icons.healing_sharp,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.healing_outlined,
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
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
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
                pageIndex = 4;
              });
            },
            icon: pageIndex == 4
                ? Icon(
                    Icons.person,
                    color: mainColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  String? email;

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    String? cachedEmail = cache.getString('email');
    String? cachedName = cache.getString('name');

    setState(() {
      name = cachedName;
      email = cachedEmail;
    });
  }

  List<dynamic> doctors = [];
  @override
  void initState() {
    super.initState();
    Get.put(DoctorController());
    getInfoUser();
    fetchDoctors().then((fetchedDoctors) {
      if (mounted) {
        setState(() {
          doctors = fetchedDoctors;
        });
      }
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  void dispose() {
    Get.delete<DoctorController>(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(doctors);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Scaffold(
                body: Column(
                  children: [
                    AppName(
                      name: name,
                      email: email,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 323,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'findYourDoctor'.tr,
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 17,
                        right: 17,
                      ),
                      child: SizedBox(
                        height: 45,
                        child: MyCustomSearchBar(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 323,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'categories'.tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
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
                            const SizedBox(
                              height: 170,
                              child: HorizontalScroll(),
                            ),
                            SizedBox(
                              width: 323,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'nearestSpecialist'.tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
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
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: doctors.isEmpty ? 1 : doctors.length,
                              itemBuilder: (context, index) {
                                if (doctors.isEmpty) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  var doctor = doctors[index];
                                  String doctorAvatar = doctor['avatar'] ?? '';
                                  String doctorName = doctor['username'] ?? '';
                                  String specialty = doctor['speciality'] ?? '';
                                  int id = doctor['id'] ?? 0;

                                  return DoctorCard(
                                    imagePath: doctorAvatar,
                                    doctorName: doctorName,
                                    specialty: specialty,
                                    onViewDetailsPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetailsScreen(id: id),
                                        ),
                                      );
                                    },
                                    id: id,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
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
}

class DoctorController extends GetxController {
  RxList<int> likedIcons = <int>[].obs;
  var favouritesList = <int>[].obs;

  void toggleFavorite(int id) {
    if (likedIcons.contains(id)) {
      likedIcons.remove(id);
    } else {
      likedIcons.add(id);
    }
  }

  void manageFavorites() {
    if (likedIcons.isNotEmpty) {
      final int id = likedIcons.first;
      if (!favouritesList.contains(id)) {
        favouritesList.add(id);
      }
    }
  }

  bool isFavorite(int id) {
    return favouritesList.contains(id);
  }

  @override
  void dispose() {
    Get.delete<DoctorController>(); // Dispose of the controller
    super.dispose();
  }
}

class DoctorCard extends StatelessWidget {
  final int id;
  final String imagePath;
  final String doctorName;
  final String specialty;
  final VoidCallback onViewDetailsPressed;

  DoctorCard({
    Key? key,
    required this.id,
    required this.imagePath,
    required this.doctorName,
    required this.specialty,
    required this.onViewDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final DoctorController controller =
        Get.put(DoctorController()); // Register and retrieve DoctorController

    return Container(
      margin: const EdgeInsets.only(top: 14, left: 15, right: 15),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onViewDetailsPressed,
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      onTap: onViewDetailsPressed,
                      child: Text(
                        doctorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: onViewDetailsPressed,
                      child: Text(
                        specialty,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: onViewDetailsPressed,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainColor),
                    ),
                    child: Text('doctorDetails'.tr),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  final bool isLiked = controller.likedIcons.contains(id);
                  return IconButton(
                    onPressed: () => controller.toggleFavorite(id),
                    icon: isLiked
                        ? Icon(
                            Icons.favorite_rounded,
                            size: 30,
                            color: mainColor,
                          )
                        : Icon(
                            Icons.favorite_outline,
                            size: 30,
                            color: mainColor,
                          ),
                  );
                }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorController controller = Get.put(DoctorController());

    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'.tr),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: Obx(() {
        final List<int> likedIcons = controller.likedIcons;
        if (likedIcons.isEmpty) {
          return Center(
            child: Text('noFavorites'.tr),
          );
        } else {
          return ListView.builder(
            itemCount: likedIcons.length,
            itemBuilder: (context, id) {
              final int doctorid = likedIcons[id];
              print(doctorid);
              return DoctorCard(
                id: doctorid,
                imagePath:
                    'https://res.cloudinary.com/dcmqib0q6/image/upload/v1685058545/user_vugshy.png',
                doctorName: 'Doctor',
                specialty: 'Specialty',
                onViewDetailsPressed: () async {},
              );
            },
          );
        }
      }),
    );
  }
}

///urgance
class urgance extends StatefulWidget {
  const urgance({Key? key}) : super(key: key);

  @override
  State<urgance> createState() => _urganceState();
}

class _urganceState extends State<urgance> {
  List<dynamic> urgances = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUrgancesData();
  }

  void getUrgancesData() {
    fetchUrgances().then((data) {
      setState(() {
        urgances = data;
        isLoading = false;
      });
    }).catchError((error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('emergencyTypes'.tr),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 323,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Text(
                      'findEmergencyCase'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 17,
              ),
              child: SizedBox(
                height: 45,
                child: MyCustomSearchBar(),
              ),
            ),
            SizedBox(
              width: 323,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'emergencyTypes'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 16.0),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : urgances.isEmpty
                    ? Center(child: Text('noDataAvailable'.tr))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: urgances.length,
                        itemBuilder: (context, index) {
                          final urgance = urgances[index];
                          return _EmergencyCard(
                            image: NetworkImage(urgance['image']),
                            title: urgance['name'],
                            urganceId: urgance['id'].toString(),
                            onTap: () {
                              Get.toNamed(Routes.detialUrgance,
                                  arguments: urgance['id']);
                            },
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}

//EmergencyCard
class _EmergencyCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String urganceId;
  final VoidCallback onTap;

  const _EmergencyCard({
    Key? key,
    required this.image,
    required this.title,
    required this.urganceId,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image(image: image, width: 64.0, height: 64.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
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
  List<dynamic> doctors = [];
  List<Conversation> _conversations = [];
  int currentUserID = 0;

  //socket
  // IO.Socket? socket;

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        currentUserID = prefs.getInt('id') ?? 0;
      });
    });
    fetchDoctors().then((fetchedDoctors) {
      if (mounted) {
        setState(() {
          doctors = fetchedDoctors;
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
    for (var doctor in doctors) {
      if (doctor['id'] != null) {
        futures.add(fetchLastMessage(
            currentUserID.toString(), doctor['id'].toString()));
      }
    }
    return await Future.wait(futures);
  }

  List<Conversation> generateConversations(
      List<Map<String, dynamic>> lastMessages) {
    List<Conversation> conversations = [];
    for (var i = 0; i < doctors.length; i++) {
      final patient = doctors[i];
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

  // initTheSoket() {
  //   socket = IO.io("http://192.168.1.26:3000/", {
  //     'transports': ['websocket'],
  //     'autoConnect': false
  //   });

  //   socket!.connect();
  //   socket!.onConnect((_) {
  //     print("Connected with the server");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text('messages'.tr),
        centerTitle: true,
      ),
      body: _conversations.isEmpty
          ? Center(
              child: Text(
                'noMessage'.tr,
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
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
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                final bool isMe = message.sender == currentUserID.toString();
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
            currentUserID:
                currentUserID.toString(), // Pass the currentUserID as a String
            conversation: widget.conversation,
            onSendMessage: (String message) {},
          ),
        ],
      ),
    );
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
            isMe ? 'Me' : conversationName,
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

  MessageInput(
      {required this.currentUserID,
      required this.conversation,
      required this.onMessageSent,
      required Null Function(String message) onSendMessage});

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
      widget.onMessageSent(message);
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
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter a message...',
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

//profile
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final AuthController _authController = AuthController();

  String? name;
  String? avatar;

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    // String? cachedemail = cache.getString('email');
    String? cachedName = cache.getString('name');
    String? cachedAvatar = cache.getString('avatar');

    setState(() {
      name = cachedName;
      avatar = cachedAvatar;
      // email = cachedemail;
    });
  }

  @override
  void initState() {
    super.initState();
    getInfoUser();

    Get.put(_authController);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 190,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 25,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (avatar?.isNotEmpty ?? false)
                          Image.network(
                            avatar!,
                            width: 100,
                            height: 100,
                          ),
                        const SizedBox(height: 20),
                        Text(
                          '$name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 160,
              ),
              Container(
                width: 300,
                height: 400,
                margin: const EdgeInsets.only(
                  bottom: 30,
                  left: 30,
                ),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                          top: 10,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.black,
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
                                  BorderSide(color: Colors.black, width: 0.25),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.black,
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
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
                                color: Colors.black,
                              ),
                              value: true,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ],
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.help,
                            color: Colors.black,
                          ),
                          title: Text(
                            'assistance'.tr,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
