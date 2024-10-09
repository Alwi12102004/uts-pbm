import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(
          color: Colors.green,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List nama pengguna
  final List<String> userNames = [
    'Ali',
    'Budi',
    'Cindy',
    'Dewi',
    'Eka',
    'Fajar',
    'Gina',
    'Hadi',
    'Indah',
    'Joko',
    'Kira',
    'Lina',
    'Maya',
    'Nina',
    'Omar',
  ];

  // List panggilan terakhir
  final List<String> lastCalls = [
    'Panggilan terakhir: 10 menit yang lalu',
    'Panggilan terakhir: 20 menit yang lalu',
    'Panggilan terakhir: 30 menit yang lalu',
    'Panggilan terakhir: 15 menit yang lalu',
    'Panggilan terakhir: 5 menit yang lalu',
    'Panggilan terakhir: 1 jam yang lalu',
    'Panggilan terakhir: 45 menit yang lalu',
    'Panggilan terakhir: 50 menit yang lalu',
    'Panggilan terakhir: 2 jam yang lalu',
    'Panggilan terakhir: 30 menit yang lalu',
    'Panggilan terakhir: 25 menit yang lalu',
    'Panggilan terakhir: 1 jam yang lalu',
    'Panggilan terakhir: 35 menit yang lalu',
    'Panggilan terakhir: 10 menit yang lalu',
    'Panggilan terakhir: 1 jam 30 menit yang lalu',
  ];

  // Variabel untuk menampung kata kunci pencarian
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Fungsi untuk memperbarui kata kunci pencarian
  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  // Fungsi untuk mendapatkan daftar pengguna yang cocok dengan kata kunci pencarian
  List<String> _getFilteredUserNames() {
    if (searchQuery.isEmpty) {
      return userNames;
    }
    return userNames
        .where((userName) =>
            userName.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  // Fungsi untuk menampilkan dialog pencarian
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return AlertDialog(
          title: Text('Cari Pengguna'),
          content: TextField(
            onChanged: (value) {
              query = value;
            },
            decoration: InputDecoration(hintText: 'Masukkan nama pengguna...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateSearchQuery(query);
                Navigator.of(context).pop();
              },
              child: Text('Cari'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk membuka halaman chat
  void _navigateToChat(String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(userName: userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Clone'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog, // Memanggil dialog pencarian
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Aksi untuk tombol lebih banyak
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.chat), text: 'Chats'),
            Tab(icon: Icon(Icons.phone), text: 'Panggilan'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: ListTile dengan fitur pencarian
          ListView.builder(
            itemCount: _getFilteredUserNames().length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(_getFilteredUserNames()[index][0]), // Mengambil huruf pertama dari nama
                  ),
                  title: Text(
                    _getFilteredUserNames()[index], // Nama asli
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Last message from ${_getFilteredUserNames()[index]}'),
                  trailing: Text('10:00 AM'),
                  onTap: () {
                    _navigateToChat(_getFilteredUserNames()[index]); // Navigasi ke halaman chat
                  },
                ),
              );
            },
          ),
          // Tab 2: Panggilan
          ListView.builder(
            itemCount: _getFilteredUserNames().length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(_getFilteredUserNames()[index][0]), // Mengambil huruf pertama dari nama
                  ),
                  title: Text(
                    _getFilteredUserNames()[index], // Nama asli
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(lastCalls[index]), // Menampilkan panggilan terakhir
                  trailing: Icon(Icons.call),
                ),
              );
            },
          ),
          // Tab 3: Profile
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'), // Ganti dengan nama gambar kamu
                ),
                SizedBox(height: 10),
                Text(
                  'MUHAMMAD BASORI ALWI',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '2210631170134@student.unsika.ac.id',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Kontak',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('No. Telepon: 0812-3456-7890'),
                        SizedBox(height: 5),
                        Text('Alamat: Jalan Raya No. 123, Kota A'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk mengedit profil
                  },
                  child: Text('Edit Profil'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final String userName;

  ChatPage({required this.userName});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat dengan $userName'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Misalnya ada 20 pesan
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Pesan ${index + 1} dari $userName'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Aksi untuk mengirim pesan
                    if (messageController.text.isNotEmpty) {
                      // Di sini Anda dapat menambahkan logika untuk mengirim pesan
                      print('Pesan terkirim: ${messageController.text}');
                      messageController.clear(); // Mengosongkan input setelah mengirim
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
