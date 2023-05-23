import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/logic/controllers/auth_controller.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/urgance.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/auth/login_screen.dart';
import 'package:tabibi/view/screens/config/horizontalScroll.dart';
import 'package:tabibi/view/screens/config/searchBar.dart';
import 'package:tabibi/view/screens/config/topBar.dart';
import 'package:tabibi/view/screens/patient/appointment_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    const favorites(),
    const urgance(),
    const Home(),
    const messages(),
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
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppName(
                        name: name,
                        email: email,
                      ),
                      ////
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        width: 323,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Trouvez votre médecin ici',
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
                        width: 323,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Categories',
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
                                'Voir tout',
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
                            const Expanded(
                              child: Text(
                                'Spécialiste le plus proche',
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
                                'Voir tout',
                                style: TextStyle(
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        child: DoctorCard(
                          imagePath: 'assets/images/doctor.png',
                          doctorName: 'Doctor',
                          specialty: 'Cardiologist',
                          onBookAppointmentPressed: () async {
                            final result = await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentForm(),
                              ),
                            );
                            if (result != null) {}
                          },
                          onFavoritePressed: () {},
                          onMessagePressed: () {
                            Get.toNamed(Routes.messageScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//doctorCard

class DoctorCard extends StatelessWidget {
  final String imagePath;
  final String doctorName;
  final String specialty;
  final VoidCallback onBookAppointmentPressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onMessagePressed;

  const DoctorCard({
    super.key,
    required this.imagePath,
    required this.doctorName,
    required this.specialty,
    required this.onBookAppointmentPressed,
    required this.onFavoritePressed,
    required this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onBookAppointmentPressed,
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 70,
                child: Image.asset(
                  imagePath,
                  height: 70,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onBookAppointmentPressed,
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
                  onTap: onBookAppointmentPressed,
                  child: Text(
                    specialty,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onBookAppointmentPressed,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  child: const Text('Réserver rendez-vous'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onFavoritePressed,
                    icon: Icon(
                      Icons.favorite_border,
                      size: 30,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: onMessagePressed,
                    icon: Transform.rotate(
                      angle: 245 * 4 / 180,
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//favorites
class favorites extends StatelessWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 323,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                child: Text(
                                  'Trouvez votre médecin préféré ici',
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
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 17,
                            right: 17,
                            bottom: 17,
                          ),
                          child: SizedBox(
                            height: 45,
                            child: MyCustomSearchBar(),
                          ),
                        ),
                        const SizedBox(
                          width: 323,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Favorite médecin',
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
                        SizedBox(
                          child: FavoritesMedecinCard(
                            doctorName: 'Doctor',
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AppointmentForm(),
                                ),
                              );
                              if (result != null) {}
                            },
                            imageAssetPath: 'assets/images/doctor.png',
                            specialty: 'Spécialité ',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

///FavoritesMedecinCard

class FavoritesMedecinCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String imageAssetPath;
  final VoidCallback onPressed;

  const FavoritesMedecinCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.imageAssetPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onPressed,
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 70,
                child: Image.asset(
                  imageAssetPath,
                  height: 70,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Text(
                    doctorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: onPressed,
                  child: Text(
                    specialty,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  child: const Text('Réserver rendez-vous'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    onPressed: onPressed,
                    icon: Transform.rotate(
                      angle: 245 * 4 / 180,
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
        title: const Text('Types d\'urgences'),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              width: 323,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Text(
                      'Trouvez votre cas d\'urgence ici',
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
            const SizedBox(
              width: 323,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Types d\'urgence',
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
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Display circular loading indicator while data is being fetched
                : urgances.isEmpty
                    ? const Center(
                        child: Text(
                            'No data available')) // Display a message if no data is fetched
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
      name: 'Alice',
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
        centerTitle: true,
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
      sender: 'Alice',
      message: 'Hello, how are you?',
      time: '10:30 AM',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: 'dddd',
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
                  isMe: message.sender == 'Alice' ? false : true,
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
            icon: const Icon(Icons.camera_alt),
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

//profile
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final AuthController _authController = AuthController();

  String? name;

  getInfoUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    // String? cachedemail = cache.getString('email');
    String? cachedName = cache.getString('name');

    setState(() {
      name = cachedName;
      // email = cachedemail;
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
                        const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.black,
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
                          bottom: 10.0,
                          top: 10,
                        ),
                        child: const ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          title: Text(
                            'profil ',
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: const ListTile(
                          leading: Icon(
                            Icons.people_alt,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Mes médecins préférés',
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: const ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Paramètres',
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
                            bottom:
                                BorderSide(color: Colors.black, width: 0.25),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: const ListTile(
                          leading: Icon(
                            Icons.help,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Assistance',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences cache =
                            await SharedPreferences.getInstance();
                        await cache.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
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
                        child: const ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          title: Text(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
