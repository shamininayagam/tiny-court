# App Components Specification & Contracts

| Field | Value |
|---|---|
| Spec | Specialized Feature Widgets & Courtroom Presentation Components |
| Target Path | `lib/views/widgets/components/` |
| Reference | `pogo_alarm/app/docs/ui_master_plan/02-app-components.md` |

---

## 1. Component Contracts

### 1. `JudgeMascotView`
* **Props:**
  * `expression`: `JudgeExpression` (`neutral`, `listening`, `suspicious`, `deliberating`, `verdictAnnounced`)
  * `size`: `double` (default: 140.0)
* **Behavior:** Renders the cartoon judge mascot with animated facial expressions and subtle breathing idle animation.

### 2. `GavelStrikeAction`
* **Props:**
  * `onStrikeComplete`: `VoidCallback`
  * `autoPlay`: `bool`
* **Behavior:** Animates the gavel striking the sound block with camera screen-shake and optional haptic click.

### 3. `ArgumentScrollCard`
* **Props:**
  * `partyType`: `PartyType` (`plaintiff`, `defendant`)
  * `partyName`: `String`
  * `argumentText`: `String`
  * `isHighlighted`: `bool`
* **Behavior:** Styled parchment card representing the written testimony of the plaintiff or defendant during trial.

### 4. `VerdictStamp`
* **Props:**
  * `verdictType`: `VerdictType`
  * `animated`: `bool`
* **Behavior:** A rubber-stamp graphic (`GUILTY`, `NOT GUILTY`, `BOTH GUILTY`, `DISMISSED`) that stamps onto the screen with a bounce-in and rotation effect.

### 5. `SuggestedCaseCard`
* **Props:**
  * `suggestedCase`: `SuggestedCase`
  * `onSelected`: `ValueChanged<SuggestedCase>`
* **Behavior:** Horizontal card on Home Screen displaying a funny pre-made case prompt with a "Try This Case" button.

### 6. `VerdictShareCard`
* **Props:**
  * `courtCase`: `Case`
  * `verdict`: `Verdict`
* **Behavior:** Fixed-ratio ($1080 \times 1350$) offscreen or preview card designed specifically for high-resolution image capture.
