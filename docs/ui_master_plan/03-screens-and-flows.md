# Screens & User Journey Flows

| Field | Value |
|---|---|
| Spec | Screen Specifications, Layout Contracts & User Flows |
| Target Path | `lib/views/` |
| Reference | `pogo_alarm/app/docs/ui_master_plan/04-screens.md` |

---

## 1. Screen Inventory

| Route | Screen Name | ViewModel / Provider | Purpose |
|---|---|---|---|
| `/` | `HomeScreen` | `suggestedCasesProvider`, `recentCasesProvider` | Hero mascot, quick create CTA, template cards, recent cases |
| `/cases/create` | `CreateCaseScreen` | `caseDraftNotifierProvider` | Multi-step wizard (Overview $\rightarrow$ Plaintiff $\rightarrow$ Defendant) |
| `/cases/:id/review` | `ReviewCaseScreen` | `caseDraftNotifierProvider` | Docket summary before filing to court; edit hooks |
| `/courtroom/:id` | `CourtroomScreen` | `courtroomNotifierProvider` | 6-stage interactive trial, animations, deliberation, gavel reveal |
| `/verdict/:id` | `VerdictDetailsScreen` | `verdictProvider(id)` | Final decree, punishment, share button, return home CTA |
| `/cases` | `MyCasesScreen` | `caseHistoryNotifierProvider` | Case list with search bar and status/category filters |
| `/cases/:id` | `CaseDetailsScreen` | `caseByIdProvider(id)` | Historical case view with party arguments and saved verdict |
| `/settings` | `SettingsScreen` | `settingsNotifierProvider` | Sound, haptic, and theme preferences |

---

## 2. Key Screen Layout Contracts

### 1. `HomeScreen` (`/`)
* **Header:** Judge Mascot avatar + Welcome dialogue bubble (*"Order! Who broke what law of friendship today?"*).
* **Primary Action:** Elevated gold button: *"Start a New Case"*.
* **Suggested Cases Carousel:** Horizontal scrolling list of funny templates (*"Who ate the last pizza slice?"*, *"30-minute late flaker"*).
* **Recent Cases List:** Last 3 decided cases with verdict stamps.

### 2. `CourtroomScreen` (`/courtroom/:id`)
* **Background:** Courtroom wood-paneled courtroom bench.
* **Top Area:** Animated `JudgeMascotView` displaying active reaction dialogue.
* **Center Stage:** Dynamic argument cards sliding in based on active sequence stage.
* **Bottom Controls:** Progress indicators, "Skip to Verdict" button, and auto-play toggle.
