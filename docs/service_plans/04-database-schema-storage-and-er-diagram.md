# Database Schema, SharedPreferences Partitioning & ER Diagram

| Field | Value |
|---|---|
| Spec | Local Persistence Architecture & Data Schema |
| Storage Backing | `SharedPreferences` (JSON Key-Value partitioned) |
| Serialization | `built_value` + `serializers.dart` |
| Reference | `pogo_alarm/app/docs/service_plans/04-database-schema-and-er-diagram.md` |

---

## 1. Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    cases ||--o| verdicts : "adjudicated by (1:0..1)"
    suggested_cases ||--o{ cases : "seeds (1:N)"
    app_settings ||--|| app_state : "configures (1:1)"

    cases {
        string id PK "UUID v4"
        string caseNumber UK "TC-YYYY-XXXXX format"
        string title "Dispute title"
        string description "Context of dispute nullable"
        string category "CaseCategory enum"
        string plaintiffName "Plaintiff display name"
        string plaintiffArgument "Prosecution claim"
        string defendantName "Defendant display name"
        string defendantArgument "Defense argument"
        string status "CaseStatus (draft, submitted, decided)"
        string verdictId FK "Nullable FK to verdicts.id"
        string suggestedCaseId FK "Nullable FK to suggested_cases.id"
        datetime createdAt "UTC timestamp"
        datetime updatedAt "UTC timestamp"
    }

    verdicts {
        string id PK "UUID v4"
        string caseId FK "FK to cases.id (unique)"
        string verdictType "VerdictType enum"
        string responsibleParties "Serialized BuiltList of names"
        string judgeStatement "Primary comical ruling"
        string explanation "Satirical legal rationale"
        string punishment "Humorous mandatory restitution"
        string closingRemark "Judge sign-off tag"
        string ruleId "ID of rule that triggered verdict"
        datetime generatedAt "UTC timestamp"
    }

    suggested_cases {
        string id PK "Static identifier e.g. 'sc_pizza_theft'"
        string title "Pre-baked dispute title"
        string description "Pre-baked context"
        string category "CaseCategory enum"
        string defaultPlaintiff "Default plaintiff name"
        string defaultDefendant "Default defendant name"
        string defaultPlaintiffArgument "Pre-baked plaintiff claim"
        string defaultDefendantArgument "Pre-baked defendant defense"
    }

    app_settings {
        boolean soundEnabled "Toggle SFX"
        boolean hapticsEnabled "Toggle haptic feedback"
        boolean animationsEnabled "Toggle rich animations"
        string themePreference "ThemeMode (light, dark, system)"
    }
```

---

## 2. SharedPreferences Key Partitioning Architecture

To prevent severe I/O lag caused by serializing a massive monolithic list into a single key on every write, storage is partitioned into distinct indexed documents:

| Key Pattern | Data Type | Description |
|---|---|---|
| `tc_index_case_ids` | `List<String>` | Master index of all saved case IDs in reverse chronological order. |
| `tc_case_{caseId}` | `String` (JSON) | Serialized JSON string for a single `Case` model. |
| `tc_verdict_{caseId}` | `String` (JSON) | Serialized JSON string for a single `Verdict` model. |
| `tc_settings` | `String` (JSON) | Serialized JSON string for `AppSettings`. |
| `tc_seq_case_number` | `int` | Monotonically incrementing integer for generating `TC-YYYY-XXXXX`. |

### Benefits of this partitioning:
1. **Granular Reads/Writes:** Creating or updating a single case does not serialize all other cases.
2. **Instant Deletion:** Deleting a case only removes `tc_case_{id}`, `tc_verdict_{id}`, and pops `{id}` from `tc_index_case_ids`.
3. **Seamless Future Migration:** When migrating from `SharedPreferences` to SQLite/Isar in later versions, the repository interface remains 100% identical.
