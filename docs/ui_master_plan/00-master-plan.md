# UI Master Plan — Phased Execution Blueprint

| Field | Value |
|---|---|
| Spec | Phased Execution Plan & Time-Boxed Estimates |
| Status | **Active** — binding execution blueprint for Tiny Court MVP |
| Reference | `pogo_alarm/app/docs/ui_master_plan/00-master-plan.md` |
| Estimate Model | AI-Assisted Wall Clock (Implementation + Test + Review loop) |

---

## 1. Phase Summary Table

| Phase | Description | Tasks | Min | Target Files |
|---|---|---:|---:|---|
| **Phase 1** | Core Contracts, Models & Serialization | 4 | **180** | `lib/model/`, `lib/core/services/` |
| **Phase 2** | Local Rule-Based Verdict Engine | 3 | **120** | `lib/core/engine/` |
| **Phase 3** | Storage Adapters & AppRepository | 3 | **120** | `lib/data/` |
| **Phase 4** | Navigation Scaffold & Typed GoRouter | 3 | **150** | `lib/views/navigation/` |
| **Phase 5** | Design System & Courtroom Primitives | 5 | **210** | `lib/views/widgets/ds/` |
| **Phase 6** | Courtroom Experience & Screen Flows | 5 | **300** | `lib/views/` |
| **Phase 7** | Case History, Search & Filtering | 3 | **120** | `lib/views/cases/` |
| **Phase 8** | Share Card Export & QA Verification | 4 | **150** | `lib/utils/share_utils.dart` |
| **TOTAL** | **Complete Polished MVP** | **30** | **1250 min (~20.8 h)** | |

---

## 2. Parent Tasks & Subtask Breakdowns

### Phase 1 · Core Contracts, Models & Serialization (180 min)
* **P1.1 Domain Enums & Built Value Models (60 min):**
  * `CaseCategory`, `CaseStatus`, `VerdictType` enums.
  * `Case`, `Verdict`, `SuggestedCase`, `AppSettings` models with `built_value`.
* **P1.2 Serializers & Round-Trip Tests (45 min):**
  * `serializers.dart` registry, JSON encode/decode unit tests in `test/unit/model_serialization_test.dart`.
* **P1.3 Service Interfaces & Exceptions (45 min):**
  * `CaseService`, `VerdictEngine`, `VerdictService`, `SettingsService`, and custom exceptions.
* **P1.4 Suggested Cases Fixture Catalog (30 min):**
  * 10 curated pre-baked comical disputes seeded in code.

### Phase 2 · Rule-Based Verdict Engine (120 min)
* **P2.1 Keyword Heuristics & Rules (50 min):**
  * Argument length analysis, food theft rules, flaking rules, seeded deterministic fallback.
* **P2.2 Comedic Punishment Catalog (35 min):**
  * 30+ humorous judgments and punishments across all 5 categories.
* **P2.3 Verdict Engine Unit Test Suite (35 min):**
  * 100% test coverage for rule mapping and determinism in `test/unit/verdict_engine_test.dart`.

### Phase 3 · Storage Adapters & AppRepository (120 min)
* **P3.1 Partitioned SharedPreferences Adapter (45 min):**
  * Case index, individual case JSON, verdict JSON, settings storage.
* **P3.2 AppRepository Wiring (45 min):**
  * `CaseServiceImpl`, `VerdictServiceImpl`, `SettingsServiceImpl`.
* **P3.3 Storage Idempotency & Persistence Tests (30 min):**
  * Integration tests verifying cases and verdicts survive app restart.

### Phase 4 · Navigation Scaffold & Typed GoRouter (150 min)
* **P4.1 Typed Routes with `go_router_builder` (50 min):**
  * Define all 8 route classes and generate route graph.
* **P4.2 Main Navigation Screen with IndexedStack (35 min):**
  * Scaffold with Home, My Cases, and Settings tabs managed via IndexedStack.
* **P4.3 Riverpod Notifier Wiring (65 min):**
  * Providers for active draft, courtroom session, case list, and settings.

### Phase 5 · Design System & Courtroom Primitives (210 min)
* **P5.1 Courtroom Tokens & Themes (35 min):**
  * Custom theme definitions, color constants, typography hierarchy.
* **P5.2 Judge Mascot & Gavel Widgets (60 min):**
  * Character expressions, animated gavel swing widget.
* **P5.3 Argument Scroll & Dialogue Banners (45 min):**
  * Parchment scroll cards, plaintiff/defendant badges.
* **P5.4 Verdict Stamps (40 min):**
  * Rubber-stamp drop animation, scale & shake effects.
* **P5.5 Primitives Gallery Smoke Tests (30 min):**
  * Visual verification of components in isolation.

### Phase 6 · Courtroom Experience & Screen Flows (300 min)
* **P6.1 Home Screen (60 min):**
  * Hero judge mascot, suggested case carousel, quick start CTA, recent cases.
* **P6.2 Case Creation Step Wizard (70 min):**
  * Details $\rightarrow$ Plaintiff $\rightarrow$ Defendant with inline validation.
* **P6.3 Case Review Screen (40 min):**
  * Review docket, edit hooks, and submission transition.
* **P6.4 Courtroom Experience (75 min):**
  * 6-stage choreographed presentation with auto-play and skip triggers.
* **P6.5 Verdict Details Screen (55 min):**
  * Comedic decree, punishment card, share action, home route.

### Phase 7 · Case History, Search & Filtering (120 min)
* **P7.1 Case History List & Status Badges (40 min):**
  * Status badges (`Draft`, `Submitted`, `Decided`).
* **P7.2 Category & Search Filtering (40 min):**
  * Instant reactive search across titles and party names.
* **P7.3 Case Details Read-Only View (40 min):**
  * Displays original arguments and persisted verdict.

### Phase 8 · Share Card Export & QA Verification (150 min)
* **P8.1 Verdict Card Generation & Share Sheet (50 min):**
  * `RepaintBoundary` image capture and `share_plus` native invocation.
* **P8.2 Settings Screen (35 min):**
  * Toggles for sound, haptics, theme.
* **P8.3 Haptic & SFX Integration (35 min):**
  * Gavel strike feedback and stamp haptics.
* **P8.4 Comprehensive QA & Sweep (30 min):**
  * Widget tests, analyzer sweep, zero warnings.
