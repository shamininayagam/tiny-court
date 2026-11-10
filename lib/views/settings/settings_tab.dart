import '../../model/app_settings.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';

/// Settings and preferences tab for Tiny Court.
class SettingsTab extends AppConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  SettingsTabState createState() => SettingsTabState();
}

class SettingsTabState extends AppConsumerState<SettingsTab> {
  late AppSettings _settings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final repo = ref.read(appRepositoryProvider);
    setState(() {
      _settings = repo.settingsService.getSettings();
    });
  }

  Future<void> _onToggleSound(bool value) async {
    final repo = ref.read(appRepositoryProvider);
    await repo.settingsService.setSoundEnabled(value);
    _loadSettings();
  }

  Future<void> _onToggleHaptics(bool value) async {
    final repo = ref.read(appRepositoryProvider);
    await repo.settingsService.setHapticsEnabled(value);
    _loadSettings();
  }

  Future<void> _onToggleDarkTheme(bool value) async {
    final repo = ref.read(appRepositoryProvider);
    await repo.settingsService.setThemePreference(value ? 'dark' : 'light');
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          strings.settingsTitle,
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: colors.surface1,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screenGutter,
          children: [
            _SettingsSectionHeader(title: strings.settingsTitle),
            const SizedBox(height: AppSpacing.s),
            _SettingsToggleTile(
              icon: Icons.volume_up_outlined,
              label: strings.settingsSoundEffects,
              value: _settings.soundEnabled,
              onChanged: _onToggleSound,
            ),
            const SizedBox(height: AppSpacing.s),
            _SettingsToggleTile(
              icon: Icons.vibration_outlined,
              label: strings.settingsHaptics,
              value: _settings.hapticsEnabled,
              onChanged: _onToggleHaptics,
            ),
            const SizedBox(height: AppSpacing.s),
            _SettingsToggleTile(
              icon: Icons.dark_mode_outlined,
              label: strings.settingsDarkTheme,
              value: _settings.themePreference == 'dark',
              onChanged: _onToggleDarkTheme,
            ),
            const SizedBox(height: AppSpacing.l),
            const _AboutTinyCourtCard(),
          ],
        ),
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  const _SettingsSectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppText(
      title,
      style: AppTextStyle.label,
      color: colors.text2,
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  const _SettingsToggleTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: AppRadius.smAll,
        border: Border.all(color: colors.hairline),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: colors.gavelGold),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: AppText(
              label,
              style: AppTextStyle.bodyMedium,
              color: colors.text,
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: colors.gavelGold,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _AboutTinyCourtCard extends StatelessWidget {
  const _AboutTinyCourtCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.balance, size: 22, color: colors.gavelGold),
              const SizedBox(width: AppSpacing.s),
              AppText(
                strings.settingsAboutHeader,
                style: AppTextStyle.titleMedium,
                color: colors.text,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          AppText(
            strings.settingsAboutDescription,
            style: AppTextStyle.caption,
            color: colors.text2,
          ),
          const SizedBox(height: AppSpacing.base),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                strings.settingsVersion,
                style: AppTextStyle.caption,
                color: colors.text2,
              ),
              LegalBadge(
                label: 'JUDGE BARNABY',
                color: colors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
