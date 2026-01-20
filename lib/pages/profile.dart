import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoggedIn = true;
  String? selectedLanguage = 'Kurdish';
  String? selectedTheme = 'Dark';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    if (isLoggedIn) ...[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://www.outoflives.net/wp-content/uploads/2025/09/My-Hopes-For-Dexter-Resurrection-Season-2.jpg',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Zhyar Omer',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      Icon(Icons.account_circle, size: 55, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Guest User',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 10),

              if (isLoggedIn) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Account Settings',
                      style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(25)),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(color: Colors.grey[750], height: 1),
                    itemBuilder: (context, index) {
                      final items = [
                        {'title': 'Account', 'icon': Icons.person},
                        {'title': 'Password', 'icon': Icons.lock},
                        {'title': 'Order history', 'icon': Icons.history},
                      ];

                      final item = items[index];

                      return ListTile(
                        leading: Icon(item['icon'] as IconData, color: Colors.grey[200]),
                        title: Text(
                          item['title'] as String,
                          style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                        onTap: () {
                          print('Tapped on ${item['title']}');
                        },
                      );
                    },
                  ),
                ),
              ],

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Preferences',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(12),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(25)),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: isLoggedIn ? 3 : 2,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(color: Colors.grey[750], height: 1),
                  itemBuilder: (context, index) {
                    final items = [
                      {'title': 'Theme', 'icon': Icons.color_lens},
                      {'title': 'Language', 'icon': Icons.language},
                      if (isLoggedIn) {'title': 'Interests', 'icon': Icons.favorite},
                    ];

                    final item = items[index];

                    return ListTile(
                      leading: Icon(item['icon'] as IconData, color: Colors.grey[200]),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
                      ),
                      trailing: item['title'] == 'Language'
                          ? DropdownButton<String>(
                              value: selectedLanguage,
                              dropdownColor: Colors.red[850],
                              underline: SizedBox(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              items: ['Kurdish', 'English', 'Arabic']
                                  .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLanguage = newValue;
                                });
                              },
                            )
                          : item['title'] == 'Theme'
                          ? DropdownButton<String>(
                              value: selectedTheme,
                              underline: SizedBox(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              items: ['Light', 'Dark', 'Auto']
                                  .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTheme = newValue;
                                });
                              },
                            )
                          : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                      onTap: () {
                        print('Tapped on ${item['title']}');
                      },
                    );
                  },
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Support',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(12),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(25)),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(color: Colors.grey[750], height: 1),
                  itemBuilder: (context, index) {
                    final items = [
                      {'title': 'Support', 'icon': Icons.support, 'trailing': true},
                      {'title': 'Terms of Service', 'icon': Icons.description, 'trailing': true},
                      {'title': 'FAQ', 'icon': Icons.help_outline, 'trailing': true},
                    ];

                    final item = items[index];

                    return ListTile(
                      leading: Icon(item['icon'] as IconData, color: Colors.grey[200]),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                      onTap: () {
                        print('Tapped on ${item['title']}');
                      },
                    );
                  },
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'More',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (isLoggedIn) ...[
                Container(
                  margin: const EdgeInsets.all(12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(25)),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(color: Colors.grey[750], height: 1),
                    itemBuilder: (context, index) {
                      final items = [
                        {'title': 'Delete Account', 'icon': Icons.delete_forever},
                        {'title': 'Logout', 'icon': Icons.logout},
                      ];

                      final item = items[index];

                      return ListTile(
                        leading: Icon(item['icon'] as IconData, color: Colors.grey[200]),
                        title: Text(
                          item['title'] as String,
                          style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          print('Tapped on ${item['title']}');
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
