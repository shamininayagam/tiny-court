import '../../mixins/case_history_mixin.dart';
import '../../ui.dart';

/// Profile and Justice Level stats tab matching the Tiny Court UI mockup.
class ProfileTab extends AppConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends AppConsumerState<ProfileTab>
    with CaseHistoryMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadHistoricalCases();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;
    final state = historyState;

    final int totalCases = state.allCases.length;
    final int decidedCases =
        state.allCases.where((c) => c.status.name == 'decided').length;
    final int pendingCases = totalCases - decidedCases;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          strings.tabSettings,
          style: AppTextStyle.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: colors.bg,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenGutter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.m),
              // Cute chibi avatar with golden crown
              _ProfileAvatarHeader(colors: colors),
              const SizedBox(height: AppSpacing.base),

              // Stats Row (Cases, Wins, Pending)
              _StatsRowCard(
                totalCases: totalCases,
                decidedCases: decidedCases,
                pendingCases: pendingCases,
                colors: colors,
              ),
              const SizedBox(height: AppSpacing.base),

              // Justice Level Progress Card
              _JusticeLevelCard(colors: colors),
              const SizedBox(height: AppSpacing.base),

              // About Tiny Court Action Card
              _AboutTinyCourtTile(colors: colors, strings: strings),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatarHeader extends StatelessWidget {
  const _ProfileAvatarHeader({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 88.0,
              height: 88.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0B2),
                shape: BoxShape.circle,
                border: Border.all(color: colors.accent, width: 3.0),
                boxShadow: [
                  BoxShadow(
                    color: colors.accent.withValues(alpha: 0.25),
                    blurRadius: 12.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text('👩‍⚖️', style: TextStyle(fontSize: 44.0)),
              ),
            ),
            Positioned(
              top: -12.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: colors.bookmarkYellow,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text('👑', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        AppText(
          'Little Litigator',
          style: AppTextStyle.headlineMedium,
          color: colors.text,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 2.0),
        AppText(
          'Court Enthusiast',
          style: AppTextStyle.caption,
          color: colors.text2,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _StatsRowCard extends StatelessWidget {
  const _StatsRowCard({
    required this.totalCases,
    required this.decidedCases,
    required this.pendingCases,
    required this.colors,
  });

  final int totalCases;
  final int decidedCases;
  final int pendingCases;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: colors.hairline),
        boxShadow: [
          BoxShadow(
            color: colors.text.withValues(alpha: 0.04),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatColumn(
            value: '$totalCases',
            label: 'Cases',
            colors: colors,
          ),
          Container(width: 1.0, height: 32.0, color: colors.hairline),
          _StatColumn(
            value: '$decidedCases',
            label: 'Wins',
            colors: colors,
          ),
          Container(width: 1.0, height: 32.0, color: colors.hairline),
          _StatColumn(
            value: '$pendingCases',
            label: 'Pending',
            colors: colors,
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.value,
    required this.label,
    required this.colors,
  });

  final String value;
  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          value,
          style: AppTextStyle.headlineMedium,
          color: colors.text,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 2.0),
        AppText(
          label,
          style: AppTextStyle.caption,
          color: colors.text2,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _JusticeLevelCard extends StatelessWidget {
  const _JusticeLevelCard({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.p16,
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: colors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Justice Level',
                    style: AppTextStyle.caption,
                    color: colors.text3,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 2.0),
                  AppText(
                    'Rookie Advocate',
                    style: AppTextStyle.bodyMedium,
                    color: colors.text,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
              Icon(Icons.star, color: colors.accent, size: 28.0),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: LinearProgressIndicator(
              value: 0.65,
              backgroundColor: colors.surface2,
              valueColor: AlwaysStoppedAnimation<Color>(colors.accent),
              minHeight: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutTinyCourtTile extends StatelessWidget {
  const _AboutTinyCourtTile({
    required this.colors,
    required this.strings,
  });

  final AppColors colors;
  final dynamic strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.p16,
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: colors.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_outline, color: colors.accent, size: 20.0),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  strings.settingsAboutHeader,
                  style: AppTextStyle.bodyMedium,
                  color: colors.text,
                  fontWeight: FontWeight.w700,
                ),
                AppText(
                  strings.settingsVersion,
                  style: AppTextStyle.caption,
                  color: colors.text3,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colors.text3),
        ],
      ),
    );
  }
}
