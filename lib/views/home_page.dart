import '../ui.dart';
import 'navigation/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title});

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AppProviderMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(context.strings.apr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppText(
              'You have pushed the button this many times:',
            ),
            DisplayLarge(
              '${appState.count}',
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            key: keys.homePageKeys.increment,
            onPressed: () {
              context.appViewModel.increment();
            },
            tooltip: 'Increment',
            child: const AppIcon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => context.go(const ProfilePageRoute(id: 1).location),
            tooltip: 'Profile Page',
            child: const AppIcon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
