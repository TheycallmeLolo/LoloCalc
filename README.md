

# 🧮 LoloCalc – Scientific Calculator (Shiny + JavaScript)

LoloCalc is a modern scientific calculator built using **R Shiny** with a custom JavaScript expression engine.

It features a clean UI inspired by classic scientific calculators with a smooth user experience and proper mathematical precedence handling.

---

## 🚀 Features

* Basic arithmetic operations (+ − × ÷)
* Factorial (x!)
* Decimal support
* Proper operator precedence (* and / before + and -)
* Error handling (Math Error detection)
* Responsive grid layout
* Animated display updates
* Custom modal "About Us" section
* Clean CASIO-inspired interface

---

## 🛠️ Built With

* **R**
* **Shiny**
* **JavaScript (Custom Expression Parser)**
* **Custom CSS Grid Layout**
* Google Fonts (IBM Plex Mono & Tajawal)

---

## 📸 Screenshot


<img width="796" height="749" alt="Image" src="https://github.com/user-attachments/assets/7dc83c47-9c14-4ae3-8777-bbd927e7a4f8" />

---

## ▶️ How to Run

1. Install R and Shiny:

```r
install.packages("shiny")
```

2. Run the app:

```r
shiny::runApp()
```

---

## 📂 Project Structure

```
app.R
README.md
screenshot.png
```

---

## 👨‍💻 Author

Ali Abdelbasir (Lolo)

---

## 📌 Notes

* Expression engine is implemented manually (no eval used).
* Factorial supports values up to 170 (to avoid overflow).
* Scientific notation automatically appears for very large/small numbers.

