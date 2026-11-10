import '../../ui.dart';
import '../cases/my_cases_tab.dart';
import '../home/home_tab.dart';
import '../profile/profile_tab.dart';
import '../settings/settings_tab.dart';

/// Root navigation screen managing the 4 bottom navigation tabs matching the UI mockup.
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    MyCasesTab(),
    SettingsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.surface1,
          border: Border(top: BorderSide(color: colors.hairline, width: 1.0)),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: colors.surface1,
          indicatorColor: colors.accent.withValues(alpha: 0.2),
          elevation: 0,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: colors.text3),
              selectedIcon: Icon(Icons.home, color: colors.accent),
              label: strings.tabHome,
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_outlined, color: colors.text3),
              selectedIcon: Icon(Icons.folder, color: colors.accent),
              label: strings.tabCases,
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined, color: colors.text3),
              selectedIcon: Icon(Icons.bar_chart, color: colors.accent),
              label: 'Stats',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: colors.text3),
              selectedIcon: Icon(Icons.person, color: colors.accent),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
