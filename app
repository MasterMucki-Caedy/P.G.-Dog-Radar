<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<title>P.G. Dog-Radar Â· App</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,700;1,9..144,400&family=Syne:wght@700;800&family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
<style>
:root {
  --navy:#0a1628; --navy2:#122040; --gold:#d4a843; --gold2:#e8c060;
  --green:#22c55e; --red:#ef4444; --amber:#f59e0b; --pink:#ec4899;
  --blue:#3b82f6; --purple:#8b5cf6; --orange:#f97316;
  --bg:#f0f4f8; --card:#fff; --text:#1e293b; --sub:#64748b; --border:#e8edf2;
  --r:16px; --r-sm:11px;
}
*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent;}
body{
  font-family:'DM Sans',sans-serif;
  background:linear-gradient(135deg,#060d1a 0%,#0d1f3c 50%,#060d1a 100%);
  min-height:100vh;display:flex;flex-direction:column;align-items:center;
  padding:0;
}

/* â”€â”€ TOP BAR (outside phone, for back link) â”€â”€ */
.topbar{
  width:100%;max-width:500px;
  display:flex;align-items:center;justify-content:space-between;
  padding:14px 20px 0;
}
.back-link{
  display:inline-flex;align-items:center;gap:7px;
  color:rgba(255,255,255,.5);font-size:13px;font-weight:700;
  text-decoration:none;font-family:'Syne',sans-serif;letter-spacing:.2px;
  transition:color .2s;
}
.back-link:hover{color:var(--gold)}
.back-link span{font-size:18px}
.app-version{color:rgba(255,255,255,.25);font-family:'DM Sans',monospace;font-size:11px}

/* â”€â”€ PHONE â”€â”€ */
.phone-wrap{padding:14px 0 30px;display:flex;justify-content:center;}
.phone{
  width:390px;height:844px;background:var(--bg);
  border-radius:46px;overflow:hidden;position:relative;
  box-shadow:0 80px 180px rgba(0,0,0,.95),
             0 0 0 1px rgba(255,255,255,.06),
             inset 0 0 0 1px rgba(255,255,255,.07);
  display:flex;flex-direction:column;
}
@media(max-width:420px){
  .phone{width:100vw;border-radius:0;height:100svh;}
  .topbar{display:none}
  .phone-wrap{padding:0}
}

/* â”€â”€ NOTCH â”€â”€ */
.notch{
  height:44px;background:var(--navy);flex-shrink:0;
  display:flex;align-items:flex-end;padding:0 20px 7px;justify-content:space-between;
}
.notch-time{color:#fff;font-size:12px;font-weight:700;font-family:'Syne',sans-serif;letter-spacing:.5px}
.notch-icons{color:#fff;font-size:11px;display:flex;gap:5px;align-items:center}

/* â”€â”€ APPBAR â”€â”€ */
.appbar{
  background:var(--navy);padding:9px 15px 13px;
  display:flex;align-items:center;justify-content:space-between;flex-shrink:0;
}
.appbar-title{color:#fff;font-weight:800;font-size:17px;font-family:'Syne',sans-serif;letter-spacing:-.2px}
.pill{padding:3px 9px;border-radius:20px;font-size:10px;font-weight:700}
.pill-gold{background:rgba(212,168,67,.18);color:var(--gold);border:1.5px solid rgba(212,168,67,.35)}
.pill-orange{background:var(--orange);color:#fff}

/* â”€â”€ SCREENS â”€â”€ */
.screen{display:none;flex:1;flex-direction:column;overflow:hidden;min-height:0}
.screen.active{display:flex}
.scroll{flex:1;overflow-y:auto;overflow-x:hidden;-webkit-overflow-scrolling:touch}
.scroll::-webkit-scrollbar{width:0}

/* â”€â”€ BOTTOM NAV â”€â”€ */
.bnav{
  background:var(--navy);display:flex;flex-shrink:0;
  border-top:1px solid rgba(255,255,255,.06);
  padding-bottom:env(safe-area-inset-bottom,0);
}
.nb{flex:1;background:none;border:none;padding:9px 2px 11px;cursor:pointer;text-align:center;position:relative}
.nb-icon{font-size:18px;display:block}
.nb-label{font-size:8px;color:rgba(255,255,255,.3);display:block;margin-top:3px;font-weight:700;letter-spacing:.4px;font-family:'Syne',sans-serif}
.nb.active .nb-label{color:var(--gold)}
.nb.active::after{content:'';position:absolute;bottom:0;left:50%;transform:translateX(-50%);width:18px;height:2.5px;background:var(--gold);border-radius:2px}
.nb-badge{position:absolute;top:7px;right:calc(50% - 18px);background:var(--red);color:#fff;font-size:8px;font-weight:700;padding:1px 5px;border-radius:20px}

/* â”€â”€ TOAST â”€â”€ */
.toast{position:absolute;bottom:72px;left:12px;right:12px;border-radius:13px;padding:10px 15px;color:#fff;font-weight:700;font-size:12px;text-align:center;z-index:999;display:none;box-shadow:0 4px 20px rgba(0,0,0,.3)}
.toast.show{display:block;animation:fadeUp .25s ease}
@keyframes fadeUp{from{transform:translateY(8px);opacity:0}to{transform:translateY(0);opacity:1}}

/* â”€â”€ CARDS & ROWS â”€â”€ */
.card{background:var(--card);border-radius:var(--r);margin:0 11px 9px;box-shadow:0 2px 12px rgba(0,0,0,.07);overflow:hidden}
.sec{font-size:10px;font-weight:700;color:var(--sub);letter-spacing:.9px;padding:11px 11px 5px;font-family:'Syne',sans-serif}
.trow{display:flex;align-items:center;padding:11px 13px;border-bottom:1px solid var(--border);gap:9px}
.trow:last-child{border-bottom:none}
.tl{flex:1}
.tt{font-weight:700;font-size:12px;color:var(--text)}
.ts{font-size:10px;color:var(--sub);margin-top:2px;line-height:1.4}
.tog{position:relative;width:40px;height:21px;flex-shrink:0}
.tog input{opacity:0;width:0;height:0}
.tog-sl{position:absolute;inset:0;border-radius:21px;background:#dde1e8;cursor:pointer;transition:.2s}
.tog-sl:before{content:'';position:absolute;width:15px;height:15px;left:3px;top:3px;border-radius:50%;background:#fff;transition:.2s;box-shadow:0 1px 4px rgba(0,0,0,.2)}
.tog input:checked + .tog-sl{background:var(--green)}
.tog input:checked + .tog-sl.red{background:var(--red)}
.tog input:checked + .tog-sl.purple{background:var(--purple)}
.tog input:checked + .tog-sl:before{transform:translateX(19px)}

/* â”€â”€ MAP â”€â”€ */
.map-wrap{flex:1;position:relative;overflow:hidden;min-height:0}
#gmap{position:absolute;inset:0;z-index:0}
#gmapLoad{
  position:absolute;inset:0;display:flex;align-items:center;justify-content:center;
  background:linear-gradient(160deg,#0d1f3c,#060d1a);z-index:1;
  flex-direction:column;gap:12px;
}
.gmap-spinner{width:36px;height:36px;border:3px solid rgba(212,168,67,.2);border-top-color:var(--gold);border-radius:50%;animation:spin .8s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.filter-bar{
  position:absolute;top:8px;left:8px;right:8px;
  background:rgba(8,16,32,.88);border-radius:12px;padding:5px 9px;
  display:flex;gap:4px;flex-wrap:nowrap;overflow-x:auto;z-index:10;
  backdrop-filter:blur(14px);scrollbar-width:none;-webkit-overflow-scrolling:touch;
}
.filter-bar::-webkit-scrollbar{display:none}
.fchip{display:flex;align-items:center;gap:3px;padding:3px 8px;border-radius:20px;border:1.5px solid transparent;font-size:9px;font-weight:700;cursor:pointer;background:rgba(255,255,255,.06);color:rgba(255,255,255,.35);transition:all .15s;white-space:nowrap}
.fchip.on{color:#fff}
.brut-banner{
  position:absolute;bottom:8px;left:8px;right:8px;
  background:linear-gradient(135deg,#7c2d12,#ea580c);
  border-radius:12px;padding:9px 13px;z-index:12;
  display:flex;align-items:center;gap:9px;cursor:pointer;
  box-shadow:0 4px 18px rgba(234,88,12,.5);
}
.mpopup{
  position:absolute;left:8px;right:8px;bottom:8px;
  background:#fff;border-radius:16px;padding:13px;
  box-shadow:0 10px 40px rgba(0,0,0,.4);z-index:20;display:none;
}
.mpopup.open{display:block;animation:fadeUp .2s ease}
.statusbar-wrap{background:#fff;padding:8px 10px 7px;border-top:1px solid var(--border);flex-shrink:0}
.sbtns{display:flex;gap:5px;margin-top:5px}
.sbtn{flex:1;border-radius:9px;padding:5px 1px;cursor:pointer;text-align:center;border:2px solid transparent;background:#f7f9fc;transition:all .15s}
.sbtn .se{font-size:13px;display:block}
.sbtn .sl{font-size:7px;font-weight:700;color:#999;margin-top:1px;display:block}
.rep-bar{background:#fff;padding:6px 10px 9px;flex-shrink:0}
.rep-btn{width:100%;background:linear-gradient(135deg,var(--orange),#ea580c);border:none;border-radius:11px;padding:9px;color:#fff;font-weight:700;font-size:12px;cursor:pointer;font-family:inherit}

/* â”€â”€ COMMUNITY â”€â”€ */
.comm-head{background:var(--navy);padding:13px 15px 0;flex-shrink:0}
.comm-tabs{display:flex;background:rgba(255,255,255,.09);border-radius:10px;padding:3px;margin-top:8px}
.ctab{flex:1;background:none;border:none;color:rgba(255,255,255,.45);font-weight:700;font-size:10px;padding:7px 0;border-radius:8px;cursor:pointer;transition:all .15s;font-family:inherit;letter-spacing:.3px}
.ctab.active{background:#fff;color:var(--navy)}
.post-card{background:#fff;margin:9px 11px 0;border-radius:15px;overflow:hidden;box-shadow:0 2px 10px rgba(0,0,0,.07)}
.post-hdr{display:flex;align-items:center;gap:8px;padding:11px 12px 7px}
.post-av{width:35px;height:35px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0}
.post-name{font-weight:700;font-size:12px;color:var(--text)}
.post-when{font-size:10px;color:var(--sub);margin-top:1px}
.post-badge{padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700;margin-left:auto}
.post-body{padding:0 12px 8px;font-size:12px;color:#344156;line-height:1.55}
.post-acts{display:flex;border-top:1px solid #f1f5f9}
.pact{flex:1;background:none;border:none;padding:8px 0;font-size:11px;font-weight:700;color:var(--sub);cursor:pointer;display:flex;align-items:center;justify-content:center;gap:4px;font-family:inherit}
.pact.liked{color:var(--red)}
.warn-card{background:linear-gradient(135deg,#7c2d12,#9a3412);margin:9px 11px 0;border-radius:15px;overflow:hidden;box-shadow:0 4px 18px rgba(234,88,12,.38)}
.warn-hdr{padding:11px 12px 7px;display:flex;align-items:center;gap:7px}
.warn-body{padding:0 12px 9px;color:rgba(255,255,255,.87);font-size:12px;line-height:1.5}
.warn-tags{display:flex;gap:4px;padding:0 12px 11px;flex-wrap:wrap}
.wtag{padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700;background:rgba(255,255,255,.14);color:#fff}
.new-post{background:#fff;margin:9px 11px;border-radius:15px;padding:10px;box-shadow:0 2px 10px rgba(0,0,0,.07)}
.np-row{display:flex;gap:8px;align-items:flex-start;margin-bottom:8px}
.np-av{width:33px;height:33px;border-radius:50%;background:#dcfce7;display:flex;align-items:center;justify-content:center;font-size:15px;flex-shrink:0}
.np-inp{flex:1;border:2px solid var(--border);border-radius:10px;padding:7px 10px;font-size:12px;font-family:inherit;outline:none;resize:none}
.np-inp:focus{border-color:var(--purple)}
.np-btns{display:flex;gap:5px;justify-content:flex-end}
.np-btn{padding:6px 12px;border-radius:9px;border:none;font-weight:700;font-size:11px;cursor:pointer;font-family:inherit}
.chat-item{display:flex;align-items:center;gap:9px;padding:9px 11px;background:#fff;border-radius:12px;margin:0 11px 7px;cursor:pointer;box-shadow:0 1px 6px rgba(0,0,0,.06)}
.chat-av{width:41px;height:41px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:19px;flex-shrink:0;position:relative}
.chat-online{position:absolute;bottom:0;right:0;width:11px;height:11px;border-radius:50%;background:var(--green);border:2.5px solid #fff}
.chat-unread{background:var(--purple);color:#fff;border-radius:20px;padding:1px 6px;font-size:9px;font-weight:700}
.chat-win{flex:1;display:flex;flex-direction:column;min-height:0}
.chat-win-hdr{background:var(--navy);padding:9px 13px;display:flex;align-items:center;gap:9px;flex-shrink:0}
.chat-msgs{flex:1;overflow-y:auto;padding:11px;background:#f8fafc;min-height:0}
.chat-msgs::-webkit-scrollbar{width:0}
.msg{max-width:75%;margin-bottom:7px}
.msg.me{margin-left:auto}
.msg-bubble{padding:8px 11px;border-radius:15px;font-size:12px;line-height:1.5}
.msg.them .msg-bubble{background:#fff;color:var(--text);border-bottom-left-radius:4px;box-shadow:0 1px 4px rgba(0,0,0,.08)}
.msg.me .msg-bubble{background:var(--purple);color:#fff;border-bottom-right-radius:4px}
.msg-time{font-size:9px;color:var(--sub);margin-top:2px;text-align:right}
.chat-inp-wrap{background:#fff;padding:8px 10px;display:flex;gap:7px;border-top:1px solid var(--border);flex-shrink:0}
.chat-inp{flex:1;border:2px solid var(--border);border-radius:20px;padding:7px 12px;font-size:12px;font-family:inherit;outline:none}
.chat-inp:focus{border-color:var(--purple)}
.chat-send{background:var(--purple);border:none;border-radius:50%;width:33px;height:33px;color:#fff;font-size:14px;cursor:pointer;flex-shrink:0;display:flex;align-items:center;justify-content:center}
.evt-card{background:#fff;border-radius:15px;margin:0 11px 9px;overflow:hidden;box-shadow:0 2px 10px rgba(0,0,0,.07)}
.evt-hdr{padding:11px 12px;display:flex;align-items:center;gap:9px}
.evt-body{padding:0 12px 9px;font-size:12px;color:#475569;line-height:1.5}
.evt-btns{padding:0 12px 11px;display:flex;gap:5px}
.evt-join{flex:1;border:none;border-radius:10px;padding:8px;font-weight:700;font-size:11px;cursor:pointer;font-family:inherit}

/* â”€â”€ REGELN â”€â”€ */
.rules-hdr{background:linear-gradient(135deg,var(--navy),#1a3c60);padding:13px 14px 17px;flex-shrink:0}
.brut-big{background:linear-gradient(135deg,#7c2d12,#b45309);border-radius:15px;padding:13px;margin:0 11px 9px;box-shadow:0 4px 18px rgba(180,83,9,.38)}
.brut-months{display:flex;gap:3px;flex-wrap:wrap;margin-top:9px}
.bm{padding:3px 7px;border-radius:20px;font-size:9px;font-weight:700;border:1.5px solid transparent}
.bm.active{background:#fff;color:#b45309}
.bm.inactive{background:rgba(255,255,255,.11);color:rgba(255,255,255,.45);border-color:rgba(255,255,255,.16)}
.zone-card{background:#fff;border-radius:13px;margin:0 11px 7px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.07)}
.zone-card-hdr{padding:10px 12px;display:flex;align-items:center;gap:8px}
.zone-icon{width:35px;height:35px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0}
.zone-tags{display:flex;gap:4px;padding:0 12px 9px;flex-wrap:wrap}
.ztag{padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700}
.zone-rules{padding:0 12px 10px}
.zr{display:flex;align-items:flex-start;gap:6px;margin-bottom:5px;font-size:11px;color:#475569;line-height:1.4}

/* â”€â”€ RADAR â”€â”€ */
.rad-wrap{flex:1;background:#050c18;display:flex;flex-direction:column;align-items:center;padding:13px 11px 0;overflow-y:auto;min-height:0}
.rad-circle{position:relative;width:190px;height:190px;margin-bottom:12px;flex-shrink:0}
.rring{position:absolute;border-radius:50%;border:1px solid rgba(74,222,128,.16)}
.rline{position:absolute;background:rgba(74,222,128,.1)}
.rsweep{position:absolute;inset:0;border-radius:50%;overflow:hidden}
.rsi{position:absolute;top:50%;left:50%;width:50%;height:50%;background:conic-gradient(from 0deg,transparent 0deg,rgba(74,222,128,.26) 60deg,transparent 60deg);transform-origin:0 0;animation:sweep 3s linear infinite}
@keyframes sweep{from{transform:rotate(0)}to{transform:rotate(360deg)}}
.rblip{position:absolute;transform:translate(-50%,-50%);cursor:pointer}
.bdot{animation:ping 2s infinite;border-radius:50%}
@keyframes ping{0%,100%{transform:scale(1);opacity:1}50%{transform:scale(1.5);opacity:.45}}
.bname{position:absolute;top:-14px;left:50%;transform:translateX(-50%);font-size:7px;color:#fff;white-space:nowrap;font-weight:700}
.rcenter{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:9px;height:9px;border-radius:50%;background:#3b82f6;box-shadow:0 0 10px #3b82f6}
.rleg{display:flex;gap:7px;margin-bottom:9px;flex-wrap:wrap;justify-content:center}
.rleg span{font-size:9px;font-weight:700}
.rlist{width:100%}
.rsect{color:var(--gold);font-size:9px;font-weight:700;letter-spacing:.8px;padding:6px 3px 3px;font-family:'Syne',sans-serif}
.ritem{display:flex;align-items:center;gap:7px;padding:6px 3px;border-bottom:1px solid rgba(255,255,255,.06)}
.ricon{width:29px;height:29px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:13px;flex-shrink:0}

/* â”€â”€ PROFIL â”€â”€ */
.prof-hdr{padding:17px 15px 26px;text-align:center;background:linear-gradient(135deg,var(--navy),#1a4a8a)}
.pav{width:70px;height:70px;border-radius:50%;background:rgba(255,255,255,.14);margin:0 auto 9px;display:flex;align-items:center;justify-content:center;font-size:34px;border:3px solid rgba(255,255,255,.28);position:relative}
.ghost-badge{position:absolute;bottom:-4px;right:-4px;background:var(--purple);border:2px solid #fff;border-radius:20px;padding:1px 5px;font-size:9px;font-weight:700;color:#fff;display:none}
.ghost-btn{margin:0 11px 9px;border-radius:15px;padding:12px;border:none;cursor:pointer;display:flex;align-items:center;gap:11px;text-align:left;width:calc(100% - 22px);font-family:inherit;transition:all .2s}
.ghost-off{background:linear-gradient(135deg,#1e1b4b,#312e81)}
.ghost-on{background:linear-gradient(135deg,#4c1d95,#6d28d9);box-shadow:0 4px 20px rgba(109,40,217,.45)}
.gpill{padding:4px 10px;border-radius:20px;font-size:11px;font-weight:700}
.gpill-off{background:rgba(255,255,255,.09);color:rgba(255,255,255,.38)}
.gpill-on{background:#a78bfa;color:#fff}
.vis-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px;padding:9px 12px}
.vc{border-radius:10px;padding:9px;text-align:center;cursor:pointer;border:2px solid transparent;transition:all .15s}
.vc.sel{border-color:var(--purple)}
.dsgvo{margin:0 11px 9px;background:linear-gradient(135deg,#0f172a,#1e293b);border-radius:15px;padding:12px}
.danger-row{display:flex;align-items:center;padding:11px 13px;border-bottom:1px solid rgba(255,255,255,.07);gap:9px;cursor:pointer}
.danger-row:last-child{border-bottom:none}
.dicon{width:31px;height:31px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:14px;flex-shrink:0}

/* â”€â”€ NOTFALL â”€â”€ */
.emrg-hdr{background:linear-gradient(135deg,#991b1b,var(--red));padding:17px 17px 21px;text-align:center;flex-shrink:0}
.alarm-btn{width:100%;border:none;border-radius:12px;padding:14px;color:#fff;font-weight:700;font-size:15px;cursor:pointer;font-family:inherit;background:linear-gradient(135deg,#dc2626,var(--red));box-shadow:0 4px 18px rgba(220,38,38,.45);transition:all .2s}
.alarm-btn:disabled{background:#e5e7eb;color:#aaa;box-shadow:none;cursor:default}
.form-inp{width:100%;border:2px solid var(--border);border-radius:10px;padding:10px 12px;font-size:14px;outline:none;font-family:inherit;margin-bottom:11px}
.form-inp:focus{border-color:var(--red)}
.form-label{display:block;font-weight:700;font-size:12px;margin-bottom:5px;color:var(--text)}

/* â”€â”€ AUTH OVERLAY â”€â”€ */
#authOverlay{position:absolute;inset:0;z-index:900;background:linear-gradient(160deg,#070f1e 0%,#0d1f3c 60%,#060d18 100%);display:flex;flex-direction:column;overflow-y:auto}
.auth-logo{text-align:center;padding:36px 0 10px}
.auth-logo-icon{font-size:46px;display:block;margin-bottom:8px}
.auth-logo-title{color:#fff;font-size:24px;font-weight:700;font-family:'Syne',sans-serif;letter-spacing:-.3px}
.auth-logo-sub{color:rgba(255,255,255,.45);font-size:12px;margin-top:4px}
.auth-tabs{display:flex;background:rgba(255,255,255,.07);border-radius:12px;padding:3px;margin:16px 20px 0}
.auth-tab{flex:1;border:none;background:none;color:rgba(255,255,255,.4);font-weight:700;font-size:12px;padding:8px 0;border-radius:9px;cursor:pointer;font-family:'Syne',sans-serif;transition:all .15s}
.auth-tab.active{background:rgba(255,255,255,.12);color:#fff}
.auth-panel{display:none;padding:18px 20px 24px}
.auth-panel.active{display:block}
.auth-inp-wrap{margin-bottom:11px}
.auth-label{display:block;font-size:11px;font-weight:700;color:rgba(255,255,255,.55);margin-bottom:5px;letter-spacing:.4px}
.auth-inp{width:100%;background:rgba(255,255,255,.07);border:1.5px solid rgba(255,255,255,.1);border-radius:11px;padding:11px 13px;font-size:14px;color:#fff;font-family:inherit;outline:none;transition:border .15s}
.auth-inp::placeholder{color:rgba(255,255,255,.25)}
.auth-inp:focus{border-color:rgba(212,168,67,.6);background:rgba(255,255,255,.09)}
.auth-btn{width:100%;background:linear-gradient(135deg,#c49a1f,var(--gold));border:none;border-radius:12px;padding:13px;color:#0a1628;font-weight:700;font-size:14px;cursor:pointer;font-family:'Syne',sans-serif;margin-top:6px;letter-spacing:.2px;transition:opacity .15s}
.auth-btn:hover{opacity:.9}
.auth-or{display:flex;align-items:center;gap:10px;margin:14px 0 12px}
.auth-or span{color:rgba(255,255,255,.2);font-size:11px;white-space:nowrap}
.auth-or::before,.auth-or::after{content:'';flex:1;height:1px;background:rgba(255,255,255,.1)}
.auth-social{display:flex;gap:8px;margin-bottom:14px}
.auth-social-btn{flex:1;background:rgba(255,255,255,.07);border:1.5px solid rgba(255,255,255,.1);border-radius:11px;padding:10px;font-size:12px;font-weight:700;color:#fff;cursor:pointer;font-family:inherit;transition:background .15s}
.auth-social-btn:hover{background:rgba(255,255,255,.12)}
.auth-terms{font-size:10px;color:rgba(255,255,255,.3);text-align:center;line-height:1.5;margin-top:8px}

/* â”€â”€ AVATAR PICKER â”€â”€ */
#avatarPicker{position:absolute;inset:0;z-index:950;background:rgba(5,12,24,.97);display:none;flex-direction:column;align-items:center;justify-content:center;padding:24px}
.avpicker-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin:16px 0}
.avpicker-cell{width:64px;height:64px;border-radius:50%;border:2.5px solid transparent;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:30px;transition:all .15s;background:rgba(255,255,255,.07)}
.avpicker-cell:hover,.avpicker-cell.sel{border-color:var(--gold);background:rgba(212,168,67,.15)}

/* â”€â”€ GOOGLE POPUP â”€â”€ */
#googlePopup{position:absolute;inset:0;z-index:960;background:rgba(5,12,24,.85);align-items:center;justify-content:center;display:none}
#googlePopup.open{display:flex}

/* â”€â”€ FEEDBACK MODAL â”€â”€ */
#feedbackModal{position:absolute;inset:0;background:rgba(10,22,40,.85);z-index:500;display:none;align-items:flex-end;justify-content:center}
#feedbackModal.open{display:flex}
.fb-sheet{background:#fff;border-radius:22px 22px 0 0;padding:20px 18px 28px;width:100%}
.stars-row{display:flex;gap:8px;justify-content:center;margin:12px 0;font-size:26px;cursor:pointer}

/* â”€â”€ ANIMATIONS â”€â”€ */
@keyframes pulseBrut{0%,100%{opacity:1}50%{opacity:.5}}
.pulse-anim{animation:pulseBrut 1.5s infinite}
@keyframes slideUp{from{transform:translateY(20px);opacity:0}to{transform:translateY(0);opacity:1}}
.slide-up{animation:slideUp .3s ease}

/* â”€â”€ PET BANNER â”€â”€ */
.pet-banner{margin:0 11px 15px;border-radius:15px;padding:12px 14px;display:flex;align-items:center;gap:10px;background:linear-gradient(135deg,#c49a1f,var(--gold));box-shadow:0 4px 16px rgba(201,168,76,.42);cursor:pointer}
</style>
</head>
<body>

<!-- Back to landing page -->
<div class="topbar">
  <a class="back-link" href="index.html"><span>â€¹</span> P.G. Dog Radar</a>
  <span class="app-version">Beta v0.9</span>
</div>

<div class="phone-wrap">
<div class="phone">

  <!-- â•â• AUTH OVERLAY â•â• -->
  <div id="authOverlay">
    <div class="auth-logo">
      <span class="auth-logo-icon">ðŸ“¡</span>
      <div class="auth-logo-title">P.G. Dog-Radar</div>
      <div class="auth-logo-sub">Die Community-App fÃ¼r Hundebesitzer in Bremen</div>
    </div>
    <div class="auth-tabs">
      <button class="auth-tab active" id="atab-login" onclick="switchAuthTab('login')">Anmelden</button>
      <button class="auth-tab" id="atab-register" onclick="switchAuthTab('register')">Registrieren</button>
    </div>
    <!-- LOGIN -->
    <div class="auth-panel active" id="apanel-login">
      <div class="auth-inp-wrap">
        <label class="auth-label">E-MAIL</label>
        <input class="auth-inp" id="loginEmail" type="email" placeholder="deine@email.de">
      </div>
      <div class="auth-inp-wrap">
        <label class="auth-label">PASSWORT</label>
        <input class="auth-inp" id="loginPw" type="password" placeholder="â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢">
      </div>
      <div style="text-align:right;margin:-4px 0 12px">
        <span style="color:var(--gold);font-size:11px;cursor:pointer;font-weight:700" onclick="showToast('Passwort-Reset-Mail wird gesendetâ€¦','#d4a843')">Passwort vergessen?</span>
      </div>
      <button class="auth-btn" onclick="doLogin()">â†’ Anmelden</button>
      <div class="auth-or"><span>oder schnell weiter mit</span></div>
      <div class="auth-social">
        <button class="auth-social-btn" onclick="doGuestLogin()">ðŸ‘¤ Demo-Modus</button>
        <button class="auth-social-btn" onclick="showGoogleLogin()">ðŸ“§ E-Mail</button>
      </div>
      <div class="auth-terms">Durch das Anmelden stimmst du unseren Nutzungsbedingungen und der DatenschutzerklÃ¤rung zu.</div>
    </div>
    <!-- REGISTER -->
    <div class="auth-panel" id="apanel-register">
      <div style="display:flex;gap:10px;margin-bottom:11px">
        <div style="flex:1"><label class="auth-label">DEIN NAME</label><input class="auth-inp" id="regName" placeholder="Patrick"></div>
        <div style="flex:1"><label class="auth-label">HUNDE-NAME</label><input class="auth-inp" id="regDog" placeholder="Mucki"></div>
      </div>
      <div class="auth-inp-wrap">
        <label class="auth-label">E-MAIL</label>
        <input class="auth-inp" id="regEmail" type="email" placeholder="deine@email.de">
      </div>
      <div class="auth-inp-wrap">
        <label class="auth-label">PASSWORT</label>
        <input class="auth-inp" id="regPw" type="password" placeholder="Mindestens 8 Zeichen">
      </div>
      <div class="auth-inp-wrap">
        <label class="auth-label">PROFILBILD</label>
        <div style="display:flex;align-items:center;gap:12px;margin-top:6px">
          <div id="selectedAvatar" onclick="openAvatarPicker()" style="width:56px;height:56px;border-radius:50%;background:rgba(255,255,255,.1);border:2.5px dashed rgba(212,168,67,.5);display:flex;align-items:center;justify-content:center;font-size:28px;cursor:pointer">ðŸ•</div>
          <div><div style="color:#fff;font-size:12px;font-weight:700">Profilbild wÃ¤hlen</div><div style="color:rgba(255,255,255,.4);font-size:11px;margin-top:2px">Tippe auf das Emoji â†’</div></div>
        </div>
      </div>
      <button class="auth-btn" onclick="doRegister()">âœ“ Konto erstellen</button>
      <div class="auth-or"><span>oder</span></div>
      <button class="auth-social-btn" style="width:100%" onclick="doGuestLogin()">ðŸ‘¤ Als Gast fortfahren</button>
      <div class="auth-terms" style="margin-top:10px">Mit der Registrierung stimmst du unserer DSGVO-konformen Datenspeicherung zu. Deine Daten bleiben auf EU-Servern.</div>
    </div>
  </div>

  <!-- â•â• GOOGLE / EMAIL POPUP â•â• -->
  <div id="googlePopup">
    <div style="background:#0d1f3c;border:1.5px solid rgba(212,168,67,.3);border-radius:18px;padding:24px 20px;width:82%;max-width:300px">
      <div style="font-size:22px;text-align:center;margin-bottom:8px">ðŸ“§</div>
      <div style="color:#fff;font-weight:700;font-size:15px;text-align:center;font-family:'Syne',sans-serif;margin-bottom:4px">Mit E-Mail anmelden</div>
      <div style="color:rgba(255,255,255,.4);font-size:11px;text-align:center;margin-bottom:16px">Funktioniert mit jeder E-Mail-Adresse</div>
      <div style="margin-bottom:10px"><label class="auth-label">E-MAIL</label><input class="auth-inp" id="googleEmail" type="email" placeholder="deine@email.de"></div>
      <div style="margin-bottom:10px"><label class="auth-label">DEIN NAME</label><input class="auth-inp" id="googleName" placeholder="z.B. Patrick"></div>
      <div style="margin-bottom:16px"><label class="auth-label">HUNDE-NAME</label><input class="auth-inp" id="googleDog" placeholder="z.B. Mucki"></div>
      <button class="auth-btn" onclick="doGoogleLogin()">â†’ Anmelden</button>
      <button onclick="closeGooglePopup()" style="width:100%;background:none;border:none;color:rgba(255,255,255,.35);font-size:12px;margin-top:10px;cursor:pointer;font-family:inherit">Abbrechen</button>
    </div>
  </div>

  <!-- â•â• AVATAR PICKER â•â• -->
  <div id="avatarPicker">
    <div style="color:#fff;font-weight:700;font-size:16px;font-family:'Syne',sans-serif">Profilbild wÃ¤hlen</div>
    <div style="color:rgba(255,255,255,.4);font-size:12px;margin-top:4px">Tippe auf ein Emoji</div>
    <div class="avpicker-grid" id="avGrid"></div>
    <button onclick="closeAvatarPicker()" style="background:var(--gold);border:none;border-radius:11px;padding:11px 32px;font-weight:700;font-size:13px;cursor:pointer;font-family:'Syne',sans-serif">AuswÃ¤hlen âœ“</button>
  </div>

  <!-- â•â• NOTCH â•â• -->
  <div class="notch">
    <span class="notch-time" id="clock">9:41</span>
    <span class="notch-icons">ðŸ“¶ ðŸ”‹</span>
  </div>

  <!-- â•â• APPBAR â•â• -->
  <div class="appbar">
    <div class="appbar-title">ðŸ“¡ P.G. Dog-Radar</div>
    <div style="display:flex;gap:6px;align-items:center">
      <div class="pill pill-orange pulse-anim" id="brutPill" style="display:none">âš ï¸ Brutzeit</div>
      <div class="pill pill-gold" id="headerBadge">ðŸŸ¢ 5 Hunde</div>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• KARTE â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen active" id="s-map">
    <div class="map-wrap">
      <div id="gmap"></div>
      <div id="gmapLoad">
        <div class="gmap-spinner"></div>
        <div style="color:rgba(255,255,255,.5);font-size:12px;font-weight:700;font-family:'Syne',sans-serif;margin-top:4px">Karte wird geladenâ€¦</div>
      </div>

      <!-- Filter bar -->
      <div class="filter-bar">
        <div class="fchip on" style="border-color:#22c55e;color:#4ade80" onclick="toggleF('dogs','#22c55e','#4ade80',this)">ðŸ• Hunde</div>
        <div class="fchip on" style="border-color:#ef4444;color:#fca5a5" onclick="toggleF('leine','#ef4444','#fca5a5',this)">ðŸ”´ Leinenpfl.</div>
        <div class="fchip on" style="border-color:#22c55e;color:#86efac" onclick="toggleF('frei','#22c55e','#86efac',this)">ðŸŸ¢ FreiflÃ¤che</div>
        <div class="fchip on" style="border-color:#0ea5e9;color:#7dd3fc" onclick="toggleF('water','#0ea5e9','#7dd3fc',this)">ðŸ’§ Wasser</div>
        <div class="fchip on" style="border-color:#8b5cf6;color:#c4b5fd" onclick="toggleF('bags','#8b5cf6','#c4b5fd',this)">ðŸ§» Beutel</div>
        <div class="fchip on" style="border-color:#78716c;color:#d6d3d1" onclick="toggleF('bins','#78716c','#d6d3d1',this)">ðŸ—‘ï¸ MÃ¼ll</div>
      </div>

      <!-- Brutzeit Banner -->
      <div class="brut-banner" id="brutMapBanner" onclick="switchScreen('regeln')" style="display:none">
        <span style="font-size:18px">ðŸ¦†</span>
        <div style="flex:1">
          <div style="color:#fff;font-weight:700;font-size:12px">âš ï¸ Brutzeit aktiv! MÃ¤rz â€“ Juli</div>
          <div style="color:rgba(255,255,255,.8);font-size:10px">Naturschutzgebiete: Leine Pflicht Â· Details â†’</div>
        </div>
        <span style="color:rgba(255,255,255,.55);font-size:13px">â€º</span>
      </div>

      <!-- Map Popup -->
      <div class="mpopup" id="mapPopup">
        <div style="display:flex;align-items:center;gap:9px">
          <div id="ppAvatar" style="width:42px;height:42px;border-radius:11px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0"></div>
          <div style="flex:1">
            <div id="ppName" style="font-weight:700;font-size:14px;color:var(--text)"></div>
            <div id="ppSub" style="font-size:11px;color:var(--sub);margin-top:1px"></div>
          </div>
          <button onclick="document.getElementById('mapPopup').classList.remove('open')" style="background:#f1f5f9;border:none;border-radius:50%;width:26px;height:26px;font-size:14px;cursor:pointer;color:#94a3b8;display:flex;align-items:center;justify-content:center">âœ•</button>
        </div>
        <div id="ppTags" style="display:flex;gap:4px;margin-top:9px;flex-wrap:wrap"></div>
        <button id="ppBtn" style="width:100%;margin-top:9px;border:none;border-radius:10px;padding:10px;font-weight:700;font-size:12px;cursor:pointer;display:none;color:#fff;font-family:inherit"></button>
      </div>
    </div>

    <!-- Status Bar -->
    <div class="statusbar-wrap">
      <div style="font-size:9px;color:#888;font-weight:700;letter-spacing:.7px;font-family:'Syne',sans-serif">MEIN HUND GERADE:</div>
      <div class="sbtns">
        <button class="sbtn" id="sb-friendly" onclick="setMyStatus('friendly')" style="border-color:#22c55e;background:#dcfce7"><span class="se">ðŸŸ¢</span><span class="sl" style="color:#22c55e">VertrÃ¤glich</span></button>
        <button class="sbtn" id="sb-notFriendly" onclick="setMyStatus('notFriendly')"><span class="se">ðŸ”´</span><span class="sl">Nicht vertr.</span></button>
        <button class="sbtn" id="sb-inHeat" onclick="setMyStatus('inHeat')"><span class="se">ðŸŒ¸</span><span class="sl">LÃ¤ufig</span></button>
        <button class="sbtn" id="sb-keepDist" onclick="setMyStatus('keepDist')"><span class="se">ðŸŸ¡</span><span class="sl">Abstand</span></button>
      </div>
    </div>
    <div class="rep-bar">
      <button class="rep-btn" onclick="submitReport('Kotbeutelspender LEER','ðŸ“ Aktueller Standort','ðŸ§»','#f97316','#fff7ed')">âš ï¸ Kotbeutelspender LEER melden</button>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• COMMUNITY â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen" id="s-community">
    <div class="comm-head">
      <div style="color:#fff;font-weight:700;font-size:16px;font-family:'Syne',sans-serif">ðŸ¾ Community</div>
      <div class="comm-tabs" style="margin-bottom:0">
        <button class="ctab active" id="ct-feed" onclick="switchCommTab('feed')">ðŸ“° Feed</button>
        <button class="ctab" id="ct-chat" onclick="switchCommTab('chat')">ðŸ’¬ Nachrichten</button>
        <button class="ctab" id="ct-events" onclick="switchCommTab('events')">ðŸ“… Events</button>
      </div>
    </div>

    <!-- FEED -->
    <div id="ct-feed-body" class="scroll" style="padding-top:2px">
      <div class="new-post" style="margin-top:9px">
        <div class="np-row">
          <div class="np-av" id="npAv">ðŸ•</div>
          <textarea class="np-inp" id="newPostText" rows="2" placeholder="Was gibt's Neues? ðŸ¾"></textarea>
        </div>
        <div class="np-btns">
          <button class="np-btn" style="background:#f1f5f9;color:#64748b" onclick="showToast('Foto-Upload kommt in v1.1 ðŸ“¸','#6366f1')">ðŸ“¸ Foto</button>
          <button class="np-btn" style="background:var(--navy);color:var(--gold)" onclick="postToFeed()">Posten â†’</button>
        </div>
      </div>
      <div class="warn-card">
        <div class="warn-hdr">
          <span style="font-size:21px">ðŸ¦†</span>
          <div style="flex:1"><div style="color:#fff;font-weight:700;font-size:13px">âš ï¸ Brutzeit-Warnung</div><div style="color:rgba(255,255,255,.65);font-size:10px">P.G. Dog-Radar System Â· Jetzt aktiv</div></div>
          <div style="background:rgba(255,255,255,.14);color:#fff;padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700" class="pulse-anim">âš ï¸ AKTIV</div>
        </div>
        <div class="warn-body"><b style="color:#fff">MÃ¤rz bis Juli</b> ist Brut- und Nistzeit! Bitte Hunde anleinen und BÃ¼sche meiden â€” besonders am Werdersee und BÃ¼rgerpark.</div>
        <div class="warn-tags"><span class="wtag">ðŸ¦† Enten</span><span class="wtag">ðŸ‡ Hasen</span><span class="wtag">ðŸ¦… GreifvÃ¶gel</span><span class="wtag">ðŸŒ¿ BodenbrÃ¼ter</span></div>
      </div>
      <div class="post-card">
        <div class="post-hdr">
          <div class="post-av" style="background:#dcfce7">ðŸ•</div>
          <div><div class="post-name">Sandra &amp; Bello</div><div class="post-when">Vor 12 Min Â· Werdersee</div></div>
          <div class="post-badge" style="background:#dcfce7;color:#166534">ðŸŸ¢ VertrÃ¤glich</div>
        </div>
        <div class="post-body">ðŸš¨ <b>GiftkÃ¶der-Alarm</b> am nÃ¶rdlichen Werdersee-Weg! Heute Morgen gefunden. Bitte Augen auf!</div>
        <div class="post-acts">
          <button class="pact" id="like-1" onclick="toggleLike('like-1','lc-1',this)">â¤ï¸ <span id="lc-1">14</span></button>
          <button class="pact" onclick="showToast('Kommentare kommen bald ðŸ’¬','#6366f1')">ðŸ’¬ 7</button>
          <button class="pact" onclick="showToast('Link kopiert! ðŸ”—','#22c55e')">ðŸ”— Teilen</button>
        </div>
      </div>
      <div class="post-card">
        <div class="post-hdr">
          <div class="post-av" style="background:#e0f2fe">ðŸ©</div>
          <div><div class="post-name">Max &amp; Lola</div><div class="post-when">Vor 1 Std Â· BÃ¼rgerpark</div></div>
          <div class="post-badge" style="background:#fce7f3;color:#9d174d">ðŸŒ¸ LÃ¤ufig</div>
        </div>
        <div class="post-body">Hundebrunnen im BÃ¼rgerpark funktioniert wieder! Lola hat gleich ausgiebig getrunken ðŸ’§ðŸ˜„</div>
        <div class="post-acts">
          <button class="pact" id="like-2" onclick="toggleLike('like-2','lc-2',this)">â¤ï¸ <span id="lc-2">31</span></button>
          <button class="pact" onclick="showToast('Kommentare kommen bald ðŸ’¬','#6366f1')">ðŸ’¬ 12</button>
          <button class="pact" onclick="showToast('Link kopiert! ðŸ”—','#22c55e')">ðŸ”— Teilen</button>
        </div>
      </div>
      <div class="post-card">
        <div class="post-hdr">
          <div class="post-av" style="background:#fef9c3">ðŸ¦®</div>
          <div><div class="post-name">Team Hundesteuer</div><div class="post-when">Vor 3 Std Â· Bremen</div></div>
          <div class="post-badge" style="background:#fef9c3;color:#713f12">ðŸ“¢ Petition</div>
        </div>
        <div class="post-body">ðŸŽ‰ <b>95 Unterschriften</b> erreicht! Noch 155 bis zum Ziel. c.org/DnjNThsv5x ðŸ’ªðŸ¾</div>
        <div class="post-acts">
          <button class="pact" id="like-3" onclick="toggleLike('like-3','lc-3',this)">â¤ï¸ <span id="lc-3">47</span></button>
          <button class="pact" onclick="showToast('Kommentare kommen bald ðŸ’¬','#6366f1')">ðŸ’¬ 23</button>
          <button class="pact" onclick="showToast('Petition-Link kopiert! ðŸ¾','#C9A84C')">ðŸ”— Teilen</button>
        </div>
      </div>
      <div id="newPostsArea"></div>
      <div style="height:13px"></div>
    </div>

    <!-- CHAT LIST -->
    <div id="ct-chat-body" class="scroll" style="display:none;padding-top:5px">
      <div class="sec">NACHRICHTEN</div>
      <div class="chat-item" onclick="openChat('Sandra &amp; Bello','ðŸ•','#dcfce7',true)">
        <div class="chat-av" style="background:#dcfce7">ðŸ•<div class="chat-online"></div></div>
        <div style="flex:1"><div style="font-weight:700;font-size:13px">Sandra &amp; Bello</div><div style="font-size:11px;color:var(--sub)">Danke fÃ¼r den Tipp mit dem Brunnen!</div></div>
        <div style="text-align:right"><div style="font-size:10px;color:var(--sub)">12:34</div><div class="chat-unread" style="margin-top:3px">2</div></div>
      </div>
      <div class="chat-item" onclick="openChat('Max &amp; Lola','ðŸ©','#e0f2fe',true)">
        <div class="chat-av" style="background:#e0f2fe">ðŸ©<div class="chat-online"></div></div>
        <div style="flex:1"><div style="font-weight:700;font-size:13px">Max &amp; Lola</div><div style="font-size:11px;color:var(--sub)">Treffen morgen am Werdersee?</div></div>
        <div style="text-align:right"><div style="font-size:10px;color:var(--sub)">11:20</div></div>
      </div>
      <div class="chat-item" onclick="openChat('Tierheim Bremen','ðŸ ','#fef9c3',false)">
        <div class="chat-av" style="background:#fef9c3">ðŸ <div class="chat-online" style="background:#94a3b8"></div></div>
        <div style="flex:1"><div style="font-weight:700;font-size:13px">Tierheim Bremen</div><div style="font-size:11px;color:var(--sub)">Danke fÃ¼r eure UnterstÃ¼tzung! ðŸ™</div></div>
        <div style="text-align:right"><div style="font-size:10px;color:var(--sub)">Gestern</div></div>
      </div>
      <div class="chat-item" onclick="openChat('Gassi-Gruppe Werdersee','ðŸŒ¿','#dcfce7',true)">
        <div class="chat-av" style="background:#dcfce7">ðŸŒ¿<div class="chat-online"></div></div>
        <div style="flex:1"><div style="font-weight:700;font-size:13px">Gassi-Gruppe Werdersee</div><div style="font-size:11px;color:var(--sub)">Karl: Sehe ich euch Samstag?</div></div>
        <div style="text-align:right"><div style="font-size:10px;color:var(--sub)">Mo</div><div class="chat-unread" style="margin-top:3px">5</div></div>
      </div>
    </div>

    <!-- CHAT WINDOW -->
    <div id="chatWindow" class="chat-win" style="display:none">
      <div class="chat-win-hdr">
        <button onclick="closeChat()" style="background:none;border:none;color:#fff;font-size:22px;cursor:pointer">â€¹</button>
        <div id="cwAv" style="width:33px;height:33px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:16px"></div>
        <div style="color:#fff;font-weight:700;font-size:13px" id="cwName"></div>
        <div style="margin-left:auto;width:8px;height:8px;border-radius:50%" id="cwOnline"></div>
      </div>
      <div class="chat-msgs" id="chatMsgs"></div>
      <div class="chat-inp-wrap">
        <input class="chat-inp" id="chatInp" placeholder="Nachrichtâ€¦" onkeydown="if(event.key==='Enter')sendMsg()">
        <button class="chat-send" onclick="sendMsg()">âž¤</button>
      </div>
    </div>

    <!-- EVENTS -->
    <div id="ct-events-body" class="scroll" style="display:none;padding:9px 0">
      <div class="sec">KOMMENDE EVENTS</div>
      <div class="evt-card">
        <div class="evt-hdr" style="background:linear-gradient(135deg,#166534,#22c55e)">
          <span style="font-size:22px">ðŸ•</span>
          <div style="flex:1"><div style="color:#fff;font-weight:700;font-size:13px">Gassi-Treff Werdersee</div><div style="color:rgba(255,255,255,.78);font-size:11px">Sa 15. MÃ¤rz Â· 10:00 Uhr</div></div>
          <div style="background:rgba(255,255,255,.2);color:#fff;padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700">12 dabei</div>
        </div>
        <div class="evt-body">Gemeinsamer Spaziergang rund um den Werdersee. Alle Hunde willkommen!</div>
        <div class="evt-btns">
          <button class="evt-join" style="background:#dcfce7;color:#166534" onclick="showToast('âœ… Du nimmst teil!','#22c55e')">âœ… Teilnehmen</button>
          <button onclick="showToast('Event geteilt! ðŸ”—','#6366f1')" style="background:#f1f5f9;border:none;border-radius:10px;padding:8px 13px;font-size:13px;cursor:pointer">ðŸ”—</button>
        </div>
      </div>
      <div class="evt-card">
        <div class="evt-hdr" style="background:linear-gradient(135deg,#1e40af,#3b82f6)">
          <span style="font-size:22px">ðŸ“‹</span>
          <div style="flex:1"><div style="color:#fff;font-weight:700;font-size:13px">Hundesteuer Demo</div><div style="color:rgba(255,255,255,.78);font-size:11px">Sa 22. MÃ¤rz Â· 14:00 Â· Marktplatz</div></div>
          <div style="background:rgba(255,255,255,.2);color:#fff;padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700">38 dabei</div>
        </div>
        <div class="evt-body">Friedliche Kundgebung gegen die 156â‚¬ Hundesteuer. Bring Mucki mit! ðŸ¾</div>
        <div class="evt-btns">
          <button class="evt-join" style="background:#dbeafe;color:#1e40af" onclick="showToast('âœ… Du nimmst teil!','#3b82f6')">âœ… Teilnehmen</button>
          <button onclick="showToast('Event geteilt! ðŸ”—','#6366f1')" style="background:#f1f5f9;border:none;border-radius:10px;padding:8px 13px;font-size:13px;cursor:pointer">ðŸ”—</button>
        </div>
      </div>
      <div style="margin:0 11px">
        <button onclick="showToast('Event erstellen kommt in v1.1 ðŸš€','#0a1628')" style="width:100%;background:var(--navy);border:none;border-radius:13px;padding:12px;color:var(--gold);font-weight:700;font-size:13px;cursor:pointer;font-family:inherit;margin-bottom:13px">âž• Event erstellen</button>
      </div>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• REGELN â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen" id="s-regeln">
    <div class="rules-hdr">
      <div style="color:#fff;font-weight:700;font-size:17px;font-family:'Syne',sans-serif">ðŸ“‹ Leinenpflicht &amp; Brutzeit</div>
      <div style="color:rgba(255,255,255,.65);font-size:11px;margin-top:2px">Bremen â€” aktuelle Regeln &amp; Saison-Warnungen</div>
    </div>
    <div class="scroll" style="padding-top:9px">
      <div class="brut-big">
        <div style="color:#fff;font-weight:700;font-size:14px;display:flex;align-items:center;gap:7px;margin-bottom:6px">
          ðŸ¦† Brut- und Nistzeit
          <span id="brutActive" style="display:none;background:rgba(255,255,255,.22);padding:2px 8px;border-radius:20px;font-size:9px" class="pulse-anim">âš ï¸ JETZT AKTIV</span>
        </div>
        <div style="color:rgba(255,255,255,.82);font-size:12px;line-height:1.5;margin-bottom:2px">Vom <b style="color:#fff">01. MÃ¤rz bis 15. Juli</b> brÃ¼ten WildvÃ¶gel und Kleintiere am Boden. Hunde mÃ¼ssen in Naturschutzgebieten angeleint bleiben.</div>
        <div class="brut-months" id="brutMonths"></div>
      </div>
      <div class="sec" style="padding-top:4px">LEINENPFLICHT-ZONEN BREMEN</div>
      <div class="zone-card">
        <div class="zone-card-hdr">
          <div class="zone-icon" style="background:#fee2e2">ðŸ”´</div>
          <div><div style="font-weight:700;font-size:13px">Naturschutzgebiet Werdersee</div><div style="font-size:11px;color:var(--sub)">GanzjÃ¤hrig Â· BuÃŸgeld bis 1.000â‚¬</div></div>
        </div>
        <div class="zone-tags">
          <span class="ztag" style="background:#fee2e2;color:#991b1b">ðŸ”´ Pflicht</span>
          <span class="ztag" style="background:#fef9c3;color:#713f12">âš ï¸ Brutzeit</span>
          <span class="ztag" style="background:#f1f5f9;color:#475569">GanzjÃ¤hrig</span>
        </div>
        <div class="zone-rules">
          <div class="zr"><span>ðŸš«</span>Freilauf verboten Â· auch Ausbildungshunde</div>
          <div class="zr"><span>ðŸ’¶</span>BuÃŸgeld 50â€“1.000â‚¬ bei VerstoÃŸ</div>
        </div>
      </div>
      <div class="zone-card">
        <div class="zone-card-hdr">
          <div class="zone-icon" style="background:#dcfce7">ðŸŸ¢</div>
          <div><div style="font-weight:700;font-size:13px">FreilaufflÃ¤che Werdersee SÃ¼d</div><div style="font-size:11px;color:var(--sub)">EingezÃ¤unt Â· 0,8 ha</div></div>
        </div>
        <div class="zone-tags">
          <span class="ztag" style="background:#dcfce7;color:#166534">âœ… Freilauf OK</span>
          <span class="ztag" style="background:#dbeafe;color:#1e40af">EingezÃ¤unt</span>
        </div>
        <div class="zone-rules">
          <div class="zr"><span>âœ…</span>Kein Leinenzwang Â· auch in Brutzeit</div>
          <div class="zr"><span>ðŸ’§</span>Wasserstation vorhanden</div>
        </div>
      </div>
      <div class="zone-card">
        <div class="zone-card-hdr">
          <div class="zone-icon" style="background:#fef9c3">ðŸŸ¡</div>
          <div><div style="font-weight:700;font-size:13px">BÃ¼rgerpark Bremen</div><div style="font-size:11px;color:var(--sub)">Teilweise Leinenpflicht</div></div>
        </div>
        <div class="zone-tags">
          <span class="ztag" style="background:#fef9c3;color:#713f12">ðŸŸ¡ Teils Pflicht</span>
          <span class="ztag" style="background:#fce7f3;color:#9d174d">ðŸŒ¸ Brutzeit âš ï¸</span>
        </div>
        <div class="zone-rules">
          <div class="zr"><span>âš ï¸</span>MÃ¤rzâ€“Juli: Alle Wege Leinenpflicht</div>
          <div class="zr"><span>âœ…</span>Rest des Jahres: Leine empfohlen</div>
        </div>
      </div>
      <div class="sec">BRUTZEIT-KALENDER</div>
      <div class="card" style="padding:9px 11px 11px">
        <div style="display:grid;grid-template-columns:repeat(6,1fr);gap:4px" id="calGrid"></div>
      </div>
      <div class="sec">MITMACHEN</div>
      <div class="pet-banner" onclick="showToast('Petition: c.org/DnjNThsv5x ðŸ¾','#d4a843')">
        <span style="font-size:28px">ðŸ¾</span>
        <div style="flex:1">
          <div style="font-weight:700;font-size:13px;color:var(--navy)">Hundesteuer abschaffen!</div>
          <div style="font-size:11px;color:rgba(10,22,40,.7)">Jetzt mitzeichnen Â· c.org/DnjNThsv5x</div>
        </div>
        <span style="color:rgba(10,22,40,.5);font-size:16px">â€º</span>
      </div>
      <div style="height:13px"></div>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• RADAR â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen" id="s-radar">
    <div class="rad-wrap">
      <div style="color:var(--gold);font-weight:700;font-size:13px;margin-bottom:10px;align-self:flex-start;font-family:'Syne',sans-serif">ðŸ“¡ Live-Radar Â· Werdersee</div>
      <div class="rad-circle">
        <div class="rring" style="inset:0"></div>
        <div class="rring" style="inset:20%"></div>
        <div class="rring" style="inset:40%"></div>
        <div class="rring" style="inset:60%"></div>
        <div class="rline" style="top:0;bottom:0;left:50%;width:1px"></div>
        <div class="rline" style="left:0;right:0;top:50%;height:1px"></div>
        <div class="rsweep"><div class="rsi"></div></div>
        <div class="rcenter"></div>
        <div class="rblip" style="left:68%;top:32%"><div class="bdot" style="width:8px;height:8px;background:#22c55e;box-shadow:0 0 8px #22c55e"></div><div class="bname" style="color:#4ade80">Bella</div></div>
        <div class="rblip" style="left:42%;top:72%"><div class="bdot" style="width:8px;height:8px;background:#ef4444;box-shadow:0 0 8px #ef4444"></div><div class="bname" style="color:#fca5a5">Rocky</div></div>
        <div class="rblip" style="left:28%;top:45%"><div class="bdot" style="width:7px;height:7px;background:#f59e0b;box-shadow:0 0 6px #f59e0b"></div><div class="bname" style="color:#fcd34d">Luna</div></div>
        <div class="rblip" style="left:78%;top:60%"><div class="bdot" style="width:6px;height:6px;background:#8b5cf6;box-shadow:0 0 6px #8b5cf6"></div><div class="bname" style="color:#c4b5fd">Max</div></div>
        <div class="rblip" style="left:55%;top:20%"><div class="bdot" style="width:6px;height:6px;background:#0ea5e9;box-shadow:0 0 6px #0ea5e9"></div><div class="bname" style="color:#7dd3fc">Lola</div></div>
      </div>
      <div class="rleg">
        <span style="color:#4ade80">ðŸŸ¢ VertrÃ¤glich</span>
        <span style="color:#fca5a5">ðŸ”´ Vorsicht</span>
        <span style="color:#fcd34d">ðŸŸ¡ Abstand</span>
        <span style="color:#c4b5fd">ðŸŸ£ Unbekannt</span>
      </div>
      <div class="rlist">
        <div class="rsect">IN DER NÃ„HE</div>
        <div class="ritem"><div class="ricon" style="background:#dcfce7">ðŸ•</div><div style="flex:1"><div style="color:#fff;font-size:12px;font-weight:700">Bella Â· Golden Retriever</div><div style="color:rgba(255,255,255,.5);font-size:10px">85m entfernt Â· Sandra</div></div><span style="font-size:11px;color:#4ade80;font-weight:700">ðŸŸ¢</span></div>
        <div class="ritem"><div class="ricon" style="background:#fee2e2">ðŸ•</div><div style="flex:1"><div style="color:#fff;font-size:12px;font-weight:700">Rocky Â· Rottweiler</div><div style="color:rgba(255,255,255,.5);font-size:10px">142m entfernt Â· Klaus</div></div><span style="font-size:11px;color:#fca5a5;font-weight:700">ðŸ”´</span></div>
        <div class="ritem"><div class="ricon" style="background:#fef3c7">ðŸ•</div><div style="flex:1"><div style="color:#fff;font-size:12px;font-weight:700">Luna Â· Husky Mix</div><div style="color:rgba(255,255,255,.5);font-size:10px">210m entfernt Â· Maria</div></div><span style="font-size:11px;color:#fcd34d;font-weight:700">ðŸŸ¡</span></div>
        <div class="rsect" style="margin-top:5px">INFRASTRUKTUR</div>
        <div class="ritem"><div class="ricon" style="background:#e0f2fe">ðŸ’§</div><div style="flex:1"><div style="color:#fff;font-size:12px;font-weight:700">Hundebrunnen Werdersee</div><div style="color:#4ade80;font-size:10px">âœ… Aktiv Â· 95m</div></div></div>
        <div class="ritem"><div class="ricon" style="background:#ede9fe">ðŸ§»</div><div style="flex:1"><div style="color:#fff;font-size:12px;font-weight:700">Beutelspender Eingang</div><div style="color:#4ade80;font-size:10px">âœ… BefÃ¼llt Â· 110m</div></div></div>
        <div style="height:13px"></div>
      </div>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• PROFIL â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen" id="s-profil">
    <div class="scroll">
      <div class="prof-hdr">
        <div class="pav" id="profAv">ðŸ•<div class="ghost-badge" id="ghostBadge">ðŸ‘»</div></div>
        <div style="color:#fff;font-weight:700;font-size:16px;font-family:'Syne',sans-serif" id="profDogName">Mucki</div>
        <div style="color:rgba(255,255,255,.65);font-size:11px;margin-top:3px" id="profSub">Labrador Mix Â· 3 Jahre Â· Sichtbar fÃ¼r alle</div>
        <div id="profStatusBadge" style="display:inline-flex;align-items:center;gap:5px;background:#dcfce7;padding:4px 11px;border-radius:20px;margin-top:8px">
          <span>ðŸŸ¢</span><span style="font-size:11px;font-weight:700;color:#22c55e">VertrÃ¤glich</span>
        </div>
      </div>
      <div style="height:10px"></div>
      <div class="sec">STATUS SETZEN</div>
      <div class="card">
        <div style="padding:10px 12px">
          <div class="sbtns">
            <button class="sbtn" id="sb-friendly2" onclick="setMyStatus('friendly')" style="border-color:#22c55e;background:#dcfce7"><span class="se">ðŸŸ¢</span><span class="sl" style="color:#22c55e">VertrÃ¤glich</span></button>
            <button class="sbtn" id="sb-notFriendly2" onclick="setMyStatus('notFriendly')"><span class="se">ðŸ”´</span><span class="sl">Nicht vertr.</span></button>
            <button class="sbtn" id="sb-inHeat2" onclick="setMyStatus('inHeat')"><span class="se">ðŸŒ¸</span><span class="sl">LÃ¤ufig</span></button>
            <button class="sbtn" id="sb-keepDist2" onclick="setMyStatus('keepDist')"><span class="se">ðŸŸ¡</span><span class="sl">Abstand</span></button>
          </div>
        </div>
      </div>
      <div class="sec">GHOST-MODUS</div>
      <button class="ghost-btn ghost-off" id="ghostBtn" onclick="toggleGhost()">
        <span style="font-size:24px">ðŸ‘»</span>
        <div style="flex:1"><div style="color:#fff;font-weight:700;font-size:13px">Unsichtbar-Modus</div><div style="color:rgba(255,255,255,.5);font-size:11px">Du siehst alle, niemand sieht dich</div></div>
        <span class="gpill gpill-off" id="ghostPill">AUS</span>
      </button>
      <div class="sec">SICHTBARKEIT</div>
      <div class="card">
        <div class="vis-grid">
          <div class="vc sel" id="vis-all" style="background:#dcfce7" onclick="setVis('all','#dcfce7','#22c55e','Alle')"><div style="font-size:19px">ðŸŒ</div><div style="font-size:10px;font-weight:700;color:#166534;margin-top:4px">Alle</div></div>
          <div class="vc" id="vis-friends" onclick="setVis('friends','#dbeafe','#3b82f6','Nur Freunde')"><div style="font-size:19px">ðŸ‘¥</div><div style="font-size:10px;font-weight:700;color:#1e40af;margin-top:4px">Freunde</div></div>
          <div class="vc" id="vis-500m" onclick="setVis('500m','#fef9c3','#ca8a04','500m Radius')"><div style="font-size:19px">ðŸ“</div><div style="font-size:10px;font-weight:700;color:#713f12;margin-top:4px">500m</div></div>
          <div class="vc" id="vis-none" onclick="setVis('none','#fee2e2','#ef4444','Niemand')"><div style="font-size:19px">ðŸš«</div><div style="font-size:10px;font-weight:700;color:#991b1b;margin-top:4px">Niemand</div></div>
        </div>
      </div>
      <div class="sec">DATENSCHUTZ</div>
      <div class="dsgvo">
        <div class="trow" style="border-color:rgba(255,255,255,.08)"><div class="tl"><div class="tt" style="color:#fff">Standort-Tracking</div><div class="ts" style="color:rgba(255,255,255,.45)">Nur wÃ¤hrend der App-Nutzung</div></div><label class="tog"><input type="checkbox" checked><span class="tog-sl"></span></label></div>
        <div class="trow" style="border-color:rgba(255,255,255,.08)"><div class="tl"><div class="tt" style="color:#fff">Anonymer Modus</div><div class="ts" style="color:rgba(255,255,255,.45)">Name wird nicht angezeigt</div></div><label class="tog"><input type="checkbox"><span class="tog-sl purple"></span></label></div>
        <div class="trow"><div class="tl"><div class="tt" style="color:#fff">Push-Benachrichtigungen</div><div class="ts" style="color:rgba(255,255,255,.45)">Warnungen &amp; Meldungen</div></div><label class="tog"><input type="checkbox" checked><span class="tog-sl"></span></label></div>
      </div>
      <div class="sec">KONTO</div>
      <div class="card">
        <div class="danger-row"><div class="dicon" style="background:#dcfce7">ðŸ‘¤</div><div style="flex:1"><div class="tt" id="profilEmail">demo@dogradar.de</div><div class="ts">Angemeldet Â· E-Mail verifiziert</div></div><span style="background:#dcfce7;color:#166534;padding:2px 8px;border-radius:20px;font-size:9px;font-weight:700">âœ… Aktiv</span></div>
        <div class="danger-row" onclick="showToast('Daten werden exportiert... ðŸ“¦','#3b82f6')"><div class="dicon" style="background:#dbeafe">ðŸ“¦</div><div style="flex:1"><div class="tt">Meine Daten exportieren</div><div class="ts">DSGVO-konform Â· ZIP-Datei</div></div><span style="color:#94a3b8;font-size:14px">â€º</span></div>
        <div class="danger-row" onclick="doLogout()"><div class="dicon" style="background:#fef9c3">ðŸšª</div><div style="flex:1"><div class="tt">Abmelden</div><div class="ts">ZurÃ¼ck zum Login</div></div><span style="color:#94a3b8;font-size:14px">â€º</span></div>
        <div class="danger-row" onclick="showToast('Konto wird gelÃ¶scht... ðŸ—‘ï¸','#ef4444')"><div class="dicon" style="background:#fee2e2">ðŸ—‘ï¸</div><div style="flex:1"><div class="tt" style="color:#ef4444">Konto lÃ¶schen</div><div class="ts">Alle Daten unwiderruflich lÃ¶schen</div></div><span style="color:#94a3b8;font-size:14px">â€º</span></div>
      </div>
      <div class="sec">APP HINZUFÃœGEN</div>
      <div class="card" style="padding:11px 13px"><div style="font-size:11px;color:#475569;line-height:1.6"><b>iPhone:</b> Safari â†’ Teilen â†’ â€žZum Home-Bildschirm"<br><b>Android:</b> Chrome â†’ â‹® â†’ â€žZum Startbildschirm hinzufÃ¼gen"</div></div>
      <div style="height:13px"></div>
    </div>
  </div>

  <!-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• NOTFALL â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
  <div class="screen" id="s-notfall">
    <div class="emrg-hdr">
      <div style="font-size:32px">ðŸš¨</div>
      <div style="color:#fff;font-weight:700;font-size:18px;margin-top:6px;font-family:'Syne',sans-serif">Notfall-Alarm</div>
      <div style="color:rgba(255,255,255,.78);font-size:11px;margin-top:3px">Alle Hunde-Nutzer im 2km Umkreis werden sofort benachrichtigt</div>
    </div>
    <div class="scroll" style="padding:13px 11px">
      <div class="card" style="padding:13px">
        <label class="form-label">Dein Name / Hund</label>
        <input class="form-inp" id="emrgName" placeholder="z.B. Patrick &amp; Mucki" oninput="checkAlarm()">
        <label class="form-label">Telefonnummer</label>
        <input class="form-inp" id="emrgPhone" placeholder="+49 421â€¦" oninput="checkAlarm()">
        <label class="form-label">Notfall-Typ</label>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-bottom:12px">
          <button onclick="showToast('Typ: Verletzung gewÃ¤hlt','#ef4444')" style="background:#fee2e2;border:none;border-radius:9px;padding:9px;font-size:12px;font-weight:700;color:#991b1b;cursor:pointer">ðŸ©¹ Verletzung</button>
          <button onclick="showToast('Typ: GiftkÃ¶der gewÃ¤hlt','#f59e0b')" style="background:#fef3c7;border:none;border-radius:9px;padding:9px;font-size:12px;font-weight:700;color:#713f12;cursor:pointer">â˜ ï¸ GiftkÃ¶der</button>
          <button onclick="showToast('Typ: Verloren gewÃ¤hlt','#3b82f6')" style="background:#dbeafe;border:none;border-radius:9px;padding:9px;font-size:12px;font-weight:700;color:#1e40af;cursor:pointer">ðŸ” Hund verloren</button>
          <button onclick="showToast('Typ: Angriff gewÃ¤hlt','#8b5cf6')" style="background:#ede9fe;border:none;border-radius:9px;padding:9px;font-size:12px;font-weight:700;color:#5b21b6;cursor:pointer">âš¡ Angriff</button>
        </div>
        <button class="alarm-btn" id="alarmBtn" onclick="sendAlarm()" disabled>ðŸš¨ ALARM JETZT SENDEN</button>
      </div>
      <div class="sec">NOTFALLNUMMERN</div>
      <div class="card">
        <div class="danger-row" onclick="showToast('ðŸ“ž Tierarzt-Notaufnahme wird gewÃ¤hltâ€¦','#22c55e')"><div class="dicon" style="background:#dcfce7">ðŸ¥</div><div style="flex:1"><div class="tt">Tierarzt-Notaufnahme</div><div class="ts">24h Â· TierÃ¤rztliche Notfallpraxis Bremen</div></div><span style="color:#22c55e;font-weight:700;font-size:12px">ðŸ“ž Anrufen</span></div>
        <div class="danger-row" onclick="showToast('ðŸ“ž Tierheim wird gewÃ¤hltâ€¦','#3b82f6')"><div class="dicon" style="background:#dbeafe">ðŸ </div><div style="flex:1"><div class="tt">Tierheim Bremen</div><div class="ts">Hemmstr. 491 Â· Moâ€“Fr 10â€“17h</div></div><span style="color:#3b82f6;font-weight:700;font-size:12px">ðŸ“ž Anrufen</span></div>
        <div class="danger-row" onclick="showToast('ðŸ“ž Polizei wird gewÃ¤hltâ€¦','#6366f1')"><div class="dicon" style="background:#ede9fe">ðŸ‘®</div><div style="flex:1"><div class="tt">Polizei Bremen</div><div class="ts">GiftkÃ¶der, Angriff, Straftat</div></div><span style="color:#6366f1;font-weight:700;font-size:12px">ðŸ“ž 110</span></div>
      </div>
      <div style="height:13px"></div>
    </div>
  </div>

  <!-- â•â• BOTTOM NAV â•â• -->
  <div class="bnav">
    <button class="nb active" id="nav-map" onclick="switchScreen('map')"><span class="nb-icon">ðŸ—ºï¸</span><span class="nb-label">KARTE</span></button>
    <button class="nb" id="nav-community" onclick="switchScreen('community')"><span class="nb-icon">ðŸ¾</span><span class="nb-label">COMMUNITY</span><span class="nb-badge">3</span></button>
    <button class="nb" id="nav-regeln" onclick="switchScreen('regeln')"><span class="nb-icon">ðŸ“‹</span><span class="nb-label">REGELN</span></button>
    <button class="nb" id="nav-radar" onclick="switchScreen('radar')"><span class="nb-icon">ðŸ“¡</span><span class="nb-label">RADAR</span></button>
    <button class="nb" id="nav-profil" onclick="switchScreen('profil')"><span class="nb-icon">ðŸ•</span><span class="nb-label">PROFIL</span></button>
    <button class="nb" id="nav-notfall" onclick="switchScreen('notfall')"><span class="nb-icon">ðŸš¨</span><span class="nb-label">NOTFALL</span></button>
  </div>

  <!-- TOAST -->
  <div class="toast" id="toast"></div>

  <!-- FEEDBACK BUTTON -->
  <button onclick="document.getElementById('feedbackModal').classList.add('open')" style="position:absolute;right:12px;bottom:72px;background:linear-gradient(135deg,#c49a1f,var(--gold));border:none;border-radius:50%;width:44px;height:44px;font-size:20px;cursor:pointer;box-shadow:0 4px 16px rgba(212,168,67,.5);z-index:100">ðŸ’¬</button>

  <!-- FEEDBACK MODAL -->
  <div id="feedbackModal">
    <div class="fb-sheet">
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:4px">
        <div style="font-weight:700;font-size:15px">Feedback geben ðŸ¾</div>
        <button onclick="document.getElementById('feedbackModal').classList.remove('open')" style="background:none;border:none;font-size:20px;cursor:pointer;color:#999">âœ•</button>
      </div>
      <div style="font-size:12px;color:var(--sub)">Wie findest du P.G. Dog-Radar?</div>
      <div class="stars-row" id="stars" onclick="rateStar(Array.from(this.children).indexOf(event.target)+1)">
        <span>â˜†</span><span>â˜†</span><span>â˜†</span><span>â˜†</span><span>â˜†</span>
      </div>
      <textarea id="feedbackText" style="width:100%;border:2px solid var(--border);border-radius:11px;padding:9px 11px;font-size:12px;font-family:inherit;outline:none;resize:none;margin-bottom:10px" rows="3" placeholder="Was gefÃ¤llt dir? Was fehlt noch?"></textarea>
      <a id="mailLink" href="mailto:info@dog-radar.de" onclick="sendFeedback()" style="display:block;background:var(--navy);border-radius:11px;padding:11px;color:var(--gold);font-weight:700;font-size:13px;text-align:center;text-decoration:none">ðŸ“§ Feedback senden</a>
    </div>
  </div>

</div><!-- /phone -->
</div><!-- /phone-wrap -->

<!-- Base44 API Client -->
<script src="api.js"></script>

<script>
/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   STATE
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
var toastTimer;
var ghostMode    = false;
var currentStatus = 'friendly';
var currentUser  = null;
var selectedAv   = 'ðŸ•';
var postsCache   = {};   // id -> {likes, element}

var STATUS = {
  friendly:    {emoji:'ðŸŸ¢', label:'VertrÃ¤glich',       color:'#22c55e', bg:'#dcfce7'},
  notFriendly: {emoji:'ðŸ”´', label:'Nicht vertrÃ¤glich', color:'#ef4444', bg:'#fee2e2'},
  inHeat:      {emoji:'ðŸŒ¸', label:'LÃ¤ufig',            color:'#ec4899', bg:'#fce7f3'},
  keepDist:    {emoji:'ðŸŸ¡', label:'Abstand halten',    color:'#f59e0b', bg:'#fef3c7'}
};

var AVATARS = ['ðŸ•','ðŸ©','ðŸ¦®','ðŸˆ','ðŸ‡','ðŸ¦œ','ðŸ¾','ðŸ ','ðŸ¦Š','ðŸº','ðŸ»','ðŸ¼','ðŸ¦','ðŸ¯','ðŸ¨','ðŸ¦'];

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   INIT â€” session restore & data load
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
window.addEventListener('DOMContentLoaded', function() {
  initBrutzeit();
  updateClock();
  setInterval(updateClock, 10000);
  buildAvatarGrid();

  // Restore session if exists
  var session = DB.loadSession();
  if (session && session.id) {
    currentUser = session;
    finishLoginUI(session, false);
  }

  // Load posts & meldungen from DB
  loadPostsFromDB();
  loadMeldungenFromDB();
});

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   CLOCK
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function updateClock() {
  var d = new Date();
  document.getElementById('clock').textContent =
    d.getHours().toString().padStart(2,'0') + ':' +
    d.getMinutes().toString().padStart(2,'0');
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   BRUTZEIT
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function isBrutzeit() {
  var d = new Date(), m = d.getMonth()+1, day = d.getDate();
  return (m>=3 && m<=6) || (m===7 && day<=15);
}
function initBrutzeit() {
  var active = isBrutzeit();
  if (active) {
    document.getElementById('brutPill').style.display = 'block';
    document.getElementById('brutMapBanner').style.display = 'flex';
  }
  var months = [
    {n:'Jan',icon:'ðŸ§Š',type:'off'},{n:'Feb',icon:'ðŸŒ±',type:'off'},
    {n:'MÃ¤r',icon:'ðŸ¦†',type:'hot'},{n:'Apr',icon:'ðŸ£',type:'hot'},
    {n:'Mai',icon:'ðŸ‡',type:'hot'},{n:'Jun',icon:'ðŸ¦…',type:'hot'},
    {n:'Jul',icon:'ðŸŒ¿',type:'warm'},{n:'Aug',icon:'ðŸ’§',type:'warm'},
    {n:'Sep',icon:'ðŸ‚',type:'good'},{n:'Okt',icon:'ðŸŒ°',type:'good'},
    {n:'Nov',icon:'â„ï¸',type:'off'},{n:'Dez',icon:'â˜ƒï¸',type:'off'}
  ];
  var colors = {hot:'#fee2e2',warm:'#fef9c3',good:'#dcfce7',off:'#f8fafc'};
  var textC  = {hot:'#991b1b',warm:'#713f12',good:'#166534',off:'#64748b'};
  var calEl = document.getElementById('calGrid');
  months.forEach(function(m) {
    calEl.innerHTML += '<div style="background:'+colors[m.type]+';border-radius:7px;padding:5px 2px;text-align:center"><span style="font-size:8px;font-weight:700;color:'+textC[m.type]+';display:block">'+m.n+'</span><span style="font-size:11px;display:block">'+m.icon+'</span></div>';
  });
  var brutEl = document.getElementById('brutMonths');
  months.forEach(function(m) {
    var on = m.type==='hot'||m.type==='warm';
    brutEl.innerHTML += '<span class="bm '+(on?'active':'inactive')+'">'+m.n+(on?' âš ï¸':'')+'</span>';
  });
  var brutActive = document.getElementById('brutActive');
  if (brutActive) brutActive.style.display = active ? 'inline-block' : 'none';
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   SCREENS & TABS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function switchScreen(name) {
  document.querySelectorAll('.screen').forEach(function(s){s.classList.remove('active');});
  document.querySelectorAll('.nb').forEach(function(b){b.classList.remove('active');});
  var s = document.getElementById('s-'+name);
  var n = document.getElementById('nav-'+name);
  if (s) s.classList.add('active');
  if (n) n.classList.add('active');
  document.getElementById('mapPopup').classList.remove('open');
}
function switchCommTab(tab) {
  ['feed','chat','events'].forEach(function(t) {
    document.getElementById('ct-'+t).classList.toggle('active', t===tab);
    var body = document.getElementById('ct-'+t+'-body');
    if (body) body.style.display = t===tab ? 'block' : 'none';
  });
  document.getElementById('chatWindow').style.display = 'none';
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   MAP FILTER
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function toggleF(key, bc, tc, el) {
  var on = !el.classList.contains('on');
  el.classList.toggle('on', on);
  el.style.borderColor = on ? bc : 'transparent';
  el.style.color = on ? tc : 'rgba(255,255,255,.35)';
  showToast((on?'âœ… ':'ðŸš« ')+el.textContent.trim()+' '+(on?'eingeblendet':'ausgeblendet'),'#0a1628');
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   MAP POPUP
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function openMapPopup(name, sub, tag, color, bg, icon, reportLabel) {
  document.getElementById('ppAvatar').textContent = icon;
  document.getElementById('ppAvatar').style.background = bg;
  document.getElementById('ppName').textContent = name;
  document.getElementById('ppSub').textContent = sub;
  var tags = document.getElementById('ppTags');
  tags.innerHTML = '';
  tag.split('|').forEach(function(t) {
    var sp = document.createElement('span');
    sp.style.cssText='padding:3px 9px;border-radius:20px;font-size:10px;font-weight:700;background:'+bg+';color:'+color;
    sp.textContent = t.trim();
    tags.appendChild(sp);
  });
  var btn = document.getElementById('ppBtn');
  if (reportLabel) {
    btn.style.display='block'; btn.style.background=color; btn.textContent=reportLabel;
  } else { btn.style.display='none'; }
  document.getElementById('mapPopup').classList.add('open');
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   STATUS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function setMyStatus(key) {
  currentStatus = key;
  Object.keys(STATUS).forEach(function(k) {
    var s = STATUS[k], on = k===key;
    ['sb-'+k, 'sb-'+k+'2'].forEach(function(id) {
      var btn = document.getElementById(id);
      if (!btn) return;
      btn.style.borderColor = on ? s.color : 'transparent';
      btn.style.background  = on ? s.bg    : '#f7f9fc';
      btn.querySelector('.sl').style.color = on ? s.color : '#999';
    });
  });
  var s = STATUS[key];
  var badge = document.getElementById('profStatusBadge');
  badge.style.background = s.bg;
  badge.children[0].textContent = s.emoji;
  badge.children[1].style.color = s.color;
  badge.children[1].textContent = s.label;
  document.getElementById('headerBadge').textContent = s.emoji+' 5 Hunde';
  showToast('Status: '+s.emoji+' '+s.label, s.color);
  // Persist status to DB
  if (currentUser && currentUser.id) {
    DB.updateUser(currentUser.id, { status: key }).catch(function(){});
  }
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   FEED â€” Posts aus DB laden
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
async function loadPostsFromDB() {
  try {
    var posts = await DB.getPosts();
    var area = document.getElementById('newPostsArea');
    area.innerHTML = '';
    posts.forEach(function(p) {
      var card = buildPostCard(p);
      area.appendChild(card);
    });
  } catch(e) {
    console.warn('Posts laden fehlgeschlagen:', e);
  }
}

function buildPostCard(p) {
  var ago = timeAgo(p.created_date);
  var card = document.createElement('div');
  card.className = 'post-card slide-up';
  card.dataset.postId = p.id;
  var likeCount = p.likes || 0;
  card.innerHTML =
    '<div class="post-hdr">'+
      '<div class="post-av" style="background:'+(p.badge_bg||'#dcfce7')+'">'+(p.autor_avatar||'ðŸ•')+'</div>'+
      '<div><div class="post-name">'+escHtml(p.autor_name)+'</div><div class="post-when">'+ago+' Â· '+(p.standort||'Bremen')+'</div></div>'+
      (p.badge_text ? '<div class="post-badge" style="background:'+(p.badge_bg||'#dcfce7')+';color:'+(p.badge_color||'#166534')+'">'+escHtml(p.badge_text)+'</div>' : '')+
    '</div>'+
    '<div class="post-body">'+escHtml(p.text)+'</div>'+
    '<div class="post-acts">'+
      '<button class="pact" data-pid="'+p.id+'" data-likes="'+likeCount+'" onclick="likePostDB(this)">â¤ï¸ <span>'+likeCount+'</span></button>'+
      '<button class="pact">ðŸ’¬ '+(p.kommentare||0)+'</button>'+
      '<button class="pact" onclick="showToast(\'Link kopiert! ðŸ”—\',\'#22c55e\')">ðŸ”— Teilen</button>'+
    '</div>';
  return card;
}

function timeAgo(dateStr) {
  if (!dateStr) return 'Gerade eben';
  var diff = Math.floor((Date.now() - new Date(dateStr)) / 1000);
  if (diff < 60) return 'Gerade eben';
  if (diff < 3600) return 'Vor ' + Math.floor(diff/60) + ' Min';
  if (diff < 86400) return 'Vor ' + Math.floor(diff/3600) + ' Std';
  return 'Vor ' + Math.floor(diff/86400) + ' Tagen';
}

async function likePostDB(btn) {
  var pid = btn.dataset.pid;
  var count = parseInt(btn.dataset.likes) || 0;
  btn.classList.toggle('liked');
  var newCount = btn.classList.contains('liked') ? count+1 : count-1;
  btn.querySelector('span').textContent = newCount;
  btn.dataset.likes = newCount;
  try { await DB.likePost(pid, count); } catch(e) {}
}

function toggleLike(btnId, countId, el) {
  el.classList.toggle('liked');
  var cnt = document.getElementById(countId);
  cnt.textContent = parseInt(cnt.textContent) + (el.classList.contains('liked') ? 1 : -1);
}

async function postToFeed() {
  var txt = document.getElementById('newPostText').value.trim();
  if (!txt) { showToast('Bitte erst etwas schreiben ðŸ“','#64748b'); return; }
  var btn = document.querySelector('.np-btns .np-btn:last-child');
  btn.textContent = 'â€¦'; btn.disabled = true;
  try {
    var s = STATUS[currentStatus];
    var p = await DB.createPost({
      text: txt,
      autor: currentUser,
      standort: 'Bremen',
      typ: 'normal',
      badgeText: s.emoji + ' ' + s.label,
      badgeBg: s.bg,
      badgeColor: s.color
    });
    var area = document.getElementById('newPostsArea');
    var card = buildPostCard(p);
    area.prepend(card);
    document.getElementById('newPostText').value='';
    showToast('âœ… Post verÃ¶ffentlicht!','#22c55e');
  } catch(e) {
    showToast('âš ï¸ Fehler: '+e.message,'#ef4444');
  } finally {
    btn.textContent='Posten â†’'; btn.disabled=false;
  }
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   MELDUNGEN aus DB laden & anzeigen
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
async function loadMeldungenFromDB() {
  try {
    var meldungen = await DB.getMeldungen();
    var area = document.getElementById('newPostsArea');
    // Zeige Meldungen die noch offen/bestÃ¤tigt sind als Karten im Feed
    var offene = meldungen.filter(function(m){ return m.status !== 'erledigt'; });
    offene.forEach(function(m) {
      var card = buildMeldungCard(m);
      area.appendChild(card);
    });
  } catch(e) {
    console.warn('Meldungen laden fehlgeschlagen:', e);
  }
}

function buildMeldungCard(m) {
  var ago = timeAgo(m.created_date);
  var card = document.createElement('div');
  card.className = 'post-card';
  card.dataset.meldungId = m.id;
  var statusLabel = m.status === 'bestaetigt' ? 'âœ… BestÃ¤tigt' : 'ðŸ”´ Offen';
  var statusColor = m.status === 'bestaetigt' ? '#22c55e' : '#ef4444';
  card.style.borderLeft = '3px solid '+(m.farbe||'#64748b');
  card.innerHTML =
    '<div class="post-hdr">'+
      '<div class="post-av" style="background:#fff7ed;font-size:18px">'+(m.icon||'ðŸ“')+'</div>'+
      '<div><div class="post-name">âš ï¸ Meldung Â· '+(m.melder_name||'Anonym')+'</div><div class="post-when">'+ago+' Â· '+escHtml(m.standort)+'</div></div>'+
      '<div class="post-badge" style="background:#fff7ed;color:'+(m.farbe||'#64748b')+'">'+escHtml(m.typ_label||m.type)+'</div>'+
    '</div>'+
    '<div class="post-body"><b>'+escHtml(m.titel)+'</b>'+
      (m.beschreibung ? '<br>'+escHtml(m.beschreibung) : '')+
      '<br><span style="color:'+statusColor+';font-size:10px;font-weight:700">'+statusLabel+' Â· '+m.bestaetigt_von+' BestÃ¤tigungen</span>'+
    '</div>'+
    '<div class="post-acts">'+
      '<button class="pact" onclick="bestaetigenDB(\''+m.id+'\','+m.bestaetigt_von+')">ðŸ‘ BestÃ¤tigen</button>'+
      '<button class="pact" onclick="erledigDB(\''+m.id+'\',this)">âœ… Erledigt</button>'+
    '</div>';
  return card;
}

async function bestaetigenDB(id, count) {
  try {
    await DB.bestaetigenMeldung(id, count);
    showToast('âœ… BestÃ¤tigt! Danke.','#22c55e');
    // Update card
    var card = document.querySelector('[data-meldung-id="'+id+'"]');
    if (card) {
      var span = card.querySelector('span[style*="color"]');
      if (span) span.textContent = 'âœ… BestÃ¤tigt Â· '+(count+1)+' BestÃ¤tigungen';
    }
  } catch(e) { showToast('âš ï¸ Fehler','#ef4444'); }
}

async function erledigDB(id, btn) {
  try {
    await DB.erledigMeldung(id);
    showToast('âœ… Als erledigt markiert','#64748b');
    var card = document.querySelector('[data-meldung-id="'+id+'"]');
    if (card) { card.style.opacity='0.4'; card.style.pointerEvents='none'; }
  } catch(e) { showToast('âš ï¸ Fehler','#ef4444'); }
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   SUBMIT REPORT â€” speichert in DB
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
async function submitReport(typeLabel, location, icon, color, bg) {
  var now = new Date();
  var time = now.getHours().toString().padStart(2,'0')+':'+now.getMinutes().toString().padStart(2,'0');

  // Typ-Mapping
  var typeMap = {
    'ðŸ—‘ï¸':'muell_voll','ðŸ§»':'beutel_leer','ðŸ’§':'getraenke_leer',
    'ðŸ©¹':'sonstiges','â˜ ï¸':'giftkoeder','ðŸ”':'hund_verloren','âš¡':'angriff'
  };
  var type = typeMap[icon] || 'sonstiges';

  showToast('ðŸ“¡ Wird gemeldetâ€¦', '#d4a843');

  try {
    var meldung = await DB.createMeldung({
      type,
      titel: typeLabel,
      standort: location,
      beschreibung: 'Gemeldet um '+time+' Uhr',
      icon, farbe: color,
      melder: currentUser
    });

    // Direkt im Feed anzeigen
    var area = document.getElementById('newPostsArea');
    var card = buildMeldungCard(meldung);
    area.prepend(card);
    showToast('âœ… Gemeldet! Sichtbar im Community-Feed.', color||'#22c55e');
    switchScreen('community'); switchCommTab('feed');
  } catch(e) {
    showToast('âš ï¸ '+e.message,'#ef4444');
  }
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   CHAT
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
var demoReplies=['ðŸ˜Š Super!','ðŸ¾ Mucki sagt Hallo!','Bis gleich!','ðŸ‘ Klar doch!','Danke fÃ¼r die Info!','Sehen wir uns am Werdersee? ðŸŒ¿','Lola freut sich! ðŸ©'];
function openChat(name, av, bg, online) {
  document.getElementById('ct-chat-body').style.display='none';
  var cw = document.getElementById('chatWindow');
  cw.style.display='flex';
  document.getElementById('cwName').textContent=name;
  var avEl = document.getElementById('cwAv');
  avEl.textContent=av; avEl.style.background=bg;
  document.getElementById('cwOnline').style.background=online?'#22c55e':'#94a3b8';
  document.getElementById('chatMsgs').innerHTML=
    '<div class="msg them"><div class="msg-bubble">Hey! SchÃ¶n dich hier zu sehen ðŸ¾</div><div class="msg-time">12:30</div></div>'+
    '<div class="msg me"><div class="msg-bubble">Hallo! Mucki und ich sind unterwegs ðŸ˜Š</div><div class="msg-time">12:31</div></div>'+
    '<div class="msg them"><div class="msg-bubble">Super! Treffen wir uns?</div><div class="msg-time">12:33</div></div>';
}
function closeChat() {
  document.getElementById('chatWindow').style.display='none';
  document.getElementById('ct-chat-body').style.display='block';
}
function sendMsg() {
  var inp=document.getElementById('chatInp');
  var txt=inp.value.trim();
  if (!txt) return;
  var msgs=document.getElementById('chatMsgs');
  var d=new Date();
  var t=d.getHours().toString().padStart(2,'0')+':'+d.getMinutes().toString().padStart(2,'0');
  msgs.innerHTML+='<div class="msg me slide-up"><div class="msg-bubble">'+escHtml(txt)+'</div><div class="msg-time">'+t+'</div></div>';
  inp.value=''; msgs.scrollTop=99999;
  setTimeout(function(){
    msgs.innerHTML+='<div class="msg them slide-up"><div class="msg-bubble">'+demoReplies[Math.floor(Math.random()*demoReplies.length)]+'</div><div class="msg-time">'+t+'</div></div>';
    msgs.scrollTop=99999;
  }, 800+Math.random()*600);
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   GHOST & VISIBILITY
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function toggleGhost() {
  ghostMode=!ghostMode;
  var btn=document.getElementById('ghostBtn');
  var pill=document.getElementById('ghostPill');
  var badge=document.getElementById('ghostBadge');
  if (ghostMode) {
    btn.className='ghost-btn ghost-on'; pill.className='gpill gpill-on'; pill.textContent='AN';
    badge.style.display='flex';
    document.getElementById('profSub').textContent='Labrador Mix Â· 3 Jahre Â· ðŸ‘» Unsichtbar';
    showToast('ðŸ‘» Ghost-Modus AN â€” Du bist unsichtbar!','#6366f1');
  } else {
    btn.className='ghost-btn ghost-off'; pill.className='gpill gpill-off'; pill.textContent='AUS';
    badge.style.display='none';
    document.getElementById('profSub').textContent='Labrador Mix Â· 3 Jahre Â· Sichtbar fÃ¼r alle';
    showToast('Ghost-Modus AUS â€” Du bist wieder sichtbar','#22c55e');
  }
  if (currentUser && currentUser.id) {
    DB.updateUser(currentUser.id, { ghost_mode: ghostMode }).catch(function(){});
  }
}
function setVis(key,bg,color,label) {
  document.querySelectorAll('.vc').forEach(function(c){c.classList.remove('sel');c.style.background='#f8fafc';});
  var card=document.getElementById('vis-'+key);
  if(card){card.classList.add('sel');card.style.background=bg;}
  document.getElementById('profSub').textContent='Labrador Mix Â· 3 Jahre Â· Sichtbar: '+label;
  showToast('Sichtbarkeit: '+label, color);
  if (currentUser && currentUser.id) {
    DB.updateUser(currentUser.id, { visibility: key }).catch(function(){});
  }
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   NOTFALL
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function checkAlarm() {
  var n=document.getElementById('emrgName').value.trim();
  var p=document.getElementById('emrgPhone').value.trim();
  document.getElementById('alarmBtn').disabled=!(n&&p);
}
function sendAlarm() {
  showToast('ðŸš¨ ALARM GESENDET! Alle im 2km Umkreis benachrichtigt!','#ef4444');
  var btn=document.getElementById('alarmBtn');
  btn.textContent='âœ… Alarm gesendet â€” Hilfe ist unterwegs!';
  btn.disabled=true; btn.style.background='#22c55e';
  // Als Meldung speichern
  var name=document.getElementById('emrgName').value.trim();
  DB.createMeldung({type:'sonstiges',titel:'ðŸš¨ NOTFALL-ALARM von '+name,
    standort:'Aktueller Standort',icon:'ðŸš¨',farbe:'#ef4444',melder:currentUser}).catch(function(){});
  setTimeout(function(){
    btn.textContent='ðŸš¨ ALARM JETZT SENDEN';
    btn.disabled=false; btn.style.background='';
    document.getElementById('emrgName').value='';
    document.getElementById('emrgPhone').value='';
  },5000);
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   FEEDBACK
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function rateStar(n) {
  document.querySelectorAll('#stars span').forEach(function(s,i){s.textContent=i<n?'â­':'â˜†';});
  document.getElementById('mailLink').href='mailto:info@dog-radar.de?subject=Dog-Radar%20Feedback%20('+n+'%20Sterne)';
}
function sendFeedback() {
  var txt=document.getElementById('feedbackText').value;
  var base=document.getElementById('mailLink').href.split('&body=')[0];
  document.getElementById('mailLink').href=base+'&body='+encodeURIComponent(txt);
  setTimeout(function(){
    document.getElementById('feedbackModal').classList.remove('open');
    showToast('âœ… Danke fÃ¼r dein Feedback! ðŸ¾','#22c55e');
  },300);
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   AUTH â€” echte DB-Anbindung
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function buildAvatarGrid() {
  var grid=document.getElementById('avGrid');
  if (!grid) return;
  AVATARS.forEach(function(em){
    var cell=document.createElement('div');
    cell.className='avpicker-cell'+(em===selectedAv?' sel':'');
    cell.textContent=em;
    cell.onclick=function(){
      document.querySelectorAll('.avpicker-cell').forEach(function(c){c.classList.remove('sel');});
      cell.classList.add('sel'); selectedAv=em;
      document.getElementById('selectedAvatar').textContent=em;
    };
    grid.appendChild(cell);
  });
}
function openAvatarPicker(){ document.getElementById('avatarPicker').style.display='flex'; }
function closeAvatarPicker(){ document.getElementById('avatarPicker').style.display='none'; }
function switchAuthTab(tab){
  ['login','register'].forEach(function(t){
    document.getElementById('atab-'+t).classList.toggle('active',t===tab);
    document.getElementById('apanel-'+t).classList.toggle('active',t===tab);
  });
}

async function doLogin(){
  var email=document.getElementById('loginEmail').value.trim();
  var pw=document.getElementById('loginPw').value;
  if(!email||!pw){showToast('âš ï¸ Bitte E-Mail und Passwort eingeben.','#ef4444');return;}
  setAuthLoading(true);
  try {
    var user = await DB.loginUser({email, password:pw});
    finishLoginUI(user, false);
  } catch(e) {
    showToast('âš ï¸ '+e.message,'#ef4444');
  } finally { setAuthLoading(false); }
}

async function doRegister(){
  var name=document.getElementById('regName').value.trim();
  var dog=document.getElementById('regDog').value.trim();
  var email=document.getElementById('regEmail').value.trim();
  var pw=document.getElementById('regPw').value;
  if(!name||!dog){showToast('âš ï¸ Bitte deinen Namen und den Hundenamen eingeben.','#ef4444');return;}
  if(!email||!email.includes('@')){showToast('âš ï¸ Bitte eine gÃ¼ltige E-Mail-Adresse eingeben.','#ef4444');return;}
  if(pw.length<8){showToast('âš ï¸ Passwort muss mindestens 8 Zeichen haben.','#ef4444');return;}
  setAuthLoading(true);
  try {
    var user = await DB.registerUser({email, password:pw, dogName:dog, avatar:selectedAv});
    finishLoginUI(user, true);
  } catch(e) {
    showToast('âš ï¸ '+e.message,'#ef4444');
  } finally { setAuthLoading(false); }
}

function showGoogleLogin(){
  document.getElementById('googlePopup').classList.add('open');
  setTimeout(function(){document.getElementById('googleEmail').focus();},100);
}
function closeGooglePopup(){ document.getElementById('googlePopup').classList.remove('open'); }
async function doGoogleLogin(){
  var email=document.getElementById('googleEmail').value.trim();
  var name=document.getElementById('googleName').value.trim();
  var dog=document.getElementById('googleDog').value.trim();
  if(!email||!email.includes('@')){showToast('âš ï¸ Bitte eine gÃ¼ltige E-Mail eingeben.','#ef4444');return;}
  if(!name){showToast('âš ï¸ Bitte deinen Namen eingeben.','#ef4444');return;}
  if(!dog){showToast('âš ï¸ Bitte den Hunde-Namen eingeben.','#ef4444');return;}
  closeGooglePopup();
  setAuthLoading(true);
  try {
    // Versuche Login, falls nicht vorhanden â†’ Register
    var user;
    try { user = await DB.loginUser({email, password: email}); }
    catch { user = await DB.registerUser({email, password:email, dogName:dog, avatar:'ðŸ•'}); }
    finishLoginUI(user, true);
  } catch(e) {
    showToast('âš ï¸ '+e.message,'#ef4444');
  } finally { setAuthLoading(false); }
}
function doGuestLogin(){
  // Gast-Modus: kein DB-Eintrag, nur lokale Session
  var guest = {id:null, email:'gast@dog-radar.de', dog_name:'Mucki', avatar:'ðŸ•', full_name:'Mucki', status:'friendly'};
  DB.saveSession(guest);
  currentUser = guest;
  finishLoginUI(guest, false);
  showToast('ðŸ‘¤ Gast-Modus: Daten werden nicht gespeichert.','#64748b');
}

function setAuthLoading(on) {
  document.querySelectorAll('.auth-btn').forEach(function(b){
    b.disabled=on; b.textContent=on?'â³ Bitte wartenâ€¦':b.dataset.orig||b.textContent;
  });
}

function finishLoginUI(user, isNew) {
  currentUser = user;
  var dogName = user.dog_name || user.full_name || 'Mucki';
  var avatar  = user.avatar || 'ðŸ•';
  var email   = user.email || '';
  /* Update profil */
  var pavEl=document.getElementById('profAv');
  if (pavEl) { var ghostBadgeEl=document.getElementById('ghostBadge'); pavEl.innerHTML=avatar; if(ghostBadgeEl) pavEl.appendChild(ghostBadgeEl); }
  var nameEl=document.getElementById('profDogName'); if(nameEl) nameEl.textContent=dogName;
  var emailEl=document.getElementById('profilEmail'); if(emailEl) emailEl.textContent=email;
  var npAv=document.getElementById('npAv'); if(npAv) npAv.textContent=avatar;
  /* Animate overlay out */
  var overlay=document.getElementById('authOverlay');
  overlay.style.transition='opacity .35s ease,transform .35s ease';
  overlay.style.opacity='0'; overlay.style.transform='translateY(-16px)';
  setTimeout(function(){
    overlay.style.display='none';
    if (isNew) showToast('ðŸŽ‰ Willkommen, '+dogName+'! Konto erstellt.','#22c55e');
    else showToast('ðŸ‘‹ Willkommen zurÃ¼ck, '+dogName+'!','#d4a843');
  },350);
}

function doLogout(){
  DB.clearSession();
  currentUser=null;
  var overlay=document.getElementById('authOverlay');
  overlay.style.display='flex'; overlay.style.opacity='0'; overlay.style.transform='translateY(-16px)';
  overlay.style.transition='opacity .3s ease,transform .3s ease';
  setTimeout(function(){
    overlay.style.opacity='1'; overlay.style.transform='translateY(0)';
    document.getElementById('loginEmail').value='';
    document.getElementById('loginPw').value='';
    switchAuthTab('login');
  },30);
  showToast('Erfolgreich abgemeldet ðŸ‘‹','#64748b');
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   TOAST
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function showToast(msg,color){
  var t=document.getElementById('toast');
  t.textContent=msg; t.style.background=color||'#22c55e';
  t.classList.remove('show'); void t.offsetWidth; t.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer=setTimeout(function(){t.classList.remove('show');},3200);
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   UTILS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
function escHtml(str) {
  return String(str||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   GOOGLE MAPS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
var gMap=null, myMarker=null;
var INFRA=[
  {lat:53.0850,lng:8.8020,icon:'ðŸ—‘ï¸',titel:'MÃ¼lleimer',adresse:'Werderseeweg / Ecke Parkstr.'},
  {lat:53.0835,lng:8.8045,icon:'ðŸ§»',titel:'Kotbeutelspender',adresse:'Parkstr. 12'},
  {lat:53.0820,lng:8.7995,icon:'ðŸ’§',titel:'HundetrÃ¤nke',adresse:'Werderseeweg 5'},
  {lat:53.0870,lng:8.8010,icon:'ðŸ—‘ï¸',titel:'MÃ¼lleimer',adresse:'BÃ¼rgerpark Eingang Nord'},
  {lat:53.0860,lng:8.8055,icon:'ðŸ§»',titel:'Kotbeutelspender',adresse:'BÃ¼rgerpark Mitte'}
];
var HUNDE=[
  {lat:53.0843,lng:8.8028,name:'Bella',rasse:'Golden Retriever',status:'ðŸŸ¢'},
  {lat:53.0828,lng:8.8012,name:'Rocky',rasse:'Labrador',status:'ðŸŸ¡'},
  {lat:53.0855,lng:8.8040,name:'Luna',rasse:'Husky',status:'ðŸŸ¢'}
];

function initGoogleMap(){
  gMap=new google.maps.Map(document.getElementById('gmap'),{
    center:{lat:53.0843,lng:8.8025}, zoom:15,
    disableDefaultUI:true, zoomControl:true,
    styles:[
      {elementType:'geometry',stylers:[{color:'#0d1f3c'}]},
      {elementType:'labels.text.fill',stylers:[{color:'#8ec3b9'}]},
      {elementType:'labels.text.stroke',stylers:[{color:'#1a3646'}]},
      {featureType:'water',elementType:'geometry',stylers:[{color:'#0a1628'}]},
      {featureType:'road',elementType:'geometry',stylers:[{color:'#1a3a5c'}]},
      {featureType:'road',elementType:'labels.text.fill',stylers:[{color:'#9ca5b3'}]},
      {featureType:'poi.park',elementType:'geometry',stylers:[{color:'#1a3d2b'}]},
      {featureType:'poi.park',elementType:'labels.text.fill',stylers:[{color:'#3C7680'}]}
    ]
  });
  INFRA.forEach(function(p){
    var m=new google.maps.Marker({
      position:{lat:p.lat,lng:p.lng}, map:gMap, title:p.titel,
      label:{text:p.icon,fontSize:'18px'},
      icon:{path:google.maps.SymbolPath.CIRCLE,scale:16,fillColor:'#1e3a5f',fillOpacity:.9,strokeColor:'#d4a843',strokeWeight:1.5}
    });
    m.addListener('click',function(){openMapPopupGmap(p);});
  });
  HUNDE.forEach(function(p){
    var m=new google.maps.Marker({
      position:{lat:p.lat,lng:p.lng}, map:gMap, title:p.name,
      label:{text:'ðŸ•',fontSize:'18px'},
      icon:{path:google.maps.SymbolPath.CIRCLE,scale:16,fillColor:'#14532d',fillOpacity:.9,strokeColor:'#4ade80',strokeWeight:1.5}
    });
    m.addListener('click',function(){
      showToast('ðŸ• '+p.name+' Â· '+p.rasse+' '+p.status,'#22c55e');
    });
  });
  if(navigator.geolocation){
    navigator.geolocation.watchPosition(function(pos){
      var position={lat:pos.coords.latitude,lng:pos.coords.longitude};
      if(!myMarker){
        myMarker=new google.maps.Marker({
          position:position, map:gMap, title:'Du bist hier',
          label:{text:'ðŸ“',fontSize:'18px'},
          icon:{path:google.maps.SymbolPath.CIRCLE,scale:14,fillColor:'#3b82f6',fillOpacity:1,strokeColor:'#ffffff',strokeWeight:3}
        });
      } else { myMarker.setPosition(position); }
      gMap.setCenter(position);
    },function(){});
  }
  document.getElementById('gmapLoad').style.display='none';
}

function openMapPopupGmap(p){
  var bg='#f5f5f4', color='#78716c';
  if(p.icon==='ðŸ—‘ï¸'){bg='#f5f5f4';color='#78716c';}
  else if(p.icon==='ðŸ§»'){bg='#fff7ed';color='#f97316';}
  else if(p.icon==='ðŸ’§'){bg='#e0f2fe';color='#0ea5e9';}
  document.getElementById('ppAvatar').textContent=p.icon;
  document.getElementById('ppAvatar').style.background=bg;
  document.getElementById('ppName').textContent=p.titel;
  document.getElementById('ppSub').textContent=p.adresse;
  document.getElementById('ppTags').innerHTML=
    '<span style="padding:3px 9px;border-radius:20px;font-size:10px;font-weight:700;background:'+bg+';color:'+color+'">Infra-Punkt</span>';
  var btn=document.getElementById('ppBtn');
  btn.style.display='block'; btn.style.background=color;
  if(p.icon==='ðŸ—‘ï¸') btn.textContent='ðŸ—‘ï¸ Als voll melden';
  else if(p.icon==='ðŸ§»') btn.textContent='ðŸ§» Als leer melden';
  else if(p.icon==='ðŸ’§') btn.textContent='ðŸ’§ Als defekt melden';
  btn.onclick=function(){
    submitReport(btn.textContent.slice(3)+' â€” '+p.titel, p.adresse, p.icon, color, bg);
    document.getElementById('mapPopup').classList.remove('open');
  };
  document.getElementById('mapPopup').classList.add('open');
}
</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDvA7196QZhYxGtWaNxdjJyJwOsEYv-iv0&callback=initGoogleMap"></script>
</body>
</html>
