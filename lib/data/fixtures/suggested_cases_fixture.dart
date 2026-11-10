import '../../model/enums/case_category.dart';
import '../../model/suggested_case.dart';

/// Pre-seeded catalog of 10 curated comical dispute templates for Tiny Court.
abstract final class SuggestedCasesFixture {
  static final List<SuggestedCase> catalog = [
    SuggestedCase((b) => b
      ..id = 'sc_pizza_slice'
      ..title = 'The Case of the Missing Pizza Slice'
      ..description =
          'A sacred final pepperoni slice vanished from the communal fridge overnight.'
      ..category = CaseCategory.food
      ..defaultPlaintiff = 'Hungry Roommate'
      ..defaultDefendant = 'Midnight Snacker'
      ..defaultPlaintiffArgument =
          'I left that slice in the box with my name written in bold Sharpie. It had a legal expectation of privacy!'
      ..defaultDefendantArgument =
          'It had been sitting there for 14 hours. Maritime salvage law dictates that abandoned pizza belongs to whoever is awake at 2 AM.'),
    SuggestedCase((b) => b
      ..id = 'sc_2am_episode'
      ..title = 'The 2 AM Episode Felony'
      ..description =
          'Pledging to watch "just one more episode" resulted in a 4:30 AM season finale marathon.'
      ..category = CaseCategory.relationships
      ..defaultPlaintiff = 'Sleep-Deprived Partner'
      ..defaultDefendant = 'Binge Watcher'
      ..defaultPlaintiffArgument =
          'We have an 8 AM standup meeting! You swore with your hand on your heart that episode 7 was the absolute last one.'
      ..defaultDefendantArgument =
          'Episode 7 ended on a cliffhanger where the spaceship was exploding. Going to sleep during an explosion is a violation of the plot!'),
    SuggestedCase((b) => b
      ..id = 'sc_late_flaker'
      ..title = 'The 30-Minute Late Flaker'
      ..description =
          'Arriving chronically late after texting "I am 5 minutes away" 40 minutes ago.'
      ..category = CaseCategory.friendship
      ..defaultPlaintiff = 'Punctual Friend'
      ..defaultDefendant = 'Chronically Tardy'
      ..defaultPlaintiffArgument =
          'I was sitting alone at the restaurant table drinking water for 35 minutes like an abandoned NPC.'
      ..defaultDefendantArgument =
          'I entered an unexpected time-dilation vortex while looking for my house keys. Time is relative, Einstein proved this.'),
    SuggestedCase((b) => b
      ..id = 'sc_fry_theft'
      ..title = 'The French Fry Grand Larceny'
      ..description =
          'Claiming "I don\'t want any fries" then systematically consuming 40% of the other person\'s fries.'
      ..category = CaseCategory.food
      ..defaultPlaintiff = 'Fry Purchaser'
      ..defaultDefendant = 'Fry Tax Collector'
      ..defaultPlaintiffArgument =
          'I explicitly asked if they wanted their own fries. They said no. Then their hand hovered over my carton like a claw crane.'
      ..defaultDefendantArgument =
          'Fries tasted better when stolen. Plus, I prevented the plaintiff from consuming excess sodium. It was a health intervention.'),
    SuggestedCase((b) => b
      ..id = 'sc_cancel_plans'
      ..title = 'Cancelling Plans While Shoes Are On'
      ..description =
          'Texting to cancel the hangout when the other party is already fully dressed and shoes are laced.'
      ..category = CaseCategory.friendship
      ..defaultPlaintiff = 'Fully Dressed Friend'
      ..defaultDefendant = 'Cozy Homebody'
      ..defaultPlaintiffArgument =
          'I had applied perfume, styled my hair, and put on outside pants. Outside pants cannot be wasted!'
      ..defaultDefendantArgument =
          'My bed presented a compelling counter-offer involving blankets and tea. Forcing me outside in that condition was dangerous.'),
    SuggestedCase((b) => b
      ..id = 'sc_leaving_on_read'
      ..title = 'The 12-Hour "Leaving on Read" Offense'
      ..description =
          'Opening an urgent text message, leaving blue double-checks, and replying half a day later.'
      ..category = CaseCategory.relationships
      ..defaultPlaintiff = 'Anxious Texter'
      ..defaultDefendant = 'Silent Reader'
      ..defaultPlaintiffArgument =
          'The blue ticks showed they read it at 10:14 AM. Yet they were actively posting memes on Instagram all afternoon.'
      ..defaultDefendantArgument =
          'I replied in my mind! I had an entire thoughtful telepathic conversation with the plaintiff, I just forgot to type it out.'),
    SuggestedCase((b) => b
      ..id = 'sc_coffee_mug'
      ..title = 'The Office Sink Coffee Mug Abandonment'
      ..description =
          'Leaving a crusty espresso mug "to soak" in the office sink for three consecutive business days.'
      ..category = CaseCategory.work
      ..defaultPlaintiff = 'Kitchen Enforcer'
      ..defaultDefendant = 'The Soaking Strategist'
      ..defaultPlaintiffArgument =
          'Soaking does not take 72 hours. That is no longer soaking, that is starting an unauthorized botanical experiment in the sink.'
      ..defaultDefendantArgument =
          'The coffee stain required deep molecular softening. Rushing the soak would compromise the structural integrity of the ceramic.'),
    SuggestedCase((b) => b
      ..id = 'sc_thermostat_war'
      ..title = 'The Great Thermostat Cold War'
      ..description =
          'Secretly bumping the thermostat down to arctic tundra temperatures without a mandate.'
      ..category = CaseCategory.work
      ..defaultPlaintiff = 'Shivering Colleague'
      ..defaultDefendant = 'AC Enthusiast'
      ..defaultPlaintiffArgument =
          'I am typing with fingerless gloves and seeing my breath in the conference room. This is an office, not a meat locker.'
      ..defaultDefendantArgument =
          'You can always put on another sweater. But I cannot legally take off more clothes in an office environment.'),
    SuggestedCase((b) => b
      ..id = 'sc_hmm_reply'
      ..title = 'The Single "Hmm" Reply Misconduct'
      ..description =
          'Responding to a 4-paragraph heartfelt life update with the single word "hmm".'
      ..category = CaseCategory.random
      ..defaultPlaintiff = 'Effusive Storyteller'
      ..defaultDefendant = 'Monosyllabic Replier'
      ..defaultPlaintiffArgument =
          'I poured my heart out describing my existential dilemma. A three-letter murmur is emotional bankruptcy.'
      ..defaultDefendantArgument =
          '"Hmm" conveys deep philosophical contemplation. It signifies that the court of my mind is currently in deliberation.'),
    SuggestedCase((b) => b
      ..id = 'sc_hoodie_heist'
      ..title = 'The Permanent Hoodie Borrowing Scam'
      ..description =
          'Borrowing an oversized vintage hoodie in autumn and never returning it.'
      ..category = CaseCategory.relationships
      ..defaultPlaintiff = 'Original Hoodie Owner'
      ..defaultDefendant = 'Hoodie Colonizer'
      ..defaultPlaintiffArgument =
          'She said "I\'m just a little cold" six months ago. That hoodie now lives in her closet with squatters\' rights.'
      ..defaultDefendantArgument =
          'It smells like comfort and looks significantly better on me. It has found its true spiritual owner.'),
  ];
}
