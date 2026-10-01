# My timeline — setup guide

A personal task app with a Gantt chart. It works on phone, tablet and laptop, works offline, and syncs your tasks between devices.

Time needed: about 1 hour, once. Cost: free.

What is in this folder:

| File | What it does |
|---|---|
| `index.html` | The app |
| `config.js` | Your Supabase keys go here (step A5) |
| `setup.sql` | Creates the tasks table in Supabase (step A3) |
| `sw.js` | Makes the app work offline |
| `manifest.webmanifest`, `icons/` | App name and icon for installing |

---

## A. Supabase — the database for sync (about 20 min)

1. Go to **supabase.com**, sign up, and click **New project**. Choose a name (for example `my-timeline`), make a strong database password, and choose the region **Central EU (Frankfurt)**. Wait 1–2 minutes.
2. Open **SQL Editor** → **New query**.
3. Open `setup.sql` from this folder, copy everything, paste it, and click **Run**. You should see "Success".
4. Create your account for the app: **Authentication → Users → Add user → Create new user**. Enter your email and a password. Tick **Auto Confirm User**. Remember this email and password — you will sign in with them.
5. Close sign-ups so nobody else can create an account: in **Authentication**, find the sign-up setting (**Allow new users to sign up**) and turn it **off**.
6. Get your keys: click **Connect** at the top of the project, or open **Project Settings → API Keys**. Copy:
   - the **Project URL** (looks like `https://abcd1234.supabase.co`)
   - the **publishable key** (starts with `sb_publishable_`) or the **anon key**
7. Open `config.js` in any text editor and paste the two values instead of `PASTE_...`. Save.

⚠️ Never put the **secret** / **service_role** key in `config.js`. The publishable key is safe to share, because the database only lets you see your own tasks.

---

## B. GitHub Pages — free hosting (about 15 min)

1. Go to **github.com** and create an account.
2. Click **+ → New repository**. Name: `my-timeline`. Choose **Public**. Click **Create repository**.
3. Click **uploading an existing file**. Drag in **all files and the `icons` folder** from this folder. Click **Commit changes**.
4. Open **Settings → Pages**. Under **Source**, choose **Deploy from a branch**, branch **main**, folder **/ (root)**. Click **Save**.
5. Wait 1–2 minutes. Your app address is:
   `https://YOUR-GITHUB-NAME.github.io/my-timeline/`

Note: on the free plan the code is public. Your tasks are not — they are in Supabase and need your password.

---

## C. Install on each device (2 min per device)

Open your app address, then:

- **iPhone / iPad:** in Safari → Share → **Add to Home Screen**.
- **Android:** in Chrome → menu (⋮) → **Install app** (or **Add to home screen**).
- **Laptop:** in Chrome or Edge → the install icon in the address bar, or menu → **Install My timeline**.

Then open the app, tap the **Sign in** button at the top, and sign in with the email and password from step A4. You only do this once per device.

---

## How it works

- Every task is saved on the device first. So the app works without internet.
- When there is internet, the app syncs by itself: on start, after each change, and every minute.
- The button at the top shows the state: **Synced**, **Syncing…**, **Offline**, **Sign in**, or **Sync problem**. Tap it for details and **Sync now**.
- If you change the same task on two devices while offline, the latest change wins.

---

## When you change the app later

1. Upload the new files to GitHub (the same way as step B3).
2. In `sw.js`, change `mt-v1` to `mt-v2` (then `mt-v3`, and so on). Without this, devices may keep the old version.
3. Close and open the app twice. The new version loads.

---

## Good to know

- **Supabase pauses free projects** if the database gets too little activity for 7 days. You get a warning email first. If it happens, open the Supabase dashboard and click **Resume project** — your data stays.
- Tasks are also saved on each device, so a pause does not delete anything. Sync starts again after you resume.
- If you forget your password: Supabase → **Authentication → Users** → your user → set a new password.
