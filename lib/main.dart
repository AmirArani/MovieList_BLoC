import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_list/data/data_sources/remote/tmdb_api.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/ui/home/favorites.dart';
import 'package:movie_list/ui/home/home.dart';
import 'package:movie_list/ui/home/profile.dart';
import 'package:movie_list/ui/home/search.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:provider/provider.dart';

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
      ),

      //inject dependency to TMDB API just here. once and last.
      // now we can use Repository in any class without initializing TMDB API
      home: Provider<Repository<MovieEntity>>(
          create: (context) => Repository<MovieEntity>(TmdbAPI()),
          child: const MainScreen()),
    );
  }
}

const int homeIndex = 0;
const int favIndex = 1;
const int searchIndex = 2;
const int profileIndex = 3;

class MainScreen extends StatefulWidget{
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
              bottom: 65,
              child: IndexedStack(
                index: selectedScreenIndex,
                children: [
                  // HomeScreen(),
                  // ArticleScreen(),
                  // SearchScreen(),
                  // ProfileScreen(),
                  _navigator(_homeKey, homeIndex, const HomeScreen()),
                  _navigator(_favKey, favIndex, const FavScreen()),
                  _navigator(_searchKey, searchIndex, const SearchScreen()),
                  _navigator(_profileKey, profileIndex, const ProfileScreen()),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
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
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: const Color(0xFF9b8487).withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ButtonNavigationItem(
                    iconFileName: 'Home.png',
                    activeIconFileName: 'Home.png',
                    title: 'Home',
                    isActive: selectedIndex == homeIndex,
                    onTap: () {
                      onTap(homeIndex);
                    },
                  ),
                  _ButtonNavigationItem(
                    iconFileName: 'Articles.png',
                    activeIconFileName: 'Articles.png',
                    isActive: selectedIndex == favIndex,
                    title: 'Articles',
                    onTap: () {
                      onTap(favIndex);
                    },
                  ),
                  _ButtonNavigationItem(
                    iconFileName: 'Search.png',
                    activeIconFileName: 'Search.png',
                    title: 'Search',
                    isActive: selectedIndex == searchIndex,
                    onTap: () {
                      onTap(searchIndex);
                    },
                  ),
                  _ButtonNavigationItem(
                    iconFileName: 'Menu.png',
                    activeIconFileName: 'Menu.png',
                    title: 'Menu',
                    isActive: selectedIndex == profileIndex,
                    onTap: () {
                      onTap(profileIndex);
                    },
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                height: 65,
                child: Image.asset('assets/img/icons/plus.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.5),
                  color: const Color(0xFF376AED),
                  border: Border.all(color: Colors.white, width: 5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ButtonNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final String title;
  final bool isActive;
  final Function() onTap;

  const _ButtonNavigationItem({
    Key? key,
    required this.iconFileName,
    required this.activeIconFileName,
    required this.title,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/icons/$iconFileName'),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: themeData.textTheme.caption!.apply(
                  color: isActive
                      ? themeData.colorScheme.primary
                      : themeData.textTheme.caption!.color),
            ),
          ],
        ),
      ),
    );
  }
}