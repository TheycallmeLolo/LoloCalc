library(shiny)

# ── Deploy helper (uncomment & fill to push to shinyapps.io) ──────────────────
# rsconnect::setAccountInfo(name   = "YOUR_NAME",
#                           token  = "YOUR_TOKEN",
#                           secret = "YOUR_SECRET")
# rsconnect::deployApp()
# ─────────────────────────────────────────────────────────────────────────────

ui <- bootstrapPage(
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Rajdhani:wght@500;700;900&display=swap');

      *, *::before, *::after { box-sizing: border-box; }

      html, body {
        background-color: #d4dbe4 !important;
        margin: 0; padding: 0; min-height: 100vh;
        font-family: 'Rajdhani', sans-serif;
      }

      /* ── Outer layout ───────────────────────────────────── */
      .master-container {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding: 28px 16px 40px;
        gap: 16px;
        flex-wrap: wrap;
      }

      /* ── History sidebar ────────────────────────────────── */
      .history-panel {
        background: linear-gradient(160deg, #242526 0%, #1a1a1b 100%);
        width: 230px;
        border-radius: 18px;
        box-shadow: 8px 14px 32px rgba(0,0,0,0.45);
        padding: 16px 14px;
        display: flex;
        flex-direction: column;
        max-height: 640px;
        position: sticky;
        top: 28px;
      }
      .history-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #2e2e2e;
        padding-bottom: 8px;
        margin-bottom: 10px;
      }
      .history-title {
        color: #6fb05a;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 0.18em;
        text-transform: uppercase;
      }
      .hist-clear-btn {
        background: none;
        border: none;
        color: #6fb05a;
        font-size: 12px;
        font-family: 'Rajdhani', sans-serif;
        font-weight: 700;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        cursor: pointer;
        padding: 2px 6px;
        border-radius: 4px;
        transition: color 0.15s, background 0.15s;
      }
      .hist-clear-btn:hover { color: #e05555; background: rgba(224,85,85,.08); }
      .history-list {
        overflow-y: auto;
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 5px;
      }
      .history-list::-webkit-scrollbar       { width: 4px; }
      .history-list::-webkit-scrollbar-track { background: #1a1a1b; border-radius: 3px; }
      .history-list::-webkit-scrollbar-thumb { background: #6fb05a; border-radius: 3px; }
      .hist-empty {
        color: #3a3a3a;
        font-size: 13px;
        text-align: center;
        margin-top: 24px;
        font-style: italic;
        letter-spacing: 0.06em;
      }
      .hist-item {
        background: #222;
        border-radius: 8px;
        padding: 8px 10px;
        cursor: pointer;
        border-left: 2px solid transparent;
        transition: background 0.12s, border-color 0.12s;
      }
      .hist-item:hover { background: #2c2c2c; border-left-color: #6fb05a; }
      .hist-expr   { color: #555; font-family: 'Share Tech Mono', monospace; font-size: 9px; word-break: break-all; margin-bottom: 2px; }
      .hist-result { color: #d8d8d8; font-family: 'Share Tech Mono', monospace; font-size: 15px; font-weight: bold; word-break: break-all; }

      /* keyboard shortcut legend */
      .kbd-legend {
        margin-top: 12px;
        border-top: 1px solid #2a2a2a;
        padding-top: 10px;
      }
      .kbd-legend-title {
        color: #6fb05a;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        margin-bottom: 6px;
      }
      .kbd-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 3px;
      }
      .kbd-key  { background: #2e2e2e; color: #aaa; font-family: 'Share Tech Mono', monospace; font-size: 9px; padding: 1px 5px; border-radius: 3px; }
      .kbd-desc { color: #555; font-size: 9px; }

      /* ── Calculator body ────────────────────────────────── */
      .casio-body {
        background: linear-gradient(170deg, #2e2e2f 0%, #1a1a1b 100%);
        width: 370px;
        padding: 22px 18px 24px;
        border-radius: 22px;
        box-shadow: 10px 18px 40px rgba(0,0,0,0.55),
                    inset 0 1px 0 rgba(255,255,255,0.04);
        flex-shrink: 0;
      }

      /* top bar: mode toggle + About */
      .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
      }
      .mode-pill {
        display: flex;
        background: #111;
        border-radius: 20px;
        padding: 3px;
        gap: 2px;
        box-shadow: inset 0 2px 6px rgba(0,0,0,0.5);
      }
      .mode-btn {
        background: none;
        border: none;
        color: #555;
        font-family: 'Rajdhani', sans-serif;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 0.12em;
        padding: 3px 13px;
        border-radius: 16px;
        cursor: pointer;
        transition: all 0.18s;
      }
      .mode-btn.active { background: #6fb05a; color: #fff; box-shadow: 0 2px 8px rgba(111,176,90,0.45); }

      .about-btn {
        background: #2e2e2e;
        color: #aaa;
        border: none;
        border-radius: 6px;
        padding: 5px 12px;
        font-size: 11px;
        font-weight: 700;
        font-family: 'Rajdhani', sans-serif;
        letter-spacing: 0.08em;
        cursor: pointer;
        box-shadow: 0 3px 0 #0a0a0a;
        transition: background 0.15s, color 0.15s;
      }
      .about-btn:hover  { background: #6fb05a; color: #fff; }
      .about-btn:active { transform: translateY(3px); box-shadow: 0 0 0 #0a0a0a; }

      /* brand */
      .brand { color: #f0f0f0; font-weight: 900; font-size: 21px; letter-spacing: 0.06em; }
      .model { color: #555; font-size: 15px; font-style: italic; margin-bottom: 14px; letter-spacing: 0.04em; }

      /* screen */
      .screen-wrap {
        background: #8fa491;
        padding: 10px 13px 12px;
        border-radius: 10px;
        border: 3px solid #0d0d0d;
        margin-bottom: 18px;
        min-height: 90px;
        box-shadow: inset 4px 4px 12px rgba(0,0,0,0.35),
                    inset -1px -1px 4px rgba(255,255,255,0.08);
      }
      .screen-inds {
        display: flex;
        gap: 8px;
        margin-bottom: 4px;
      }
      .s-ind {
        font-size: 8px;
        font-weight: 700;
        font-family: 'Share Tech Mono', monospace;
        color: rgba(0,0,0,0.2);
        letter-spacing: 0.06em;
        transition: color 0.2s;
      }
      .s-ind.on { color: rgba(0,0,0,0.55); }
      .screen-expr {
        color: rgba(0,0,0,0.4);
        font-family: 'Share Tech Mono', monospace;
        font-size: 15px;
        text-align: right;
        min-height: 16px;
        word-break: break-all;
      }
      .screen-main {
        color: #111;
        font-family: 'Share Tech Mono', monospace;
        font-size: 28px;
        text-align: right;
        word-break: break-all;
        min-height: 36px;
        line-height: 1.1;
      }
      .screen-main.err { color: #7a0000; font-size: 15px; line-height: 1.4; }

      /* button grid rows */
      .btn-row {
        display: grid;
        gap: 5px;
        margin-bottom: 5px;
      }
      .cols-5 { grid-template-columns: repeat(5, 1fr); }

      /* buttons */
      .my-btn {
        border: none;
        border-radius: 6px;
        padding: 10px 2px;
        font-weight: 700;
        font-family: 'Rajdhani', sans-serif;
        font-size: 13px;
        letter-spacing: 0.02em;
        box-shadow: 0 4px 0 #080808;
        cursor: pointer;
        transition: transform 0.07s, box-shadow 0.07s, filter 0.1s;
        user-select: none;
      }
      .my-btn:active {
        transform: translateY(4px);
        box-shadow: 0 0 0 #080808;
      }
      .my-btn:hover { filter: brightness(1.12); }

      .btn-dark   { background: #2c2d2f; color: #e0e0e0; }
      .btn-num    { background: #e4e4e4; color: #111; font-size: 17px; }
      .btn-green  { background: #6fb05a; color: #fff; }
      .btn-blue   { background: #3d6090; color: #d0dff0; font-size: 12px; }
      .btn-eq     { background: #505050; color: #fff; font-size: 17px; }

      /* ── About modal ────────────────────────────────────── */
      .modal-overlay {
        position: fixed; inset: 0;
        background: rgba(0,0,0,0.72);
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
        z-index: 99999;
        display: none;
        align-items: center;
        justify-content: center;
      }
      .modal-overlay.open { display: flex !important; }
      .modal-box {
        background: #1e1e1e;
        border-radius: 18px;
        box-shadow: 0 28px 80px rgba(0,0,0,0.75);
        width: 320px; max-height: 78vh;
        display: flex; flex-direction: column; overflow: hidden;
        animation: mIn 0.28s cubic-bezier(0.34,1.4,0.64,1) forwards;
      }
      @keyframes mIn {
        from { opacity:0; transform:scale(0.82) translateY(28px); }
        to   { opacity:1; transform:scale(1)    translateY(0);    }
      }
      .modal-head { background:#6fb05a; padding:22px 22px 16px; text-align:center; flex-shrink:0; }
      .modal-head-title { color:#fff; font-size:1.5rem; font-weight:900; letter-spacing:0.14em; margin:0; font-family:'Rajdhani',sans-serif; }
      .modal-head-sub   { color:rgba(255,255,255,0.6); font-size:0.7rem; margin-top:5px; }
      .modal-body { padding:16px 16px 0; overflow-y:auto; flex:1; }
      .modal-body::-webkit-scrollbar       { width:5px; }
      .modal-body::-webkit-scrollbar-track { background:#252525; border-radius:4px; }
      .modal-body::-webkit-scrollbar-thumb { background:#6fb05a; border-radius:4px; }
      .team-lbl  { font-size:2rem; font-weight:700; letter-spacing:0.18em; text-transform:uppercase; color:#555; margin-bottom:10px; font-family:'Rajdhani',sans-serif; }
      .team-list { display:flex; flex-direction:column; gap:8px; margin-bottom:16px; }
      .member-card { display:flex; align-items:center; gap:12px; background:#252525; border-radius:8px; padding:10px 13px; transition:background 0.15s; }
      .member-card:hover { background:#2e2e2e; }
      .member-av   { width:36px; height:36px; border-radius:50%; background:#6fb05a; color:#fff; font-size:1.5rem; font-weight:700; display:flex; align-items:center; justify-content:center; flex-shrink:0; font-family:'Rajdhani',sans-serif; }
      .member-name { font-size:2rem; font-weight:700; color:#f0f0f0; line-height:1.1; font-family:'Rajdhani',sans-serif; }
      .member-num  { font-size:1.5rem; color:#555; margin-top:3px; }
      .modal-close-wrap { padding:14px 16px; flex-shrink:0; }
      .modal-close {
        width:100%; padding:11px;
        font-size:2rem; font-weight:700; letter-spacing:0.1em;
        background:#6fb05a; color:#fff;
        border:none; border-radius:8px;
        cursor:pointer;
        box-shadow:0 4px 0 #3c7a2c;
        transition:filter 0.1s, transform 0.1s, box-shadow 0.1s;
        font-family:'Rajdhani',sans-serif;
      }
      .modal-close:hover  { filter:brightness(1.12); }
      .modal-close:active { transform:translateY(3px); box-shadow:0 1px 0 #3c7a2c; }
    "))
  ),

  # ── About modal ──────────────────────────────────────────────────────────────
  tags$div(id = "about-modal", class = "modal-overlay",
    tags$div(class = "modal-box",
      tags$div(class = "modal-head",
        tags$div(class = "modal-head-title", "ABOUT US"),
        tags$div(class = "modal-head-sub", "Scientific Calculator \u2014 Development Team")
      ),
      tags$div(class = "modal-body",
        tags$div(class = "team-lbl", "Team Members"),
        tags$div(class = "team-list",
          tags$div(class = "member-card",
            tags$div(class = "member-av", "AA"),
            tags$div(
              tags$div(class = "member-name", "Ali Abdelbasir (Lolo)"),
              tags$div(class = "member-num", "#01")
            )
          )
        )
      ),
      tags$div(class = "modal-close-wrap",
        tags$button(class = "modal-close",
          onclick = "document.getElementById('about-modal').classList.remove('open');",
          "CLOSE"
        )
      )
    )
  ),

  # ── Page layout ──────────────────────────────────────────────────────────────
  tags$div(class = "master-container",

    # History sidebar
    tags$div(class = "history-panel",
      tags$div(class = "history-header",
        tags$span(class = "history-title", "History"),
        tags$button(class = "hist-clear-btn", id = "hist-clear",
                    onclick = "clearHistory();", "Clear")
      ),
      tags$div(class = "history-list", id = "hist-list",
        tags$div(class = "hist-empty", "No calculations yet")
      ),
      tags$div(class = "kbd-legend",
        tags$div(class = "kbd-legend-title", "Keyboard"),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","0-9  .  + - * /"), tags$span(class="kbd-desc","Input")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","Enter / ="), tags$span(class="kbd-desc","Calculate")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","Backspace"), tags$span(class="kbd-desc","Delete")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","Escape"), tags$span(class="kbd-desc","AC")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","^  (  )"), tags$span(class="kbd-desc","Power / Parens")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","s  c  t"), tags$span(class="kbd-desc","sin  cos  tan")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","r  l  p"), tags$span(class="kbd-desc","\u221a  log  \u03c0")),
        tags$div(class = "kbd-row",
          tags$span(class="kbd-key","d"), tags$span(class="kbd-desc","DEG / RAD toggle"))
      )
    ),

    # Calculator
    tags$div(class = "casio-body",

      # top bar
      tags$div(class = "top-bar",
        tags$div(class = "mode-pill",
          tags$button(class = "mode-btn active", id = "btn-deg",
                      onclick = "setAngleMode('DEG');", "DEG"),
          tags$button(class = "mode-btn",         id = "btn-rad",
                      onclick = "setAngleMode('RAD');", "RAD")
        ),
        tags$button(class = "about-btn",
          onclick = "document.getElementById('about-modal').classList.add('open');",
          "About Us"
        )
      ),

      tags$div(class = "brand", "LOLOCALC"),
      tags$div(class = "model", "fx-01AB PLUS  \u00b7  L.O.L.O Edition"),

      # screen
      tags$div(class = "screen-wrap",
        tags$div(class = "screen-inds",
          tags$span(class = "s-ind on",  id = "ind-mode", "DEG"),
          tags$span(class = "s-ind",     id = "ind-m",    "M")
        ),
        tags$div(id = "screen_expr", class = "screen-expr", "\u00a0"),
        tags$div(id = "screen_main", class = "screen-main", "0")
      ),

      # Row 1: trig + power + log
      tags$div(class = "btn-row cols-5",
        actionButton("b_sin",  "sin",       class = "my-btn btn-dark"),
        actionButton("b_cos",  "cos",       class = "my-btn btn-dark"),
        actionButton("b_tan",  "tan",       class = "my-btn btn-dark"),
        actionButton("b_pow",  "x\u02b8",   class = "my-btn btn-dark"),
        actionButton("b_log",  "log",       class = "my-btn btn-dark")
      ),

      # Row 2: scientific
      tags$div(class = "btn-row cols-5",
        actionButton("b_sqrt", "\u221a",    class = "my-btn btn-dark"),
        actionButton("b_cbrt", "\u221b",    class = "my-btn btn-dark"),
        actionButton("b_fact", "x!",        class = "my-btn btn-dark"),
        actionButton("b_op",   "(",         class = "my-btn btn-dark"),
        actionButton("b_cp",   ")",         class = "my-btn btn-dark")
      ),

      # Row 3: memory
      tags$div(class = "btn-row cols-5",
        actionButton("b_ms",  "MS",         class = "my-btn btn-blue"),
        actionButton("b_mr",  "MR",         class = "my-btn btn-blue"),
        actionButton("b_mpl", "M+",         class = "my-btn btn-blue"),
        actionButton("b_mm",  "M\u2212",    class = "my-btn btn-blue"),
        actionButton("b_mc",  "MC",         class = "my-btn btn-blue")
      ),

      # Row 4: 7 8 9 DEL AC
      tags$div(class = "btn-row cols-5",
        actionButton("b7",    "7",          class = "my-btn btn-num"),
        actionButton("b8",    "8",          class = "my-btn btn-num"),
        actionButton("b9",    "9",          class = "my-btn btn-num"),
        actionButton("b_del", "DEL",        class = "my-btn btn-green"),
        actionButton("b_ac",  "AC",         class = "my-btn btn-green")
      ),

      # Row 5: 4 5 6 × ÷
      tags$div(class = "btn-row cols-5",
        actionButton("b4",    "4",          class = "my-btn btn-num"),
        actionButton("b5",    "5",          class = "my-btn btn-num"),
        actionButton("b6",    "6",          class = "my-btn btn-num"),
        actionButton("b_mul", "\u00d7",     class = "my-btn btn-num"),
        actionButton("b_div", "\u00f7",     class = "my-btn btn-num")
      ),

      # Row 6: 1 2 3 + −
      tags$div(class = "btn-row cols-5",
        actionButton("b1",    "1",          class = "my-btn btn-num"),
        actionButton("b2",    "2",          class = "my-btn btn-num"),
        actionButton("b3",    "3",          class = "my-btn btn-num"),
        actionButton("b_add", "+",          class = "my-btn btn-num"),
        actionButton("b_sub", "\u2212",     class = "my-btn btn-num")
      ),

      # Row 7: 0 . π Ans =
      tags$div(class = "btn-row cols-5",
        actionButton("b0",    "0",          class = "my-btn btn-num"),
        actionButton("b_dot", ".",          class = "my-btn btn-num"),
        actionButton("b_pi",  "\u03c0",     class = "my-btn btn-num"),
        actionButton("b_ans", "Ans",        class = "my-btn btn-num"),
        actionButton("b_eq",  "=",          class = "my-btn btn-eq")
      )
    )
  ),

  # ── JavaScript ───────────────────────────────────────────────────────────────
  tags$script(HTML("
// =====================================================================
//  State
// =====================================================================
var expr      = '';
var lastAns   = 0;
var justCalc  = false;
var angleMode = 'DEG';
var memVal    = 0;
var memSet    = false;
var calcHistory = [];   // NEVER name this 'history' — shadows window.history

var PI_STR = '3.14159265358979';

// =====================================================================
//  DOM helpers
// =====================================================================
function $id(id)   { return document.getElementById(id); }
function mainEl()  { return $id('screen_main'); }
function exprEl()  { return $id('screen_expr'); }

function setMain(val, isErr) {
  var el = mainEl();
  el.textContent = val;
  el.className = 'screen-main' + (isErr ? ' err' : '');
}
function setExpr(val) { exprEl().textContent = val || '\\u00a0'; }

// =====================================================================
//  Display formatting
// =====================================================================
function toDisp(s) {
  return s
    .replace(/Math\\.sin\\(toRad\\(/g,  'sin(')
    .replace(/Math\\.cos\\(toRad\\(/g,  'cos(')
    .replace(/Math\\.tan\\(toRad\\(/g,  'tan(')
    .replace(/Math\\.log10\\(/g,        'log(')
    .replace(/Math\\.sqrt\\(/g,         '\\u221a(')
    .replace(/Math\\.cbrt\\(/g,         '\\u221b(')
    .replace(new RegExp(PI_STR.replace('.','\\\\.'),'g'), '\\u03c0')
    .replace(/lastAns/g,                'Ans')
    .replace(/\\*\\*/g,                 '^')
    .replace(/\\*/g,                    '\\u00d7')
    .replace(/\\//g,                    '\\u00f7');
}

function fmtNum(n) {
  if (!isFinite(n) || isNaN(n)) return 'Math Error';
  if (Math.abs(n) >= 1e12 || (Math.abs(n) < 1e-9 && n !== 0))
    return n.toExponential(6);
  return String(parseFloat(n.toPrecision(10)));
}

// =====================================================================
//  Angle mode
// =====================================================================
function setAngleMode(m) {
  angleMode = m;
  $id('btn-deg').className = 'mode-btn' + (m === 'DEG' ? ' active' : '');
  $id('btn-rad').className = 'mode-btn' + (m === 'RAD' ? ' active' : '');
  $id('ind-mode').textContent = m;
}

// =====================================================================
//  Memory indicator
// =====================================================================
function updateMemInd() {
  var el = $id('ind-m');
  if (memSet) el.classList.add('on'); else el.classList.remove('on');
}

// =====================================================================
//  History
// =====================================================================
function addHistory(dispExpr, result) {
  calcHistory.unshift({ expr: dispExpr, result: result });
  if (calcHistory.length > 60) calcHistory.pop();
  renderHistory();
}

function renderHistory() {
  var list = $id('hist-list');
  if (!list) return;                     // guard: DOM not ready yet
  if (calcHistory.length === 0) {
    list.innerHTML = '<div class=\"hist-empty\">No calculations yet</div>';
    return;
  }
  list.innerHTML = '';
  for (var i = 0; i < calcHistory.length; i++) {
    (function(idx) {                     // IIFE to capture correct index
      var h = calcHistory[idx];
      var d = document.createElement('div');
      d.className = 'hist-item';
      d.innerHTML =
        '<div class=\"hist-expr\">'   + safeEsc(h.expr)   + '</div>' +
        '<div class=\"hist-result\">' + safeEsc(h.result) + '</div>';
      d.onclick = function() { recallHistory(idx); };
      list.appendChild(d);
    })(i);
  }
}

function clearHistory() { calcHistory = []; renderHistory(); }

function recallHistory(i) {
  var r = calcHistory[i].result;
  if (r === 'Math Error') return;
  expr = r; justCalc = true;
  setMain(r, false); setExpr('\\u00a0');
}

function safeEsc(s) {
  return String(s)
    .replace(/&/g,'&amp;')
    .replace(/</g,'&lt;')
    .replace(/>/g,'&gt;');
}

// =====================================================================
//  Evaluation
// =====================================================================
function safeEval(s) {
  try {
    var safe = s
      .replace(new RegExp(PI_STR.replace('.','\\\\.'),'g'), '(' + Math.PI + ')')
      .replace(/lastAns/g, '(' + lastAns + ')');
    var toRadFn = angleMode === 'DEG'
      ? 'function toRad(x){ return x * Math.PI / 180; }'
      : 'function toRad(x){ return x; }';
    var result = Function('\"use strict\"; ' + toRadFn + ' return (' + safe + ')')();
    return (typeof result === 'number') ? result : NaN;
  } catch(e) { return NaN; }
}

// =====================================================================
//  Expression helpers
// =====================================================================
function endsWithOp()   { return /[+\\-*\\/\\^]$/.test(expr); }
function endsWithNum()  { return /[0-9.\\)]$/.test(expr);      }
function countOpen()    { return (expr.match(/\\(/g)||[]).length; }
function countClose()   { return (expr.match(/\\)/g)||[]).length; }

function factorial(n) {
  if (n < 0 || Math.floor(n) !== n || n > 170) return NaN;
  var r = 1; for (var i = 2; i <= n; i++) r *= i; return r;
}

function applyFactorial() {
  var m = expr.match(/^(.*?)([0-9.]+)$/);
  if (!m) return;
  var val = parseFloat(m[2]);
  if (isNaN(val) || val < 0 || Math.floor(val) !== val || val > 170) {
    setMain('Math Error', true); return;
  }
  var f = factorial(val);
  expr = m[1] + String(f);
  setMain(fmtNum(f), false);
  setExpr(toDisp(expr));
}

// =====================================================================
//  Core token handler
// =====================================================================
function handleToken(t) {

  // AC
  if (t === 'AC') {
    expr = ''; justCalc = false;
    setMain('0', false); setExpr('\\u00a0');
    return;
  }

  // DEL
  if (t === 'DEL') {
    if (justCalc) { expr=''; justCalc=false; setMain('0',false); setExpr('\\u00a0'); return; }
    if (!expr.length) return;
    var chunks = [
      'Math.sin(toRad(','Math.cos(toRad(','Math.tan(toRad(',
      'Math.log10(','Math.sqrt(','Math.cbrt(',
      'lastAns', PI_STR, '**'
    ];
    var done = false;
    for (var i = 0; i < chunks.length; i++) {
      if (expr.endsWith(chunks[i])) { expr = expr.slice(0, -chunks[i].length); done = true; break; }
    }
    if (!done) expr = expr.slice(0, -1);
    if (!expr) { setMain('0',false); setExpr('\\u00a0'); }
    else {
      var m = expr.match(/([0-9.]+)$/);
      setMain(m ? m[1] : toDisp(expr.slice(-12)), false);
      setExpr(toDisp(expr));
    }
    return;
  }

  // Memory
  if (t === 'MS') {
    var v = safeEval(expr || '0');
    if (isFinite(v)) { memVal = v; memSet = true; updateMemInd(); }
    return;
  }
  if (t === 'MR') {
    if (!memSet) return;
    if (justCalc) { expr = String(memVal); justCalc = false; }
    else          { if (endsWithNum()) expr += '*'; expr += String(memVal); }
    setMain(fmtNum(memVal), false); setExpr(toDisp(expr));
    return;
  }
  if (t === 'M+') {
    var v2 = safeEval(expr || '0');
    if (isFinite(v2)) { memVal += v2; memSet = true; updateMemInd(); }
    return;
  }
  if (t === 'M-') {
    var v3 = safeEval(expr || '0');
    if (isFinite(v3)) { memVal -= v3; memSet = true; updateMemInd(); }
    return;
  }
  if (t === 'MC') { memVal = 0; memSet = false; updateMemInd(); return; }

  // Digits
  if (/^[0-9]$/.test(t)) {
    if (justCalc) { expr = t; justCalc = false; setMain(t,false); setExpr('\\u00a0'); return; }
    if (/\\)$/.test(expr)) expr += '*';
    expr += t;
    var mm = expr.match(/([0-9.]+)$/);
    setMain(mm ? mm[1] : t, false); setExpr(toDisp(expr));
    return;
  }

  // Decimal point
  if (t === '.') {
    if (justCalc) { expr='0.'; justCalc=false; setMain('0.',false); setExpr('\\u00a0'); return; }
    if (!expr || endsWithOp() || /[(*+\\-\\/^]$/.test(expr)) expr += '0.';
    else {
      var mm2 = expr.match(/([0-9.]+)$/);
      if (mm2 && mm2[1].includes('.')) return;
      expr += '.';
    }
    var mm3 = expr.match(/([0-9.]+)$/);
    setMain(mm3 ? mm3[1] : '0.', false); setExpr(toDisp(expr));
    return;
  }

  // Basic operators
  if (['+','-','*','/'].includes(t)) {
    if (!expr && t !== '-') return;
    if (!expr && t === '-') { expr = '-'; setMain('-',false); return; }
    if (justCalc) justCalc = false;
    if (endsWithOp()) expr = expr.slice(0,-1);
    expr += t; setExpr(toDisp(expr));
    return;
  }

  // Power
  if (t === '^') {
    if (!expr || !endsWithNum()) return;
    if (justCalc) justCalc = false;
    expr += '**'; setExpr(toDisp(expr));
    return;
  }

  // Pi
  if (t === 'PI') {
    if (justCalc) { expr = PI_STR; justCalc = false; }
    else { if (endsWithNum()) expr += '*'; expr += PI_STR; }
    setMain('\\u03c0', false); setExpr(toDisp(expr));
    return;
  }

  // Ans
  if (t === 'ANS') {
    if (justCalc) { expr = String(lastAns); justCalc = false; }
    else { if (endsWithNum()) expr += '*'; expr += 'lastAns'; }
    setMain(fmtNum(lastAns), false); setExpr(toDisp(expr));
    return;
  }

  // Trig
  if (t === 'SIN' || t === 'COS' || t === 'TAN') {
    if (justCalc) { expr = ''; justCalc = false; }
    if (endsWithNum()) expr += '*';
    var fn = t.toLowerCase();
    expr += 'Math.' + fn + '(toRad(';
    setMain(fn + '(', false); setExpr(toDisp(expr));
    return;
  }

  // Log
  if (t === 'LOG') {
    if (justCalc) { expr = ''; justCalc = false; }
    if (endsWithNum()) expr += '*';
    expr += 'Math.log10(';
    setMain('log(', false); setExpr(toDisp(expr));
    return;
  }

  // Sqrt / Cbrt
  if (t === 'SQRT' || t === 'CBRT') {
    if (justCalc) { expr = ''; justCalc = false; }
    if (endsWithNum()) expr += '*';
    expr += (t === 'SQRT' ? 'Math.sqrt(' : 'Math.cbrt(');
    setMain(t === 'SQRT' ? '\\u221a(' : '\\u221b(', false);
    setExpr(toDisp(expr));
    return;
  }

  // Factorial
  if (t === 'FACT') { if (!expr || endsWithOp()) return; applyFactorial(); return; }

  // Open paren
  if (t === '(') {
    if (justCalc) { expr = '('; justCalc = false; }
    else { if (endsWithNum()) expr += '*'; expr += '('; }
    setExpr(toDisp(expr));
    return;
  }

  // Close paren
  if (t === ')') {
    if (countOpen() <= countClose() || endsWithOp()) return;
    expr += ')';
    setMain(toDisp(expr), false); setExpr(toDisp(expr));
    return;
  }

  // Equals
  if (t === '=') {
    if (!expr) return;
    var gap = countOpen() - countClose();
    for (var k = 0; k < gap; k++) expr += ')';
    var dispExpr = toDisp(expr);
    var res      = safeEval(expr);
    var resStr   = fmtNum(res);
    var isErr    = (resStr === 'Math Error');
    setExpr(dispExpr + ' =');
    setMain(resStr, isErr);
    if (!isErr) {
      addHistory(dispExpr, resStr);
      lastAns = res; expr = String(res); justCalc = true;
    } else {
      expr = '';
    }
    return;
  }
}

// =====================================================================
//  Shiny bridge
// =====================================================================
Shiny.addCustomMessageHandler('calc_token', handleToken);

// =====================================================================
//  Keyboard support
// =====================================================================
document.addEventListener('keydown', function(e) {
  if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
  var k = e.key;

  // direct character map
  var map = {
    '0':'0','1':'1','2':'2','3':'3','4':'4',
    '5':'5','6':'6','7':'7','8':'8','9':'9',
    '.':'.', '+':'+', '*':'*', '/':'/',  '^':'^',
    '(':  '(', ')':  ')',
    'Enter':'=', '=':'=',
    'Backspace':'DEL', 'Escape':'AC', 'Delete':'AC'
  };
  if (k === '-' || k === '\\u2212') { handleToken('-'); e.preventDefault(); return; }
  if (map[k]) { handleToken(map[k]); e.preventDefault(); return; }

  var kl = k.toLowerCase();
  if (kl==='s') { handleToken('SIN');  e.preventDefault(); return; }
  if (kl==='c') { handleToken('COS');  e.preventDefault(); return; }
  if (kl==='t') { handleToken('TAN');  e.preventDefault(); return; }
  if (kl==='r') { handleToken('SQRT'); e.preventDefault(); return; }
  if (kl==='l') { handleToken('LOG');  e.preventDefault(); return; }
  if (kl==='p') { handleToken('PI');   e.preventDefault(); return; }
  if (kl==='a') { handleToken('ANS');  e.preventDefault(); return; }
  if (kl==='d') { setAngleMode(angleMode==='DEG'?'RAD':'DEG'); e.preventDefault(); return; }
});

// =====================================================================
//  Close modal on backdrop click
// =====================================================================
document.addEventListener('DOMContentLoaded', function() {
  var ov = document.getElementById('about-modal');
  if (ov) ov.addEventListener('click', function(e){
    if (e.target === ov) ov.classList.remove('open');
  });
});
  "))
)

# ── Server ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {
  send <- function(token) session$sendCustomMessage("calc_token", token)

  # digits 0-9
  for (d in 0:9) {
    local({
      digit  <- as.character(d)
      btn_id <- paste0("b", digit)
      observeEvent(input[[btn_id]], send(digit), ignoreInit = TRUE)
    })
  }

  observeEvent(input$b_dot,  send("."),    ignoreInit = TRUE)
  observeEvent(input$b_ac,   send("AC"),   ignoreInit = TRUE)
  observeEvent(input$b_del,  send("DEL"),  ignoreInit = TRUE)
  observeEvent(input$b_add,  send("+"),    ignoreInit = TRUE)
  observeEvent(input$b_sub,  send("-"),    ignoreInit = TRUE)
  observeEvent(input$b_mul,  send("*"),    ignoreInit = TRUE)
  observeEvent(input$b_div,  send("/"),    ignoreInit = TRUE)
  observeEvent(input$b_pow,  send("^"),    ignoreInit = TRUE)
  observeEvent(input$b_eq,   send("="),    ignoreInit = TRUE)
  observeEvent(input$b_sqrt, send("SQRT"), ignoreInit = TRUE)
  observeEvent(input$b_cbrt, send("CBRT"), ignoreInit = TRUE)
  observeEvent(input$b_fact, send("FACT"), ignoreInit = TRUE)
  observeEvent(input$b_pi,   send("PI"),   ignoreInit = TRUE)
  observeEvent(input$b_ans,  send("ANS"),  ignoreInit = TRUE)
  observeEvent(input$b_op,   send("("),    ignoreInit = TRUE)
  observeEvent(input$b_cp,   send(")"),    ignoreInit = TRUE)
  observeEvent(input$b_sin,  send("SIN"),  ignoreInit = TRUE)
  observeEvent(input$b_cos,  send("COS"),  ignoreInit = TRUE)
  observeEvent(input$b_tan,  send("TAN"),  ignoreInit = TRUE)
  observeEvent(input$b_log,  send("LOG"),  ignoreInit = TRUE)
  observeEvent(input$b_ms,   send("MS"),   ignoreInit = TRUE)
  observeEvent(input$b_mr,   send("MR"),   ignoreInit = TRUE)
  observeEvent(input$b_mpl,  send("M+"),   ignoreInit = TRUE)
  observeEvent(input$b_mm,   send("M-"),   ignoreInit = TRUE)
  observeEvent(input$b_mc,   send("MC"),   ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)