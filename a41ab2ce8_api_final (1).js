/**
 * P.G. Dog-Radar — Base44 API Client
 * Echte Datenbank für User, Meldungen und Posts
 */

const API_BASE = 'https://base44.app/api/apps/69b33f5b68f33085d59e7f78/entities';
const SERVICE_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2Zjg2YTU2ZC0zMGE1LTRmYjItOTdmZS1hZDA0ODgzYjQ0MjIiLCJjbGllbnRfaWQiOiI2Zjg2YTU2ZC0zMGE1LTRmYjItOTdmZS1hZDA0ODgzYjQ0MjIiLCJhcHBfaWQiOiI2OWIzM2Y1YjY4ZjMzMDg1ZDU5ZTdmNzgiLCJhdWQiOiJiYXNlNDRfYXBpIiwic2NvcGUiOiJhcHAuYWNjZXNzIiwiZXhwIjoxNzczMzU5OTk5LCJpYXQiOjE3NzMzNTYzOTl9.7yy2x1rlIa6RJwK_N1i_ZwvsTInFuBdqbPKJL4qo_l0';

// ─── LocalStorage Key ─────────────────────────────────────────────────────────
const LS_KEY = 'dogradar_session';

// ─── HTTP helper ─────────────────────────────────────────────────────────────
async function apiCall(method, path, body) { path = path.replace(//$/, ''); // remove trailing slash
  const opts = {
    method,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SERVICE_TOKEN}`
    }
  };
  if (body) opts.body = JSON.stringify(body);
  const res = await fetch(`${API_BASE}${path}`, opts);
  if (!res.ok) throw new Error(`API ${method} ${path}: ${res.status}`);
  const text = await res.text();
  return text ? JSON.parse(text) : null;
}

// ─── USER ─────────────────────────────────────────────────────────────────────

/** Registrierung: schreibt neuen User in DB, speichert Session lokal */
async function registerUser({ email, password, dogName, avatar }) {
  // Check ob E-Mail schon existiert
  const existing = await apiCall('GET', `/User?email=${encodeURIComponent(email)}`);
  if (existing && existing.length > 0) {
    throw new Error('E-Mail bereits registriert.');
  }
  // Passwort hashen (einfacher Base64-Hash für Demo — in Produktion: bcrypt serverseitig)
  const pwHash = btoa(email + ':' + password);
  const user = await apiCall('POST', '/User', {
    role: 'user',
    email,
    full_name: dogName,
    dog_name: dogName,
    avatar: avatar || '🐕',
    status: 'friendly',
    ghost_mode: false,
    visibility: 'all',
    push_enabled: true,
    _pw: pwHash   // gespeicherter Hash (für Demo)
  });
  saveSession(user);
  return user;
}

/** Login: sucht User per E-Mail, prüft Passwort */
async function loginUser({ email, password }) {
  const users = await apiCall('GET', `/User?email=${encodeURIComponent(email)}`);
  if (!users || users.length === 0) throw new Error('E-Mail nicht gefunden.');
  const user = users[0];
  const pwHash = btoa(email + ':' + password);
  if (user._pw && user._pw !== pwHash) throw new Error('Falsches Passwort.');
  saveSession(user);
  return user;
}

/** Aktualisiert User-Felder in DB */
async function updateUser(userId, data) {
  const updated = await apiCall('PUT', `/User/${userId}`, data);
  // Sync session
  const session = loadSession();
  if (session && session.id === userId) saveSession({ ...session, ...data });
  return updated;
}

/** Session in LocalStorage speichern */
function saveSession(user) {
  localStorage.setItem(LS_KEY, JSON.stringify(user));
}

/** Session aus LocalStorage laden */
function loadSession() {
  try { return JSON.parse(localStorage.getItem(LS_KEY)); } catch { return null; }
}

/** Session löschen */
function clearSession() {
  localStorage.removeItem(LS_KEY);
}

// ─── MELDUNGEN ────────────────────────────────────────────────────────────────

/** Neue Meldung in DB speichern */
async function createMeldung({ type, titel, standort, beschreibung, icon, farbe, melder }) {
  return apiCall('POST', '/Meldung', {
    type,
    titel,
    standort,
    beschreibung: beschreibung || '',
    icon: icon || '📍',
    farbe: farbe || '#64748b',
    melder_name: melder?.dogName || 'Anonym',
    melder_avatar: melder?.avatar || '🐕',
    status: 'offen',
    bestaetigt_von: 0
  });
}

/** Alle offenen Meldungen laden (neueste zuerst) */
async function getMeldungen() {
  return apiCall('GET', '/Meldung?_sort=-created_date&_limit=50');
}

/** Meldung als bestätigt markieren */
async function bestaetigenMeldung(id, aktuelleAnzahl) {
  return apiCall('PUT', `/Meldung/${id}`, {
    bestaetigt_von: aktuelleAnzahl + 1
  });
}

/** Meldung als erledigt markieren */
async function erledigMeldung(id) {
  return apiCall('PUT', `/Meldung/${id}`, { status: 'erledigt' });
}

// ─── POSTS ────────────────────────────────────────────────────────────────────

/** Neuen Post in DB speichern */
async function createPost({ text, autor, standort, typ, badgeText, badgeBg, badgeColor }) {
  return apiCall('POST', '/Post', {
    text,
    autor_name: autor?.dogName || 'Anonym',
    autor_avatar: autor?.avatar || '🐕',
    standort: standort || 'Bremen',
    typ: typ || 'normal',
    badge_text: badgeText || '',
    badge_bg: badgeBg || '#dcfce7',
    badge_color: badgeColor || '#166534',
    likes: 0,
    kommentare: 0
  });
}

/** Posts laden (neueste zuerst) */
async function getPosts() {
  return apiCall('GET', '/Post?_sort=-created_date&_limit=30');
}

/** Like-Zahl erhöhen */
async function likePost(id, aktuelleAnzahl) {
  return apiCall('PUT', `/Post/${id}`, { likes: aktuelleAnzahl + 1 });
}

// ─── Export (als globales Objekt für Plain-HTML) ──────────────────────────────
window.DB = {
  registerUser, loginUser, updateUser,
  saveSession, loadSession, clearSession,
  createMeldung, getMeldungen, bestaetigenMeldung, erledigMeldung,
  createPost, getPosts, likePost
};
