import 'package:flutter/material.dart';

import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';
import 'legal_badge.dart';
import 'parchment_card.dart';

/// Duel card displaying plaintiff grievance side-by-side or stacked against defendant rebuttal.
class ArgumentScrollCard extends StatelessWidget {
  const ArgumentScrollCard({
    super.key,
    required this.plaintiffName,
    required this.plaintiffArgument,
    required this.defendantName,
    required this.defendantArgument,
  });

  final String plaintiffName;
  final String plaintiffArgument;
  final String defendantName;
  final String defendantArgument;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ParchmentCard(
      padding: AppSpacing.p16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PartyArgumentFlap(
            badgeLabel: context.strings.reviewPlaintiffHeader,
            partyName: plaintiffName,
            argumentText: plaintiffArgument,
            badgeColor: colors.accent,
            badgeIcon: Icons.account_balance,
          ),
          const SizedBox(height: AppSpacing.m),
          Divider(
            height: AppSpacing.hairlineThickness,
            color: colors.parchmentBorder,
          ),
          const SizedBox(height: AppSpacing.m),
          _PartyArgumentFlap(
            badgeLabel: context.strings.reviewDefendantHeader,
            partyName: defendantName,
            argumentText: defendantArgument,
            badgeColor: colors.info,
            badgeIcon: Icons.shield,
          ),
        ],
      ),
    );
  }
}

class _PartyArgumentFlap extends StatelessWidget {
  const _PartyArgumentFlap({
    required this.badgeLabel,
    required this.partyName,
    required this.argumentText,
    required this.badgeColor,
    required this.badgeIcon,
  });

  final String badgeLabel;
  final String partyName;
  final String argumentText;
  final Color badgeColor;
  final IconData badgeIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LegalBadge(
              label: badgeLabel,
              icon: badgeIcon,
              color: badgeColor,
            ),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              child: AppText(
                partyName,
                style: AppTextStyle.titleMedium,
                color: colors.inkBlack,
                fontWeight: FontWeight.w700,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.s3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: AppText(
            argumentText,
            style: AppTextStyle.bodyMedium,
            color: colors.inkBlack,
            italic: true,
          ),
        ),
      ],
    );
  }
}
