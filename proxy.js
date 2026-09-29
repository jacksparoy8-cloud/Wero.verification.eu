const http = require('http');
const https = require('https');
const url = require('url');
const querystring = require('querystring');

const BOT_TOKEN = process.env.BOT_TOKEN || '';
const CHAT_ID = process.env.CHAT_ID || '6078788670';
const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
    // CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    res.setHeader('Content-Type', 'application/json');

    // Preflight
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }

    if (req.method === 'POST' && req.url === '/send') {
        let body = '';
        req.on('data', chunk => body += chunk);
        req.on('end', () => {
            try {
                const data = JSON.parse(body);
                const text = data.text || '';
                const chatId = data.chat_id || CHAT_ID;

                // Envoyer vers Telegram
                const telegramUrl = `https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`;
                const postData = JSON.stringify({
                    chat_id: chatId,
                    text: text
                });

                const options = {
                    hostname: 'api.telegram.org',
                    path: `/bot${BOT_TOKEN}/sendMessage`,
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Content-Length': Buffer.byteLength(postData)
                    }
                };

                const telegramReq = https.request(options, (telegramRes) => {
                    let telegramBody = '';
                    telegramRes.on('data', chunk => telegramBody += chunk);
                    telegramRes.on('end', () => {
                        res.writeHead(telegramRes.statusCode);
                        res.end(telegramBody);
                    });
                });

                telegramReq.on('error', (e) => {
                    console.error('Telegram error:', e);
                    res.writeHead(500);
                    res.end(JSON.stringify({ ok: false, error: e.message }));
                });

                telegramReq.write(postData);
                telegramReq.end();
            } catch (e) {
                console.error('Parse error:', e);
                res.writeHead(400);
                res.end(JSON.stringify({ ok: false, error: e.message }));
            }
        });
        return;
    }

    // Health check
    if (req.url === '/' || req.url === '/health') {
        res.writeHead(200);
        res.end(JSON.stringify({ ok: true, message: 'Telegram proxy running' }));
        return;
    }

    res.writeHead(404);
    res.end(JSON.stringify({ ok: false, error: 'Not found' }));
});

server.listen(PORT, () => {
    console.log(`Telegram proxy running on port ${PORT}`);
    console.log(`BOT_TOKEN: ${BOT_TOKEN ? 'SET' : 'EMPTY'}`);
});
