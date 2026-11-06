import '../../ui.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon,{super.key,});
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(icon);
  }
}
