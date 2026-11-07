import 'package:built_collection/built_collection.dart';

import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/verdict_type.dart';
import '../../model/verdict.dart';

/// Template data holder for a humorous judicial ruling.
class VerdictTemplate {
  final String ruleId;
  final VerdictType verdictType;
  final String Function(Case c) statementBuilder;
  final String Function(Case c) explanationBuilder;
  final String Function(Case c) punishmentBuilder;
  final String Function(Case c) closingRemarkBuilder;
  final List<String> Function(Case c) responsiblePartiesBuilder;

  const VerdictTemplate({
    required this.ruleId,
    required this.verdictType,
    required this.statementBuilder,
    required this.explanationBuilder,
    required this.punishmentBuilder,
    required this.closingRemarkBuilder,
    required this.responsiblePartiesBuilder,
  });

  Verdict toVerdict(Case c, {String? customRuleId}) {
    return Verdict((b) => b
      ..id = 'v_${c.id}'
      ..caseId = c.id
      ..verdictType = verdictType
      ..responsibleParties =
          ListBuilder<String>(responsiblePartiesBuilder(c))
      ..judgeStatement = statementBuilder(c)
      ..explanation = explanationBuilder(c)
      ..punishment = punishmentBuilder(c)
      ..closingRemark = closingRemarkBuilder(c)
      ..ruleId = customRuleId ?? ruleId
      ..generatedAt = DateTime.now().toUtc());
  }
}

/// Catalog of humorous verdict templates across categories and ruling types.
abstract final class VerdictCatalog {
  // ==========================================
  // SPECIAL HEURISTIC TEMPLATES
  // ==========================================

  /// Extreme word-count disparity rule: Plaintiff writes essays, Defendant says "ok"
  static final VerdictTemplate extremeIndifference = VerdictTemplate(
    ruleId: 'rule_extreme_indifference',
    verdictType: VerdictType.guiltyDefendant,
    statementBuilder: (c) =>
        'The court finds ${c.defendantName} in Gross Contempt of Friendship for criminal indifference.',
    explanationBuilder: (c) =>
        '${c.plaintiffName} submitted a comprehensive thesis on the matter, while ${c.defendantName} responded with the enthusiasm of an unplugged toaster.',
    punishmentBuilder: (c) =>
        '${c.defendantName} must listen to ${c.plaintiffName} speak uninterrupted for 15 minutes while making deliberate eye contact and nodding thoughtfully.',
    closingRemarkBuilder: (c) =>
        'The court will not tolerate one-syllable rebuttals to multi-paragraph grievances. Case closed.',
    responsiblePartiesBuilder: (c) => [c.defendantName],
  );

  /// Reverse Contempt: Plaintiff overreacted to nothing
  static final VerdictTemplate frivolousOverreaction = VerdictTemplate(
    ruleId: 'rule_frivolous_claim',
    verdictType: VerdictType.caseDismissed,
    statementBuilder: (c) =>
        'This entire proceeding is an insult to the dignity of Tiny Court.',
    explanationBuilder: (c) =>
        'The court finds that ${c.plaintiffName} has manufactured a crisis out of thin air. No reasonable statute of friendship was violated by ${c.defendantName}.',
    punishmentBuilder: (c) =>
        '${c.plaintiffName} must drink a glass of water, take three deep breaths, and apologize for wasting the judicial system\'s time.',
    closingRemarkBuilder: (c) =>
        'Court is dismissed. Go outside and touch grass immediately.',
    responsiblePartiesBuilder: (c) => [],
  );

  // ==========================================
  // CATEGORY: FOOD & SNACKS
  // ==========================================

  static final VerdictTemplate foodBothGuilty = VerdictTemplate(
    ruleId: 'food_both_guilty',
    verdictType: VerdictType.bothGuilty,
    statementBuilder: (c) =>
        'Both ${c.plaintiffName} and ${c.defendantName} are found guilty of Culinary Misconduct.',
    explanationBuilder: (c) =>
        'After forensic review of the crumbs, ${c.plaintiffName} failed to provide adequate refrigerated security, while ${c.defendantName} exercised zero moral restraint.',
    punishmentBuilder: (c) =>
        'Both parties must immediately split the cost of a large pizza and award the final slice to a neutral third party.',
    closingRemarkBuilder: (c) =>
        'Justice has been served. Extra garlic dipping sauce is court-mandated.',
    responsiblePartiesBuilder: (c) => [c.plaintiffName, c.defendantName],
  );

