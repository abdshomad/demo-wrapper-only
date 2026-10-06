const fs = require('fs');
const os = require('os');
const path = require('path');

const APP_NAME = process.env.APP_NAME || 'demo-app';
const PORT = process.env.PORT || '3000';

function subdirs() {
  return fs.readdirSync(__dirname, { withFileTypes: true })
    .filter((d) => d.isDirectory() && !d.name.startsWith('.') && d.name !== 'node_modules' && d.name !== 'screenshots' && d.name !== 'issues')
    .map((d) => d.name);
}

// Resolve to an absolute path so the pm2 daemon finds the binary
// regardless of the environment it was first spawned with.
function resolveBin(name) {
  const dirs = (process.env.PATH || '').split(path.delimiter);
  dirs.push(path.join(os.homedir(), '.local', 'bin'));
  for (const dir of dirs) {
    if (!dir) continue;
    const candidate = path.join(dir, name);
    if (fs.existsSync(candidate)) return candidate;
  }
  return name;
}

function findApp() {
  if (fs.existsSync(path.join(__dirname, 'package.json'))) {
    return { name: APP_NAME, script: 'npm', args: 'start', cwd: __dirname, env: { PORT } };
  }
  const subs = subdirs();
  for (const sub of subs) {
    if (fs.existsSync(path.join(__dirname, sub, 'package.json'))) {
      return { name: APP_NAME, script: 'npm', args: 'start', cwd: path.join(__dirname, sub), env: { PORT } };
    }
  }
  // Python apps always run via uv (project .venv, never system python).
  for (const sub of subs) {
    const dir = path.join(__dirname, sub);
    if (!fs.existsSync(path.join(dir, 'app.py'))) continue;
    const args = ['run'];
    if (!fs.existsSync(path.join(dir, 'pyproject.toml')) && fs.existsSync(path.join(dir, 'requirements.txt'))) {
      args.push('--with-requirements', 'requirements.txt');
    }
    args.push('app.py');
    return { name: APP_NAME, script: resolveBin('uv'), args: args.join(' '), cwd: dir, env: { PORT } };
  }
  return null;
}

const app = findApp();
if (!app) {
  throw new Error('No app found: add root package.json or a subfolder with package.json/app.py');
}

module.exports = {
  apps: [
    {
      ...app,
      instances: 1,
      exec_mode: 'fork',
      autorestart: true,
      watch: false,
      max_memory_restart: '500M',
    },
  ],
};
