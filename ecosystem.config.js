const fs = require('fs');
const path = require('path');

const APP_NAME = process.env.APP_NAME || 'demo-app';
const PORT = process.env.PORT || '3000';

function subdirs() {
  return fs.readdirSync(__dirname, { withFileTypes: true })
    .filter((d) => d.isDirectory() && !d.name.startsWith('.') && d.name !== 'node_modules' && d.name !== 'screenshots' && d.name !== 'issues')
    .map((d) => d.name);
}

function findApp() {
  if (fs.existsSync(path.join(__dirname, 'package.json'))) {
    return { name: APP_NAME, script: 'npm', args: 'start', cwd: __dirname, env: { PORT } };
  }
  for (const sub of subdirs()) {
    if (fs.existsSync(path.join(__dirname, sub, 'package.json'))) {
      return { name: APP_NAME, script: 'npm', args: 'start', cwd: path.join(__dirname, sub), env: { PORT } };
    }
    if (fs.existsSync(path.join(__dirname, sub, 'app.py'))) {
      return { name: APP_NAME, script: path.join(sub, 'app.py'), interpreter: 'python3', cwd: __dirname, env: { PORT } };
    }
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
