const http = require('http');
const url = require('url');

const hostname = '127.0.0.1';
const port = 8080;

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end(`Hello ${url.parse(req.url).pathname.split('/')[1]}`);
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});