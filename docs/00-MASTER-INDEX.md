# Tiny Court — Documentation Master Index

| Field | Value |
|---|---|
| Project | **Tiny Court** (Flutter MVP) |
| Tagline | *"Every silly argument deserves its day in court."* |
| Standard Reference | `pogo_alarm` (`/app/docs/`) Architectural Specification Standard |
| Status | **Active Planning Phase** |
| Target Framework | Flutter 3.13+ / Dart 3.1+ |
| State Management | Flutter Riverpod (`Notifier` / `AsyncNotifier`) |
| Data Layer | `built_value`, `built_collection`, `shared_preferences` |
| Navigation | `go_router` & `go_router_builder` |

---

## 1. Documentation Structure

This documentation suite establishes the binding technical, functional, and design specifications for Tiny Court prior to implementation.

```
docs/
├── 00-MASTER-INDEX.md (This File)
│
├── service_plans/
│   ├── 00-service-architecture-and-base-contracts.md
│   ├── 01-case-crud-service-contract.md
│   ├── 02-verdict-engine-and-rules-spec.md
│   ├── 03-verdict-service-and-idempotency-contract.md
│   ├── 04-database-schema-storage-and-er-diagram.md
│   └── 05-preferences-and-settings-contract.md
│
├── state_machine_vm_plan/
│   ├── 00-state-machine-vm-plan.md
│   ├── 01-case-draft-wizard-vm.md
│   ├── 02-courtroom-orchestrator-state-machine.md
│   └── 03-case-history-and-filter-vm.md
│
├── ui_design_system/
│   ├── TC-00-tokens-and-courtroom-theme.md
│   └── TC-01-courtroom-ds-primitives.md
│
└── ui_master_plan/
    ├── 00-master-plan.md
    ├── 01-app-components.md
    ├── 02-routes-and-navigation.md
    ├── 03-screens-and-flows.md
    └── 04-share-card-and-qa.md
```

---

## 2. Document Set Directory

### Set 1: Service Plans & Data Layer (`service_plans/`)
- [`00-service-architecture-and-base-contracts.md`](service_plans/00-service-architecture-and-base-contracts.md): Core architectural tiers, base `Service` interface, and domain exception hierarchy.
- [`01-case-crud-service-contract.md`](service_plans/01-case-crud-service-contract.md): Complete CRUD operations for cases (`createCase`, `getCaseById`, `getAllCases`, `updateCase`, `deleteCase`, `submitCase`).
- [`02-verdict-engine-and-rules-spec.md`](service_plans/02-verdict-engine-and-rules-spec.md): Pure Dart `VerdictEngine` specification, decision rules, comedic punishments catalog, and determinism.
- [`03-verdict-service-and-idempotency-contract.md`](service_plans/03-verdict-service-and-idempotency-contract.md): `VerdictService` orchestrator, idempotency enforcement (generate once, persist forever), and verdict queries.
- [`04-database-schema-storage-and-er-diagram.md`](service_plans/04-database-schema-storage-and-er-diagram.md): Entity-Relationship Diagram (ERD), SharedPreferences key partitioning architecture, and JSON serialization.
- [`05-preferences-and-settings-contract.md`](service_plans/05-preferences-and-settings-contract.md): User preferences service (sound, haptics, theme).

### Set 2: State Machine & ViewModels (`state_machine_vm_plan/`)
- [`00-state-machine-vm-plan.md`](state_machine_vm_plan/00-state-machine-vm-plan.md): State management architecture with Riverpod, ViewModel contracts, and immutable states.
- [`01-case-draft-wizard-vm.md`](state_machine_vm_plan/01-case-draft-wizard-vm.md): Multi-step case creation wizard state machine (Overview, Plaintiff, Defendant, Review).
- [`02-courtroom-orchestrator-state-machine.md`](state_machine_vm_plan/02-courtroom-orchestrator-state-machine.md): 6-stage courtroom sequence orchestrator (Entrance $\rightarrow$ Arguments $\rightarrow$ Deliberation $\rightarrow$ Gavel Reveal).
- [`03-case-history-and-filter-vm.md`](state_machine_vm_plan/03-case-history-and-filter-vm.md): Case history listing, category/status filtering, search querying, and deletion state.

### Set 3: UI Design System (`ui_design_system/`)
- [`TC-00-tokens-and-courtroom-theme.md`](ui_design_system/TC-00-tokens-and-courtroom-theme.md): Color palette (Court Navy, Gavel Gold, Parchment Cream), typography scales, elevation, and radii.
- [`TC-01-courtroom-ds-primitives.md`](ui_design_system/TC-01-courtroom-ds-primitives.md): Courtroom-themed atomic UI primitives (Buttons, Cards, Banners, Badges, Dividers).

### Set 4: UI Master Plan & Execution Phases (`ui_master_plan/`)
- [`00-master-plan.md`](ui_master_plan/00-master-plan.md): Phased execution roadmap with parent tasks, subtasks, and minute-by-minute AI-assisted estimates.
- [`01-app-components.md`](ui_master_plan/01-app-components.md): Feature widgets (`JudgeMascotView`, `GavelStrikeAction`, `ArgumentScrollCard`, `VerdictStamp`).
- [`02-routes-and-navigation.md`](ui_master_plan/02-routes-and-navigation.md): Typed GoRouter route definitions, IndexedStack navigation tabs, nested child routes, and parameter handling.
- [`03-screens-and-flows.md`](ui_master_plan/03-screens-and-flows.md): Screen-by-screen UX specifications, layout contracts, and error/empty states.
- [`04-share-card-and-qa.md`](ui_master_plan/04-share-card-and-qa.md): `RepaintBoundary` social card export, `share_plus` integration, and QA test plan.
