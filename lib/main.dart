import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_list/ui/favorites/favorites.dart';
import 'package:movie_list/ui/home/home.dart';
import 'package:movie_list/ui/profile/profile.dart';
import 'package:movie_list/ui/search/search.dart';
import 'package:movie_list/ui/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: LightThemeColors.primary.withOpacity(0),
      statusBarBrightness: Brightness.dark,
    ));

    const defaultTextStyle =
        TextStyle(color: LightThemeColors.onBackground, fontFamily: "Avenir");

    return MaterialApp(
        title: 'Movie List',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primary,
            secondary: LightThemeColors.secondary,
            onSecondary: Colors.white,
            background: LightThemeColors.background,
          ),
          textTheme: TextTheme(
            bodyText1: defaultTextStyle.copyWith(
              fontSize: 20,
            ),
            bodyText2: defaultTextStyle,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: defaultTextStyle.copyWith(
                color: LightThemeColors.background, fontSize: 22),
          ),
        ),
        home: const MainScreen());
  }
}

const int homeIndex = 0;
const int favIndex = 1;
const int searchIndex = 2;
const int profileIndex = 3;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;

  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _favKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    favIndex: _favKey,
    searchIndex: _searchKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;

    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 0,
              child: IndexedStack(
                index: selectedScreenIndex,
                children: [
                  _navigator(_homeKey, homeIndex, const HomeScreen()),
                  _navigator(_favKey, favIndex, const FavScreen()),
                  _navigator(_searchKey, searchIndex, const SearchScreen()),
                  _navigator(_profileKey, profileIndex, const ProfileScreen()),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              left: 35,
              right: 35,
              child: _ButtonNavigation(
                selectedIndex: selectedScreenIndex,
                onTap: (int index) {
                  setState(() {
                    _history.remove(selectedScreenIndex);
                    _history.add(selectedScreenIndex);
                    selectedScreenIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}

class _ButtonNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex;

  const _ButtonNavigation(
      {Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.8),
                  LightThemeColors.secondary.withOpacity(0.8),
                ],
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                _ButtonNavigationItem(
                  iconFileName: 'home.svg',
                  activeIconFileName: 'home_selected.svg',
                  isActive: selectedIndex == homeIndex,
                  onTap: () {
                    onTap(homeIndex);
                  },
                ),
                _ButtonNavigationItem(
                  iconFileName: 'search.svg',
                  activeIconFileName: 'search_selected.svg',
                  isActive: selectedIndex == searchIndex,
                  onTap: () {
                    onTap(searchIndex);
                  },
                ),
                _ButtonNavigationItem(
                  iconFileName: 'star.svg',
                  activeIconFileName: 'star_selected.svg',
                  isActive: selectedIndex == favIndex,
                  onTap: () {
                    onTap(favIndex);
                  },
                ),
                _ButtonNavigationItem(
                  iconFileName: 'user.svg',
                  activeIconFileName: 'user_selected.svg',
                  isActive: selectedIndex == profileIndex,
                  onTap: () {
                    onTap(profileIndex);
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),

      // child: Container(
      //   height: 60,
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: const Color(0xFF9b8487).withOpacity(0.3),
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       _ButtonNavigationItem(
      //         iconFileName: 'Home.png',
      //         activeIconFileName: 'Home.png',
      //         title: 'Home',
      //         isActive: selectedIndex == homeIndex,
      //         onTap: () {
      //           onTap(homeIndex);
      //         },
      //       ),
      //       _ButtonNavigationItem(
      //         iconFileName: 'Articles.png',
      //         activeIconFileName: 'Articles.png',
      //         isActive: selectedIndex == favIndex,
      //         title: 'Articles',
      //         onTap: () {
      //           onTap(favIndex);
      //         },
      //       ),
      //       _ButtonNavigationItem(
      //         iconFileName: 'Search.png',
      //         activeIconFileName: 'Search.png',
      //         title: 'Search',
      //         isActive: selectedIndex == searchIndex,
      //         onTap: () {
      //           onTap(searchIndex);
      //         },
      //       ),
      //       _ButtonNavigationItem(
      //         iconFileName: 'Menu.png',
      //         activeIconFileName: 'Menu.png',
      //         title: 'Menu',
      //         isActive: selectedIndex == profileIndex,
      //         onTap: () {
      //           onTap(profileIndex);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class _ButtonNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final bool isActive;
  final Function() onTap;

  const _ButtonNavigationItem({
    Key? key,
    required this.iconFileName,
    required this.activeIconFileName,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: isActive
              ? SvgPicture.asset(
                  'assets/img/icons/navbar/$activeIconFileName',
                  width: 32,
                  height: 32,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  'assets/img/icons/navbar/$iconFileName',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                )),
    );
  }
}
