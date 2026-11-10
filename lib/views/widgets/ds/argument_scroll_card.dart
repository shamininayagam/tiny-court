import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';
import 'parchment_card.dart';

/// Duel card displaying plaintiff grievance vs defendant rebuttal with pastel character avatars.
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
    final strings = context.strings;

    return ParchmentCard(
      padding: AppSpacing.p16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PartyDuelItem(
            roleLabel: strings.reviewPlaintiffHeader,
            partyName: plaintiffName,
            argumentText: plaintiffArgument,
            avatarBgColor: colors.plaintiffRose,
            avatarIconColor: colors.plaintiffRed,
            icon: Icons.person_outline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
            child: Divider(
              height: 1.0,
              color: colors.hairline,
            ),
          ),
          _PartyDuelItem(
            roleLabel: strings.reviewDefendantHeader,
            partyName: defendantName,
            argumentText: defendantArgument,
            avatarBgColor: colors.defendantPeriwinkle,
            avatarIconColor: colors.defendantBlue,
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}

class _PartyDuelItem extends StatelessWidget {
  const _PartyDuelItem({
    required this.roleLabel,
    required this.partyName,
    required this.argumentText,
    required this.avatarBgColor,
    required this.avatarIconColor,
    required this.icon,
  });

  final String roleLabel;
  final String partyName;
  final String argumentText;
  final Color avatarBgColor;
  final Color avatarIconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cute circular chibi avatar disc
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: avatarBgColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: avatarIconColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            size: 24.0,
            color: avatarIconColor,
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    roleLabel,
                    style: AppTextStyle.caption,
                    color: avatarIconColor,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: AppText(
                      partyName,
                      style: AppTextStyle.titleMedium,
                      color: colors.text,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.m,
                  vertical: AppSpacing.s,
                ),
                decoration: BoxDecoration(
                  color: avatarBgColor.withValues(alpha: 0.5),
                  borderRadius: AppRadius.smAll,
                ),
                child: AppText(
                  argumentText,
                  style: AppTextStyle.bodyMedium,
                  color: colors.text,
                  italic: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