  static final VerdictTemplate foodDefendantGuilty = VerdictTemplate(
    ruleId: 'food_defendant_guilty',
    verdictType: VerdictType.guiltyDefendant,
    statementBuilder: (c) =>
        'The court finds ${c.defendantName} guilty of Grand Snack Larceny.',
    explanationBuilder: (c) =>
        'Claiming "I only took a little bite" or "I didn\'t see your name on it" does not excuse unauthorized digestive appropriation.',
    punishmentBuilder: (c) =>
        '${c.defendantName} must restock ${c.plaintiffName}\'s snack reserves within 48 hours with brand-name equivalents.',
    closingRemarkBuilder: (c) =>
        'Do not touch another person\'s leftovers. Court is adjourned.',
    responsiblePartiesBuilder: (c) => [c.defendantName],
  );

  static final VerdictTemplate foodMaritimeSalvage = VerdictTemplate(
    ruleId: 'food_maritime_salvage',
    verdictType: VerdictType.notGuilty,
    statementBuilder: (c) =>
        '${c.defendantName} is found NOT GUILTY by reason of Maritime Salvage Law.',
    explanationBuilder: (c) =>
        'Evidence proves the item remained unattended in the communal fridge for over 24 hours without explicit territorial claims. It became public domain.',
    punishmentBuilder: (c) =>
        '${c.plaintiffName} must purchase a roll of masking tape and a permanent marker to establish legitimate property borders.',
    closingRemarkBuilder: (c) =>
        'If you love your snacks, label your snacks. Defendant is acquitted.',
    responsiblePartiesBuilder: (c) => [],
  );

  // ==========================================
  // CATEGORY: FRIENDSHIP
  // ==========================================

  static final VerdictTemplate friendshipDefendantGuilty = VerdictTemplate(
    ruleId: 'friendship_defendant_guilty',
    verdictType: VerdictType.guiltyDefendant,
    statementBuilder: (c) =>
        'The court finds ${c.defendantName} guilty of High Treason against social commitments.',
    explanationBuilder: (c) =>
        'Cancelling plans at the eleventh hour—especially when ${c.plaintiffName} has already dressed up—constitutes irreparable weekend sabotage.',
    punishmentBuilder: (c) =>
        '${c.defendantName} is sentenced to pay for the first round of appetizers at the next hangout and must arrive 10 minutes early.',
    closingRemarkBuilder: (c) =>
        'A deal is a deal. Put your shoes back on and go home.',
    responsiblePartiesBuilder: (c) => [c.defendantName],
  );

  static final VerdictTemplate friendshipDismissed = VerdictTemplate(
    ruleId: 'friendship_dismissed',
    verdictType: VerdictType.caseDismissed,
    statementBuilder: (c) =>
        'The court dismisses all charges: You two need to learn how to communicate.',
    explanationBuilder: (c) =>
        'A minor misunderstanding that could have been resolved with a 30-second voice note does not warrant judicial intervention.',
    punishmentBuilder: (c) =>
        'Both parties must send each other a wholesome animal meme and resume being civil immediately.',
    closingRemarkBuilder: (c) =>
        'Case dismissed with prejudice. Stop being petty.',
    responsiblePartiesBuilder: (c) => [],
  );

  static final VerdictTemplate friendshipHungJury = VerdictTemplate(
    ruleId: 'friendship_hung_jury',
    verdictType: VerdictType.hungJury,
    statementBuilder: (c) =>
        'The jury has deadlocked: Both sides are equally confusing and stubborn.',
    explanationBuilder: (c) =>
        'Neither party has presented verifiable timestamps or reliable witness accounts. The emotional ledger remains strictly tied.',
    punishmentBuilder: (c) =>
        'Both parties must agree on a neutral coin toss to determine who plans the next activity.',
    closingRemarkBuilder: (c) =>
        'Court is hopelessly divided. Order in the court!',
    responsiblePartiesBuilder: (c) => [c.plaintiffName, c.defendantName],
  );

  // ==========================================
  // CATEGORY: RELATIONSHIPS
  // ==========================================

  static final VerdictTemplate relationshipBothGuilty = VerdictTemplate(
    ruleId: 'relationship_both_guilty',
    verdictType: VerdictType.bothGuilty,
    statementBuilder: (c) =>
        'The court decrees a verdict of Mutual Romance Malpractice.',
    explanationBuilder: (c) =>
        '${c.plaintiffName} expected telepathy instead of speaking, while ${c.defendantName} exhibited the situational awareness of a potato.',
    punishmentBuilder: (c) =>
        'Both parties must prepare a home-cooked meal together without checking their phones for two hours.',
    closingRemarkBuilder: (c) =>
        'Telepathy is not supported in this version of reality. Case closed.',
    responsiblePartiesBuilder: (c) => [c.plaintiffName, c.defendantName],
  );

