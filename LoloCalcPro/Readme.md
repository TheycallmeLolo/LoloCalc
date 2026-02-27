# LoloCalcPro 🧮
### fx-01AB PLUS · L.O.L.O Edition
> A fully-featured scientific calculator built with R Shiny — runs in any browser, feels like a real calculator.

**Developed by:** Ali Abdelbasir (Lolo) · #01

---

## 📋 Overview

LoloCalcPro is a scientific calculator web application built entirely in R Shiny. It features a realistic LCD-style display, tactile button press animations, a live calculation history sidebar, full keyboard support, memory functions, and trigonometric operations — all in a single self-contained `.R` file.

---
##ScreenShot



---

## ✨ Features

| Feature | Keyboard | Description |
|---|---|---|
| **sin / cos / tan** | `s` `c` `t` | Trig functions — respects DEG/RAD mode |
| **DEG / RAD toggle** | `d` | Pill toggle top-left; screen indicator updates live |
| **Power x^y** | `^` | Raises current value to an exponent |
| **log (base-10)** | `l` | Inserts `log(` |
| **Square root √** | `r` | Inserts `√(` |
| **Cube root ∛** | — | Button only |
| **Factorial x!** | — | Evaluates trailing integer immediately |
| **Parentheses** | `(` `)` | Auto multiply-insert; auto-close on `=` |
| **Pi (π)** | `p` | Full 15-digit constant, displayed as π |
| **Answer (Ans)** | `a` | Recalls last result into expression |
| **Memory MS/MR/M+/M−/MC** | — | Five blue memory buttons; M lights on screen |
| **History panel** | — | Last 60 calculations; click any to recall |
| **Keyboard input** | Full support | See keyboard reference below |
| **AC / DEL** | `Escape` / `Backspace` | AC clears all; DEL removes last token |

---

## ⌨️ Keyboard Reference

| Key(s) | Action |
|---|---|
| `0`–`9`  `.` | Digit / decimal input |
| `+`  `-`  `*`  `/` | Arithmetic operators |
| `^` | Power (x^y) |
| `(`  `)` | Parentheses |
| `Enter` or `=` | Evaluate expression |
| `Backspace` | Delete last character / token |
| `Escape` | AC — clear everything |
| `s` | Insert sin( |
| `c` | Insert cos( |
| `t` | Insert tan( |
| `r` | Insert √( |
| `l` | Insert log( |
| `p` | Insert π |
| `a` | Insert Ans (last result) |
| `d` | Toggle DEG / RAD mode |

---

## 🚀 Installation & Running Locally

### Prerequisites
- R 4.1 or later → [cran.r-project.org](https://cran.r-project.org)
- The `shiny` package:

```r
install.packages("shiny")
```

### Run
```r
shiny::runApp("calculator_app.R")
```

## 🖥️ Convert to Desktop App

```r
install.packages("electricShine")

electricShine::electrify(
  app_name          = "LoloCalcPro",
  short_description = "Scientific Calculator",
  semantic_version  = "1.0.0",
  app_dir           = getwd()
)
```

---

## 🧠 Memory Functions

| Button | Action |
|---|---|
| **MS** | Store current result in memory (M lights up) |
| **MR** | Recall memory value into expression |
| **M+** | Add current result to memory |
| **M−** | Subtract current result from memory |
| **MC** | Clear memory (M turns off) |

---

## 📜 History Panel

- Stores the **last 60 calculations** in reverse order
- Each entry shows the expression and its result
- **Click any entry** to paste its result as current input
- **Clear** button wipes all history
- Session-only — resets on page refresh

---

## 📐 Angle Modes

| Mode | Behaviour |
|---|---|
| **DEG** (default) | Input treated as degrees → multiplied by π/180 internally |
| **RAD** | Input passed directly to Math.sin/cos/tan |

Toggle with the pill buttons or press `d`. Current mode shown on the LCD screen.

---

## ⚠️ Known Limitations

- No inverse trig (sin⁻¹, cos⁻¹, tan⁻¹) yet
- No natural log (ln) — only log₁₀
- History does not persist across page refreshes
- Factorial limited to n ≤ 170 (above returns Math Error)
- Results rounded to 10 significant figures

---

## 📁 File Structure

```
LoloCalcPro.R    ← entire app (UI + Server + CSS + JS, self-contained)
README.md           ← this file
```

---

## 👤 Credits

| Role | |
|---|---|
| Lead Developer | Ali Abdelbasir (Lolo) — #01 |
| Framework | R Shiny (Posit) |
| Fonts | Share Tech Mono, Rajdhani (Google Fonts) |
| Design Inspiration | Casio fx-series scientific calculators |

---

## 📄 License

MIT License — free to use, modify, and distribute with attribution.

```
Copyright (c) 2026 Ali Abdelbasir (Lolo)
```