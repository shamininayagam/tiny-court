# Courtroom Theme & Design Tokens

| Field | Value |
|---|---|
| Spec | Design Tokens, Color Palette, Typography & Theme Spec |
| Target Path | `lib/utils/app_constants.dart` & `lib/ui.dart` |
| Reference | `pogo_alarm/app/docs/ui_design_system/LS-00-tokens-theme.md` |

---

## 1. Color Palette: Courtroom Classic

The visual identity blends traditional courtroom dignity with playful cartoon whimsy:

```
┌────────────────────────────────────────────────────────┐
│                      CORE PALETTE                      │
├─────────────────┬───────────────────┬──────────────────┤
│ Court Navy      │ #1A2238           │ Primary surfaces │
│ Gavel Gold      │ #E6B042           │ Accents & badges │
│ Parchment Cream │ #FBF8F1           │ Card containers  │
│ Walnut Wood     │ #3D2314           │ Judicial podium  │
│ Guilty Red      │ #D32F2F           │ Conviction stamp │
│ Acquittal Green │ #2E7D32           │ Not guilty stamp │
│ Ink Black       │ #1C1B1F           │ High-contrast text│
└─────────────────┴───────────────────┴──────────────────┘
```

---

## 2. Typography Scales

* **Headlines / Pronouncements:** Heavy serif weight (e.g. *Playfair Display* / *Georgia* fallback) conveying courtroom gravitas.
* **Arguments / Body:** Crisp geometric sans-serif (e.g. *Inter* / *Roboto*) for effortless readability.
* **Stamps:** Bold condensed uppercase with letter spacing and slight rotation.

---

## 3. Surface & Elevation Tokens

* **Parchment Surface:** Border radius: `16dp`, border: `1.5dp` solid `#E8DFD0`, background: `#FBF8F1`.
* **Elevated Court Podium:** Elevation `4dp`, shadow color: `rgba(26, 34, 56, 0.12)`.
* **Rubber Stamp Effect:** Border: `3dp` dashed/solid, transform: `Matrix4.rotationZ(-0.08)`.
