// Import the http module
const http = require('http');

// Define the server
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});

// Define the port
const port = 3000;

// Start the server
server.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
