
# 🧮 LOLOCALC – Scientific Calculator (Shiny + JavaScript)

**LOLOCALC** is a modern scientific calculator built using **R Shiny** with a custom JavaScript-based calculation engine.

It combines a CASIO-inspired design with smooth UI interactions and correct mathematical precedence handling.

---

## 🚀 Features

* Basic arithmetic operations (+ − × ÷)
* Parentheses with automatic balancing
* Square root (√)
* Cube root (∛)
* Factorial (x!)
* π constant support
* Ans (last result memory)
* Decimal number support
* Proper operator precedence
* Scientific notation for very large/small numbers
* Math Error detection and handling
* Animated button press effects
* Custom "About Us" modal with blur background
* Responsive centered layout

---

## 🛠️ Built With

* **R**
* **Shiny**
* **Vanilla JavaScript (Custom Expression Engine)**
* **HTML5**
* **Custom CSS (Grid Layout + Animations)**

---

## 📸 Screenshot

<img width="574" height="631" alt="Image" src="https://github.com/user-attachments/assets/2bb7cbf4-c20a-45ff-93c1-da03c72bf579" />
---

## ▶️ How to Run

### 1️⃣ Install Shiny

```r
install.packages("shiny")
```

### 2️⃣ Run the Application

```r
shiny::runApp()
```

Or open `app.R` in RStudio and click **Run App**.

---

## 📂 Project Structure

```
app.R
README.md
```

---

## 🧠 Technical Notes

* Expression evaluation is handled entirely in JavaScript.
* Safe evaluation is performed using controlled execution (no direct user `eval` input).
* Parentheses are automatically closed before calculation.
* Factorial is limited to 170 to prevent numeric overflow.
* Scientific notation appears automatically for extreme values.
* R acts only as a message bridge between UI buttons and the JavaScript engine.

---

## 👨‍💻 Author

Ali Abdelbasir (Lolo)

---

## 📌 Future Improvements

* Add sin / cos / tan
* DEG / RAD mode toggle
* Power (^) operator
* Calculation history panel
* Keyboard input support
* Memory functions (M+, M-, MR)
* Deploy to shinyapps.io or convert to desktop app
---

## 📌 Notes

* Expression engine is implemented manually (no eval used).
* Factorial supports values up to 170 (to avoid overflow).
* Scientific notation automatically appears for very large/small numbers.

