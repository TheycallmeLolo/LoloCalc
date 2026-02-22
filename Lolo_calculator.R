library(shiny)

ui <- bootstrapPage(
  tags$head(
    tags$style(HTML("
      html, body {
        background-color: #e0e5ec !important;
        margin: 0; padding: 0;
        height: 100vh;
      }
      .master-container {
        height: 100vh; display: flex;
        justify-content: center; align-items: center;
      }
      .casio-body {
        background: linear-gradient(to bottom, #2b2b2c, #1a1a1b);
        width: 360px; padding: 25px 20px; border-radius: 20px;
        box-shadow: 10px 15px 35px rgba(0,0,0,0.5);
      }
      .brand { color: white; font-weight: bold; font-size: 20px; }
      .model { color: #a0a0a0; font-size: 11px; font-style: italic; margin-bottom: 20px; }
      .screen-container {
        background-color: #8c9e8e; padding: 10px; border-radius: 8px;
        border: 3px solid #111; margin-bottom: 25px; min-height: 80px;
        box-shadow: inset 3px 3px 10px rgba(0,0,0,0.3);
      }
      .screen-expr {
        color: rgba(0,0,0,0.45); font-family: monospace; font-size: 13px;
        text-align: right; min-height: 17px; word-break: break-all;
      }
      .screen-main {
        color: #111; font-family: monospace; font-size: 26px;
        text-align: right; word-break: break-all; min-height: 34px;
      }
      .screen-main.err { color: #7a0000; font-size: 15px; }
      .btn-grid-top, .btn-grid-bottom {
        display: grid; grid-template-columns: repeat(5, 1fr); gap: 6px;
      }
      .btn-grid-top { margin-bottom: 15px; }
      .my-btn {
        border: none; border-radius: 5px; padding: 10px 0; font-weight: bold;
        box-shadow: 0px 4px 0px #0a0a0a; cursor: pointer; transition: 0.1s;
      }
      .my-btn:active { transform: translateY(4px); box-shadow: 0px 0px 0px #111; }
      .btn-black  { background-color: #2c2d2f; color: white; }
      .btn-num    { background-color: #e2e2e2; color: #000; font-size: 18px; }
      .btn-ac-del { background-color: #6fb05a; color: white; }

      /* ── About Us button ── */
      .about-btn {
        float: right;
        background: #dcdfd2; color: #110707;
        border: none; border-radius: 5px;
        padding: 4px 12px;
        font-size: 0.82rem; font-weight: bold;
        cursor: pointer;
        box-shadow: 0px 3px 0px #0a0a0a;
        transition: background 0.15s, color 0.15s;
        margin-bottom: 8px;
      }
      .about-btn:hover  { background: #6fb05a; color: #fff; }
      .about-btn:active { transform: translateY(2px); box-shadow: 0 1px 0 #0a0a0a; }

      /* ── Modal overlay ── */
      .modal-overlay {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0,0,0,0.7);
        backdrop-filter: blur(5px);
        -webkit-backdrop-filter: blur(5px);
        z-index: 99999;
        display: none;
        align-items: center;
        justify-content: center;
      }
      .modal-overlay.open {
        display: flex !important;
      }

      /* ── Modal box ── */
      .modal-box {
        background: #1e1e1e;
        border-radius: 16px;
        box-shadow: 0 24px 70px rgba(0,0,0,0.7);
        width: 320px;
        max-height: 75vh;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        animation: mIn 0.28s cubic-bezier(0.34,1.4,0.64,1) forwards;
      }
      @keyframes mIn {
        from { opacity: 0; transform: scale(0.85) translateY(24px); }
        to   { opacity: 1; transform: scale(1)    translateY(0);    }
      }

      /* ── Modal header ── */
      .modal-head {
        background: #6fb05a;
        padding: 22px 22px 16px;
        text-align: center;
        flex-shrink: 0;
      }
      .modal-head-title {
        color: #fff;
        font-size: 1.5rem;
        font-weight: 900;
        letter-spacing: 0.12em;
        margin: 0;
      }
      .modal-head-sub {
        color: rgba(255,255,255,0.65);
        font-size: 0.7rem;
        margin-top: 5px;
      }

      /* ── Scrollable body ── */
      .modal-body {
        padding: 16px 16px 0;
        overflow-y: auto;
        flex: 1;
        scroll-behavior: smooth;
      }
      .modal-body::-webkit-scrollbar       { width: 5px; }
      .modal-body::-webkit-scrollbar-track { background: #2a2a2a; border-radius: 4px; }
      .modal-body::-webkit-scrollbar-thumb { background: #6fb05a; border-radius: 4px; }

      /* ── Team list ── */
      .team-lbl {
        font-size: 1.5rem; font-weight: bold;
        letter-spacing: 0.18em; text-transform: uppercase;
        color: #666; margin-bottom: 10px;
      }
      .team-list {
        display: flex; flex-direction: column; gap: 8px;
        margin-bottom: 16px;
      }
      .member-card {
        display: flex; align-items: center; gap: 12px;
        background: #2a2a2a; border-radius: 8px;
        padding: 10px 13px;
        transition: background 0.15s;
      }
      .member-card:hover { background: #333; }

      /* Avatar: 1.5rem initials */
      .member-av {
        width: 36px; height: 36px;
        border-radius: 50%;
        background: #6fb05a;
        color: #fff;
        font-size: 1.5rem;
        font-weight: bold;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
      }

      /* Name: 2rem */
      .member-name {
        font-size: 2rem;
        font-weight: bold;
        color: #f0f0f0;
        line-height: 1.1;
      }

      /* Number: 1rem */
      .member-num {
        font-size: 1.5rem;
        color: #666;
        margin-top: 3px;
      }

      /* ── Close button: 2rem ── */
      .modal-close-wrap {
        padding: 14px 16px;
        flex-shrink: 0;
      }
      .modal-close {
        width: 100%; padding: 12px;
        font-size: 2rem; font-weight: bold;
        background: #6fb05a; color: #fff;
        border: none; border-radius: 8px;
        cursor: pointer;
        box-shadow: 0 4px 0 #3c7a2c;
        transition: filter 0.1s, transform 0.1s, box-shadow 0.1s;
      }
      .modal-close:hover  { filter: brightness(1.12); }
      .modal-close:active {
        transform: translateY(3px);
        box-shadow: 0 1px 0 #3c7a2c;
      }
    "))
  ),

  # ── About Us Modal (outside master-container so fixed positioning works) ──
  tags$div(id = "about-modal", class = "modal-overlay",
    tags$div(class = "modal-box",
      tags$div(class = "modal-head",
        tags$div(class = "modal-head-title", "ABOUT US"),
        tags$div(class = "modal-head-sub", "Scientific Calculator \u2014 Development Team")
      ),
      tags$div(class = "modal-body",
        tags$div(class = "team-lbl", "Team Members"),
        tags$div(class = "team-list",
          tags$div(class="member-card", tags$div(class="member-av","AA"), tags$div(tags$div(class="member-name","Ali Abdelbasir (Lolo)"),    tags$div(class="member-num","#01"))),
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

  # ── Main calculator ──
  tags$div(class = "master-container",
    tags$div(class = "casio-body",

      # About Us button
      tags$button(class = "about-btn",
        onclick = "document.getElementById('about-modal').classList.add('open');",
        "About Us"
      ),
      tags$div(style = "clear:both;"),

      tags$div(class = "brand", "LOLOCALC"),
      tags$div(class = "model", "fx-01AB PLUS L.O.L.O"),

      tags$div(class = "screen-container",
        tags$div(id = "screen_expr", class = "screen-expr", "\u00a0"),
        tags$div(id = "screen_main", class = "screen-main", "0")
      ),

      tags$div(class = "btn-grid-top",
        actionButton("b_sqrt", "\u221a",  class = "my-btn btn-black"),
        actionButton("b_cbrt", "\u221b",  class = "my-btn btn-black"),
        actionButton("b_fact", "x!",      class = "my-btn btn-black"),
        actionButton("b_op",  "(",        class = "my-btn btn-black"),
        actionButton("b_cp",  ")",        class = "my-btn btn-black")
      ),

      tags$div(class = "btn-grid-bottom",
        actionButton("b7",    "7",        class = "my-btn btn-num"),
        actionButton("b8",    "8",        class = "my-btn btn-num"),
        actionButton("b9",    "9",        class = "my-btn btn-num"),
        actionButton("b_del", "DEL",      class = "my-btn btn-ac-del"),
        actionButton("b_ac",  "AC",       class = "my-btn btn-ac-del"),

        actionButton("b4",    "4",        class = "my-btn btn-num"),
        actionButton("b5",    "5",        class = "my-btn btn-num"),
        actionButton("b6",    "6",        class = "my-btn btn-num"),
        actionButton("b_mul", "\u00d7",   class = "my-btn btn-num"),
        actionButton("b_div", "\u00f7",   class = "my-btn btn-num"),

        actionButton("b1",    "1",        class = "my-btn btn-num"),
        actionButton("b2",    "2",        class = "my-btn btn-num"),
        actionButton("b3",    "3",        class = "my-btn btn-num"),
        actionButton("b_add", "+",        class = "my-btn btn-num"),
        actionButton("b_sub", "-",        class = "my-btn btn-num"),

        actionButton("b0",    "0",        class = "my-btn btn-num"),
        actionButton("b_dot", ".",        class = "my-btn btn-num"),
        actionButton("b_pi",  "\u03c0",   class = "my-btn btn-num"),
        actionButton("b_ans", "Ans",      class = "my-btn btn-num"),
        actionButton("b_eq",  "=",        class = "my-btn btn-num",
                     style = "background:#4a4a4a; color:white;")
      )
    )
  ),

  tags$script(HTML("
  var expr     = '';
  var lastAns  = 0;
  var justCalc = false;
  var PI_STR   = '3.14159265358979';

  function mainEl() { return document.getElementById('screen_main'); }
  function exprEl() { return document.getElementById('screen_expr'); }

  function setMain(val, isErr) {
    var el = mainEl();
    el.textContent = val;
    el.className = 'screen-main' + (isErr ? ' err' : '');
  }
  function setExprDisp(val) { exprEl().textContent = val || '\\u00a0'; }

  function toDisp(s) {
    return s
      .replace(/\\*/g, '\\u00d7')
      .replace(/\\//g, '\\u00f7')
      .replace(new RegExp(PI_STR.replace('.','\\\\.'),'g'), '\\u03c0')
      .replace(/lastAns/g, 'Ans')
      .replace(/Math\\.sqrt\\(/g, '\\u221a(')
      .replace(/Math\\.cbrt\\(/g, '\\u221b(');
  }

  function fmtNum(n) {
    if (!isFinite(n) || isNaN(n)) return 'Math Error';
    if (Math.abs(n) >= 1e12 || (Math.abs(n) < 1e-9 && n !== 0))
      return n.toExponential(6);
    return String(parseFloat(n.toPrecision(10)));
  }

  function endsWithOp()  { return /[+\\-*\\/]$/.test(expr); }
  function endsWithNum() { return /[0-9.\\)]$/.test(expr); }

  function factorial(n) {
    if (n < 0 || Math.floor(n) !== n || n > 170) return NaN;
    var r = 1; for (var i = 2; i <= n; i++) r *= i; return r;
  }

  function safeEval(s) {
    try {
      var safe = s
        .replace(new RegExp(PI_STR.replace('.','\\\\.'),'g'), '(' + Math.PI + ')')
        .replace(/lastAns/g, '(' + lastAns + ')');
      var result = Function('\"use strict\"; return (' + safe + ')')();
      return (typeof result === 'number') ? result : NaN;
    } catch(e) { return NaN; }
  }

  function applyFactorial() {
    var m = expr.match(/^(.*?)([0-9.]+)$/);
    if (!m) return;
    var val = parseFloat(m[2]);
    if (isNaN(val) || val < 0 || Math.floor(val) !== val || val > 170) {
      setMain('\\u062e\\u0637\\u0623 \\u0631\\u064a\\u0627\\u0636\\u064a', true); return;
    }
    var f = factorial(val);
    expr = m[1] + String(f);
    setMain(fmtNum(f), false);
    setExprDisp(toDisp(expr));
  }

  /* Close modal by clicking the backdrop */
  document.addEventListener('DOMContentLoaded', function() {
    var overlay = document.getElementById('about-modal');
    if (overlay) {
      overlay.addEventListener('click', function(e) {
        if (e.target === overlay) overlay.classList.remove('open');
      });
    }
  });

  Shiny.addCustomMessageHandler('calc_token', function(t) {
    if (t === 'AC') { expr=''; justCalc=false; setMain('0',false); setExprDisp('\\u00a0'); return; }

    if (t === 'DEL') {
      if (justCalc) { expr=''; justCalc=false; setMain('0',false); setExprDisp('\\u00a0'); return; }
      if (!expr.length) return;
      var suf=['Math.sqrt(','Math.cbrt(','lastAns',PI_STR], done=false;
      for(var i=0;i<suf.length;i++){if(expr.endsWith(suf[i])){expr=expr.slice(0,-suf[i].length);done=true;break;}}
      if(!done) expr=expr.slice(0,-1);
      if(!expr){setMain('0',false);setExprDisp('\\u00a0');}
      else{var m=expr.match(/([0-9.]+)$/);setMain(m?m[1]:toDisp(expr.slice(-8)),false);setExprDisp(toDisp(expr));}
      return;
    }

    if(/^[0-9]$/.test(t)){
      if(justCalc){expr=t;justCalc=false;setMain(t,false);setExprDisp('\\u00a0');return;}
      if(/\\)$/.test(expr)) expr+='*';
      expr+=t;
      var m=expr.match(/([0-9.]+)$/);
      setMain(m?m[1]:t,false);setExprDisp(toDisp(expr));return;
    }

    if(t==='.'){
      if(justCalc){expr='0.';justCalc=false;setMain('0.',false);setExprDisp('\\u00a0');return;}
      if(endsWithOp()||!expr||/[(\\/\\*\\+\\-]$/.test(expr)) expr+='0.';
      else{var m=expr.match(/([0-9.]+)$/);if(m&&m[1].includes('.'))return;expr+='.';}
      var m2=expr.match(/([0-9.]+)$/);setMain(m2?m2[1]:'0.',false);setExprDisp(toDisp(expr));return;
    }

    if(['+','-','*','/'].includes(t)){
      if(!expr&&t!=='-')return;
      if(!expr&&t==='-'){expr='-';setMain('-',false);return;}
      if(justCalc)justCalc=false;
      if(endsWithOp())expr=expr.slice(0,-1);
      expr+=t;setExprDisp(toDisp(expr));return;
    }

    if(t==='PI'){
      if(justCalc){expr=PI_STR;justCalc=false;}
      else{if(endsWithNum())expr+='*';expr+=PI_STR;}
      setMain('\\u03c0',false);setExprDisp(toDisp(expr));return;
    }

    if(t==='ANS'){
      if(justCalc){expr=String(lastAns);justCalc=false;}
      else{if(endsWithNum())expr+='*';expr+='lastAns';}
      setMain(fmtNum(lastAns),false);setExprDisp(toDisp(expr));return;
    }

    if(t==='SQRT'||t==='CBRT'){
      if(justCalc){expr='';justCalc=false;}
      if(endsWithNum())expr+='*';
      expr+=(t==='SQRT'?'Math.sqrt(':'Math.cbrt(');
      setMain(t==='SQRT'?'\\u221a(':'\\u221b(',false);setExprDisp(toDisp(expr));return;
    }

    if(t==='FACT'){if(!expr||endsWithOp())return;applyFactorial();return;}

    if(t==='('){
      if(justCalc){expr='(';justCalc=false;}
      else{if(endsWithNum())expr+='*';expr+='(';}
      setExprDisp(toDisp(expr));return;
    }

    if(t===')'){
      var opens=(expr.match(/\\(/g)||[]).length;
      var closes=(expr.match(/\\)/g)||[]).length;
      if(opens<=closes||endsWithOp())return;
      expr+=')';setMain(toDisp(expr),false);setExprDisp(toDisp(expr));return;
    }

    if(t==='='){
      if(!expr)return;
      var opens=(expr.match(/\\(/g)||[]).length;
      var closes=(expr.match(/\\)/g)||[]).length;
      for(var i=0;i<opens-closes;i++)expr+=')';
      var fullDisp=toDisp(expr)+' =';
      var res=safeEval(expr);
      var resStr=fmtNum(res);
      var isErr=resStr==='Math Error';
      setExprDisp(fullDisp);setMain(resStr,isErr);
      if(!isErr){lastAns=res;expr=String(res);justCalc=true;}
      else{expr='';}
      return;
    }
  });
  "))
)

server <- function(input, output, session) {
  send <- function(token) session$sendCustomMessage("calc_token", token)

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
  observeEvent(input$b_eq,   send("="),    ignoreInit = TRUE)
  observeEvent(input$b_sqrt, send("SQRT"), ignoreInit = TRUE)
  observeEvent(input$b_cbrt, send("CBRT"), ignoreInit = TRUE)
  observeEvent(input$b_fact, send("FACT"), ignoreInit = TRUE)
  observeEvent(input$b_pi,   send("PI"),   ignoreInit = TRUE)
  observeEvent(input$b_ans,  send("ANS"),  ignoreInit = TRUE)
  observeEvent(input$b_op,   send("("),    ignoreInit = TRUE)
  observeEvent(input$b_cp,   send(")"),    ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)
