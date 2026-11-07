import '../../ui.dart';
import '../cases/my_cases_tab.dart';
import '../home/home_tab.dart';
import '../settings/settings_tab.dart';

/// Root navigation screen managing the primary bottom navigation tabs via IndexedStack.
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: colors.surface1,
        indicatorColor: colors.gavelGold.withValues(alpha: 0.25),
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.gavel_outlined, color: colors.text2),
            selectedIcon: Icon(Icons.gavel, color: colors.gavelGold),
            label: strings.tabHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined, color: colors.text2),
            selectedIcon: Icon(Icons.folder, color: colors.gavelGold),
            label: strings.tabCases,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: colors.text2),
            selectedIcon: Icon(Icons.settings, color: colors.gavelGold),
            label: strings.tabSettings,
          ),
        ],
      ),
    );
  }
}
