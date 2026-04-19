const fs = require('fs');
const path = require('path');

const indexPath = path.join(__dirname, '../dist/index.html');

if (fs.existsSync(indexPath)) {
  let content = fs.readFileSync(indexPath, 'utf8');
  
  const faviconLinks = `
  <link rel="icon" href="/webapp/favicon.ico" type="image/x-icon" />
  <link rel="shortcut icon" href="/webapp/favicon.ico" type="image/x-icon" />
  <link rel="apple-touch-icon" href="/webapp/logo.svg" />`;
  
  if (!content.includes('shortcut icon')) {
    content = content.replace(
      '<title>Supersonic</title>',
      '<title>Supersonic</title>' + faviconLinks
    );
    fs.writeFileSync(indexPath, content);
    console.log('✅ Successfully added favicon links to index.html');
  } else {
    console.log('ℹ️  Favicon links already exist in index.html');
  }
} else {
  console.error('❌ index.html not found at:', indexPath);
  process.exit(1);
}
