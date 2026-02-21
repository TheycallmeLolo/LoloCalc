library(shiny)

calc_css <- "
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@300;400;600&family=Tajawal:wght@300;400;700&display=swap');

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: 'Tajawal', sans-serif;
  background: #d6dce6;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 24px;
  gap: 16px;
}

.about-bar { width: 360px; display: flex; justify-content: flex-end; }
.about-us-btn {
  font-family: 'Tajawal', sans-serif !important;
  font-size: 1.5rem !important; font-weight: 700 !important;
  padding: 6px 16px !important; background: #2e2e2e !important;
  color: #fff !important; border: none !important; border-radius: 6px !important;
  cursor: pointer; transition: background 0.15s;
}
.about-us-btn:hover { background: #4a8c3f !important; }

.modal-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 9999; align-items: center; justify-content: center; }
.modal-overlay.open { display: flex; }
.modal-box { background: #1e1e1e; border-radius: 12px; box-shadow: 0 20px 60px rgba(0,0,0,0.5); width: 340px; max-height: 85vh; display: flex; flex-direction: column; overflow: hidden; animation: modalIn 0.2s ease; }
@keyframes modalIn { from { opacity:0; transform: scale(0.93) translateY(16px); } to { opacity:1; transform: scale(1) translateY(0); } }
.modal-header { background: #4a8c3f; padding: 20px 24px 16px; text-align: center; }
.modal-title { font-family: 'IBM Plex Mono', monospace; font-size: 2rem; font-weight: 600; color: #fff; letter-spacing: 0.08em; }
.modal-subtitle { font-size: 0.8rem; color: rgba(255,255,255,0.6); margin-top: 4px; }
.modal-body { padding: 20px; overflow-y: auto; flex: 1; }
.modal-body::-webkit-scrollbar { width: 4px; }
.modal-body::-webkit-scrollbar-thumb { background: #4a8c3f; border-radius: 4px; }
.team-label { font-size: 2rem; font-weight: 700; letter-spacing: 0.15em; text-transform: uppercase; color: #888; margin-bottom: 12px; }
.team-list { display: flex; flex-direction: column; gap: 8px; margin-bottom: 20px; }
.member-card { display: flex; align-items: center; gap: 12px; background: #2a2a2a; border-radius: 8px; padding: 10px 14px; }
.member-avatar { width: 38px; height: 38px; border-radius: 50%; background: #4a8c3f; color: #fff; font-family: 'IBM Plex Mono', monospace; font-size: 1.5rem; font-weight: 600; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.member-name { font-size: 2rem; font-weight: 700; color: #f0f0f0; }
.member-num { font-family: 'IBM Plex Mono', monospace; font-size: 1.5rem; color: #888; margin-top: 2px; }
.modal-close-btn { width: 100%; padding: 11px !important; font-family: 'Tajawal', sans-serif !important; font-size: 2rem !important; font-weight: 700 !important; background: #4a8c3f !important; color: white !important; border: none !important; border-radius: 8px !important; cursor: pointer; }
.modal-close-btn:hover { filter: brightness(1.15); }

.Lolo-wrap { background: #1c1c1c; border-radius: 20px; width: 360px; padding: 24px 20px 28px; box-shadow: 0 8px 40px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.06); }
.Lolo-brand { color: #fff; font-size: 2.6rem; font-weight: 900; letter-spacing: 0.04em; font-family: Arial Black, sans-serif; }
.Lolo-model { color: #aaa; font-size: 1.6rem; letter-spacing: 0.12em; margin-top: 2px; margin-bottom: 14px; }

.display { background: #8fad7a; border-radius: 6px; padding: 10px 14px; margin-bottom: 18px; min-height: 80px; display: flex; flex-direction: column; justify-content: flex-end; box-shadow: inset 0 2px 8px rgba(0,0,0,0.25); }
.disp-expr { font-family: 'IBM Plex Mono', monospace; font-size: 2rem; color: rgba(30,50,20,0.6); min-height: 18px; direction: ltr; text-align: right; word-break: break-all; }
.disp-main { font-family: 'IBM Plex Mono', monospace; font-size: 1.8rem; font-weight: 400; color: #1a2a10; direction: ltr; text-align: right; word-break: break-all; line-height: 1.15; margin-top: 2px; transition: color 0.15s; }
.disp-main.err { color: #8b0000; font-size: 2rem; }

.shiny-input-container { display: none !important; }

.calc-btn {
  font-family: 'IBM Plex Mono', monospace !important;
  font-size: 2rem !important; font-weight: 600 !important;
  height: 58px; width: 100%;
  border: none !important; border-radius: 8px !important;
  cursor: pointer; transition: all 0.08s ease;
  outline: none !important; padding: 0 !important;
  display: flex !important; align-items: center; justify-content: center;
}
.calc-btn:active { transform: translateY(2px); }

.btn-num { background: #f0f0f0 !important; color: #111 !important; box-shadow: 0 3px 0 #999 !important; }
.btn-num:hover { background: #fff !important; }
.btn-num:active { box-shadow: 0 1px 0 #999 !important; }

.btn-op { background: #f0f0f0 !important; color: #111 !important; box-shadow: 0 3px 0 #999 !important; font-size: 2rem !important; }
.btn-op:hover { background: #fff !important; }
.btn-op:active { box-shadow: 0 1px 0 #999 !important; }

.btn-fn { background: #2e2e2e !important; color: #ddd !important; font-size: 2rem !important; box-shadow: 0 3px 0 #111 !important; }
.btn-fn:hover { background: #3a3a3a !important; }
.btn-fn:active { box-shadow: 0 1px 0 #111 !important; }

.btn-del-g { background: #4a8c3f !important; color: #fff !important; box-shadow: 0 3px 0 #2d5c25 !important; }
.btn-del-g:hover { background: #5aa34d !important; }
.btn-del-g:active { box-shadow: 0 1px 0 #2d5c25 !important; }

.btn-ac { background: #4a8c3f !important; color: #fff !important; box-shadow: 0 3px 0 #2d5c25 !important; }
.btn-ac:hover { background: #5aa34d !important; }
.btn-ac:active { box-shadow: 0 1px 0 #2d5c25 !important; }

.btn-eq { background: #555 !important; color: #fff !important; box-shadow: 0 3px 0 #222 !important; font-size: 2rem !important; grid-column: 4 / 6; }
.btn-eq:hover { background: #666 !important; }
.btn-eq:active { box-shadow: 0 1px 0 #222 !important; }

.numpad { display: grid; grid-template-columns: repeat(5, 1fr); gap: 8px; }

@keyframes pop { 0% { opacity:0.5; transform:scale(0.97); } 100% { opacity:1; transform:scale(1); } }
.flash { animation: pop 0.15s ease; }
"

ui <- fluidPage(
  title = "Lolo fx-01AB",
  tags$head(tags$style(HTML(calc_css))),

  div(id = "about-modal", class = "modal-overlay",
      div(class = "modal-box",
          div(class = "modal-header",
              div(class = "modal-title", "ABOUT US"),
              div(class = "modal-subtitle", "Scientific Calculator — Development Team")
          ),
          div(class = "modal-body",
              div(class = "team-label", "Team Members"),
              div(class = "team-list",
                  div(class = "member-card", div(class = "member-avatar", "AA"), div(div(class = "member-name", "Ali Abdelbasir (Lolo)"),    div(class = "member-num", "#01"))),
              ),
              tags$button(class = "modal-close-btn",
                          onclick = "document.getElementById('about-modal').classList.remove('open')",
                          "CLOSE")
          )
      )
  ),

  div(class = "about-bar",
      tags$button(class = "about-us-btn",
                  onclick = "document.getElementById('about-modal').classList.add('open')",
                  "About Us")
  ),

  div(class = "Lolo-wrap",
      div(class = "Lolo-brand", "LoloCalc"),
      div(class = "Lolo-model", "fx-01AB LOLO"),

      div(class = "display",
          div(id = "disp-expr", class = "disp-expr", "\u00a0"),
          div(id = "disp-main", class = "disp-main", "0")
      ),

      div(class = "numpad",
          # Row 1: 7 8 9 DEL AC
          actionButton("btn_7",   "7",          class = "calc-btn btn-num"),
          actionButton("btn_8",   "8",          class = "calc-btn btn-num"),
          actionButton("btn_9",   "9",          class = "calc-btn btn-num"),
          actionButton("btn_del", "DEL",        class = "calc-btn btn-del-g"),
          actionButton("btn_clr", "AC",         class = "calc-btn btn-ac"),

          # Row 2: 4 5 6 × ÷
          actionButton("btn_4",   "4",          class = "calc-btn btn-num"),
          actionButton("btn_5",   "5",          class = "calc-btn btn-num"),
          actionButton("btn_6",   "6",          class = "calc-btn btn-num"),
          actionButton("btn_mul", "\u00d7",     class = "calc-btn btn-op"),
          actionButton("btn_div", "\u00f7",     class = "calc-btn btn-op"),

          # Row 3: 1 2 3 + −
          actionButton("btn_1",   "1",          class = "calc-btn btn-num"),
          actionButton("btn_2",   "2",          class = "calc-btn btn-num"),
          actionButton("btn_3",   "3",          class = "calc-btn btn-num"),
          actionButton("btn_add", "+",          class = "calc-btn btn-op"),
          actionButton("btn_sub", "\u2212",     class = "calc-btn btn-op"),

          # Row 4: 0 . x! (blank) =
          actionButton("btn_0",   "0",          class = "calc-btn btn-num"),
          actionButton("btn_dot", ".",          class = "calc-btn btn-num"),
          actionButton("btn_fact","x!",         class = "calc-btn btn-fn"),
          actionButton("btn_eq",  "=",          class = "calc-btn btn-eq")
      )
  ),

  tags$div(style = "display:none;", textInput("js_token", NULL, "")),

  tags$script(HTML("
  // Expression-based engine with proper precedence (* / before + -)
  var expr = '';
  var justCalc = false;

  function mainEl() { return document.getElementById('disp-main'); }
  function exprEl() { return document.getElementById('disp-expr'); }

  function setMain(val, isErr) {
    var el = mainEl();
    el.textContent = val;
    el.className = 'disp-main' + (isErr ? ' err' : '');
    el.classList.remove('flash');
    void el.offsetWidth;
    el.classList.add('flash');
  }

  function setExpr(val) {
    exprEl().textContent = val || '\\u00a0';
  }

  // Evaluate with proper precedence
  function evaluate(str) {
    var tokens = [];
    var i = 0;
    while (i < str.length) {
      if (str[i] === ' ') { i++; continue; }
      if (/[0-9.]/.test(str[i])) {
        var num = '';
        while (i < str.length && /[0-9.]/.test(str[i])) num += str[i++];
        tokens.push({ t: 'n', v: parseFloat(num) });
      } else if (['+','-','*','/'].includes(str[i])) {
        tokens.push({ t: 'o', v: str[i++] });
      } else { i++; }
    }
    if (!tokens.length) return NaN;

    // Pass 1: * and /
    var p1 = [];
    for (var j = 0; j < tokens.length; j++) {
      if (tokens[j].t === 'o' && (tokens[j].v === '*' || tokens[j].v === '/')) {
        var L = p1.pop();
        var R = tokens[++j];
        if (!L || !R || L.t !== 'n' || R.t !== 'n') return NaN;
        var r = tokens[j-1].v === '*' ? L.v * R.v : (R.v === 0 ? Infinity : L.v / R.v);
        p1.push({ t: 'n', v: r });
      } else { p1.push(tokens[j]); }
    }

    // Pass 2: + and -
    if (!p1.length || p1[0].t !== 'n') return NaN;
    var result = p1[0].v;
    for (var k = 1; k < p1.length; k += 2) {
      if (p1[k].t !== 'o' || !p1[k+1] || p1[k+1].t !== 'n') return NaN;
      if (p1[k].v === '+') result += p1[k+1].v;
      else result -= p1[k+1].v;
    }
    return result;
  }

  function fmtNum(n) {
    if (!isFinite(n) || isNaN(n)) return 'Math Error';
    if (Math.abs(n) >= 1e12 || (Math.abs(n) < 1e-7 && n !== 0)) return n.toExponential(6);
    return String(parseFloat(n.toPrecision(10)));
  }

  function toDisplay(s) {
    return s.replace(/\\*/g,'\\u00d7').replace(/\\//g,'\\u00f7').replace(/-/g,'\\u2212');
  }

  function endsWithOp() { return /[+\\-*\\/]$/.test(expr); }

  function getLastNum() {
    var m = expr.match(/([0-9.]+)$/);
    return m ? parseFloat(m[1]) : null;
  }

  function replaceLastNum(newVal) {
    return expr.replace(/([0-9.]+)$/, String(newVal));
  }

  function getCurrentNum() {
    var m = expr.match(/([0-9.]+)$/);
    return m ? m[1] : '0';
  }

  Shiny.addCustomMessageHandler('token', function(t) {

    if (t === 'AC') {
      expr = ''; justCalc = false;
      setMain('0', false); setExpr('\\u00a0'); return;
    }

    if (t === 'DEL') {
      if (justCalc) { expr = ''; justCalc = false; setMain('0', false); setExpr('\\u00a0'); return; }
      if (expr.length > 0) expr = expr.slice(0, -1);
      if (expr === '') { setMain('0', false); setExpr('\\u00a0'); }
      else { setMain(endsWithOp() ? '0' : getCurrentNum(), false); setExpr(toDisplay(expr)); }
      return;
    }

    if (/^[0-9]$/.test(t)) {
      if (justCalc) { expr = t; justCalc = false; setMain(t, false); setExpr('\\u00a0'); return; }
      var m = expr.match(/([0-9.]+)$/);
      if (m && m[1].replace('.','').length >= 12) return;
      expr += t;
      setMain(getCurrentNum(), false);
      setExpr(toDisplay(expr));
      return;
    }

    if (t === '.') {
      if (justCalc) { expr = '0.'; justCalc = false; setMain('0.', false); setExpr('\\u00a0'); return; }
      if (endsWithOp() || expr === '') expr += '0.';
      else {
        var m = expr.match(/([0-9.]+)$/);
        if (m && m[1].includes('.')) return;
        expr += '.';
      }
      setMain(getCurrentNum(), false);
      setExpr(toDisplay(expr));
      return;
    }

    if (['+','-','*','/'].includes(t)) {
      if (expr === '' && t !== '-') return;
      if (expr === '' && t === '-') { expr = '-'; setMain('-', false); return; }
      if (justCalc) justCalc = false;
      if (endsWithOp()) expr = expr.slice(0, -1);
      expr += t;
      setExpr(toDisplay(expr));
      return;
    }

    if (t === 'FACT') {
      if (expr === '' || endsWithOp()) return;
      var val = getLastNum();
      if (val === null || isNaN(val) || val < 0 || Math.floor(val) !== val) {
        setMain('\\u062e\\u0637\\u0623 \\u0631\\u064a\\u0627\\u0636\\u064a', true); return;
      }
      if (val > 170) { setMain('Math Error', true); return; }
      var f = 1;
      for (var i = 2; i <= val; i++) f *= i;
      expr = replaceLastNum(f);
      setMain(fmtNum(f), false);
      setExpr(toDisplay(expr));
      justCalc = false;
      return;
    }

    if (t === '=') {
      if (expr === '' || endsWithOp()) return;
      var fullExpr = toDisplay(expr) + ' =';
      var res = evaluate(expr);
      var resStr = fmtNum(res);
      var isErr = resStr === 'Math Error';
      setExpr(fullExpr);
      setMain(resStr, isErr);
      if (!isErr) {
        expr = String(res);
        justCalc = true;
      } else {
        expr = '';
      }
      return;
    }
  });
  "))
)

server <- function(input, output, session) {
  send <- function(token) session$sendCustomMessage("token", token)

  for (d in 0:9) {
    local({
      digit <- as.character(d)
      btn_id <- paste0("btn_", digit)
      observeEvent(input[[btn_id]], { send(digit) }, ignoreInit = TRUE)
    })
  }

  observeEvent(input$btn_dot,  { send(".") },    ignoreInit = TRUE)
  observeEvent(input$btn_clr,  { send("AC") },   ignoreInit = TRUE)
  observeEvent(input$btn_del,  { send("DEL") },  ignoreInit = TRUE)
  observeEvent(input$btn_add,  { send("+") },    ignoreInit = TRUE)
  observeEvent(input$btn_sub,  { send("-") },    ignoreInit = TRUE)
  observeEvent(input$btn_mul,  { send("*") },    ignoreInit = TRUE)
  observeEvent(input$btn_div,  { send("/") },    ignoreInit = TRUE)
  observeEvent(input$btn_eq,   { send("=") },    ignoreInit = TRUE)
  observeEvent(input$btn_fact, { send("FACT") }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)