  static final VerdictTemplate relationshipDefendantGuilty = VerdictTemplate(
    ruleId: 'relationship_defendant_guilty',
    verdictType: VerdictType.guiltyDefendant,
    statementBuilder: (c) =>
        'The court finds ${c.defendantName} guilty of Negligent Partnership Duties.',
    explanationBuilder: (c) =>
        'The evidence confirms that replying "hmm" or watching episodes ahead of schedule violates the unwritten relationship covenant.',
    punishmentBuilder: (c) =>
        '${c.defendantName} must give ${c.plaintiffName} complete control over the TV remote for the upcoming weekend.',
    closingRemarkBuilder: (c) =>
        'Relationships require loyalty, patience, and waiting to watch the season finale together.',
    responsiblePartiesBuilder: (c) => [c.defendantName],
  );

  // ==========================================
  // CATEGORY: WORK & CHORES
  // ==========================================

  static final VerdictTemplate workDefendantGuilty = VerdictTemplate(
    ruleId: 'work_defendant_guilty',
    verdictType: VerdictType.guiltyDefendant,
    statementBuilder: (c) =>
        'The court finds ${c.defendantName} guilty of Domestic or Office Shirking.',
    explanationBuilder: (c) =>
        'Leaving dishes "to soak" for more than 4 hours is not dishwashing preparation; it is starting an unlicensed biological petri dish.',
    punishmentBuilder: (c) =>
        '${c.defendantName} must empty the dishwasher or scrub the sink for the next three days straight.',
    closingRemarkBuilder: (c) =>
        'Soaking has limits. Clean your dishes!',
    responsiblePartiesBuilder: (c) => [c.defendantName],
  );

  static final VerdictTemplate workNotGuilty = VerdictTemplate(
    ruleId: 'work_not_guilty',
    verdictType: VerdictType.notGuilty,
    statementBuilder: (c) =>
        '${c.defendantName} is cleared of all chore violations.',
    explanationBuilder: (c) =>
        'The court finds ${c.plaintiffName}\'s cleanliness standards to be authoritarian and bordering on operating a commercial laboratory.',
    punishmentBuilder: (c) =>
        '${c.plaintiffName} must relax their inspection regime and allow a 12-hour grace period for chore completion.',
    closingRemarkBuilder: (c) =>
        'A lived-in home has a few stray mugs. Defendant is acquitted.',
    responsiblePartiesBuilder: (c) => [],
  );

  // ==========================================
  // CATEGORY: RANDOM PETTY CRIMES
  // ==========================================

  static final VerdictTemplate randomBothGuilty = VerdictTemplate(
    ruleId: 'random_both_guilty',
    verdictType: VerdictType.bothGuilty,
    statementBuilder: (c) =>
        'The court finds both parties guilty of Aggravated Nonsense in the First Degree.',
    explanationBuilder: (c) =>
        'This dispute is so absurd that the judge\'s wig almost flew off during deliberations. Neither party possesses moral high ground.',
    punishmentBuilder: (c) =>
        'Both parties must high-five each other, declare peace, and never bring up this argument again.',
    closingRemarkBuilder: (c) =>
        'Case permanently expunged from the docket. Everyone go home.',
    responsiblePartiesBuilder: (c) => [c.plaintiffName, c.defendantName],
  );

  static final VerdictTemplate randomPlaintiffGuilty = VerdictTemplate(
    ruleId: 'random_plaintiff_guilty',
    verdictType: VerdictType.guiltyPlaintiff,
    statementBuilder: (c) =>
        'In a dramatic turn of events, ${c.plaintiffName}\'s claim has backfired entirely!',
    explanationBuilder: (c) =>
        'Upon cross-examination, ${c.plaintiffName}\'s allegations unravelled like cheap sweater yarn. ${c.defendantName} acted with saint-like restraint.',
    punishmentBuilder: (c) =>
        '${c.plaintiffName} must buy ${c.defendantName} an iced beverage of their choosing as formal reparations.',
    closingRemarkBuilder: (c) =>
        'He who casts the first stone must pay for the iced coffee.',
    responsiblePartiesBuilder: (c) => [c.plaintiffName],
  );

  // ==========================================
  // POOL BY CATEGORY FOR DETERMINISTIC SELECTION
  // ==========================================

  static List<VerdictTemplate> getTemplatesForCategory(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => [
          foodBothGuilty,
          foodDefendantGuilty,
          foodMaritimeSalvage,
        ],
      CaseCategory.friendship => [
          friendshipDefendantGuilty,
          friendshipDismissed,
          friendshipHungJury,
        ],
      CaseCategory.relationships => [
          relationshipBothGuilty,
          relationshipDefendantGuilty,
          friendshipDismissed,
        ],
      CaseCategory.work => [
          workDefendantGuilty,
          workNotGuilty,
          randomBothGuilty,
        ],
      CaseCategory.random => [
          randomBothGuilty,
          randomPlaintiffGuilty,
          extremeIndifference,
        ],
      _ => [randomBothGuilty, foodBothGuilty, friendshipDismissed],
    };
  }
}
