import 'package:ambition_delivery/presentation/bloc/auth_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_event.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_state.dart';
import 'package:ambition_delivery/presentation/bloc/ride_request_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/socket_bloc.dart';
import 'package:ambition_delivery/presentation/pages/driver/driver_history_page.dart';
import 'package:ambition_delivery/presentation/pages/driver/driver_main_page.dart';
import 'package:ambition_delivery/presentation/pages/driver/driver_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Titles corresponding to each page
  final List<String> _titles = [
    'Driver Home',
    'Driver History',
    'Driver Profile',
  ];
  @override
  void initState() {
    BlocProvider.of<RideRequestBloc>(context).add(UpdateDriverLocationEvent());
    BlocProvider.of<DriverProfileBloc>(context).add(GetDriverProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex]), actions: [
        //Guide Icon with hover text "Driver Guidelines"
        IconButton(
          icon: const Icon(Icons.help),
          onPressed: () {
            Navigator.of(context).pushNamed('/driver_tips');
          },
          tooltip: 'Driver Guidelines',
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: BlocBuilder<DriverProfileBloc, DriverProfileState>(
                builder: (context, state) {
                  if (state is DriverProfileLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(state.driver.profile),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.driver.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          state.driver.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.house),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                _pageController.jumpToPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
              title: const Text('History'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                _pageController.jumpToPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.user),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                _pageController.jumpToPage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.comment),
              title: const Text('Chat'),
              onTap: () {
                Navigator.of(context).pushNamed('/chat_list');
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.rightFromBracket),
              title: const Text('Logout'),
              onTap: () {
                //show dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text(
                        "Are you sure you want to logout from the app?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          final AuthBloc authBloc =
                              BlocProvider.of<AuthBloc>(context);
                          BlocProvider.of<SocketBloc>(context)
                              .unsubscribeFromEvents(authBloc.currentUserId);
                          authBloc.add(SignOutEvent());

                          // Navigate to the login page
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          DriverMainPage(),
          DriverHistoryPage(),
          DriverProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
