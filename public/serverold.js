const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const server = http.createServer((req, res) => {
    const { method, url } = req;

    if (method === 'GET') {
        if (url === '/') {
            res.setHeader('Content-Type', 'text/html');
            const filePath = path.join(__dirname, 'public', 'index.html');
            fs.createReadStream(filePath).pipe(res);
        } else if (url === '/audit_sections') {
            res.setHeader('Content-Type', 'text/html');
            const filePath = path.join(__dirname, 'public', 'audit_sections.html');
            fs.createReadStream(filePath).pipe(res);
        } else if (url.startsWith('/run_audit')) {
            const section = new URL(url, 'http://localhost').searchParams.get('section');

            const sectionScriptMap = {
                '1': 'section1_script.sh', // Replace with the actual file name for section 1
                '2': 'section2_script.sh', // Replace with the actual file name for section 2
                '3': 'section3_script.sh',
		'4': '4.sh',
		'5': 'audit1.sh',
		'6': 'main.sh',// Replace with the actual file name for section 3
                // Add mappings for other sections
            };

            const scriptFileName = sectionScriptMap[section];

            if (!scriptFileName) {
                console.error(`Script file not found for section ${section}`);
                return;
            }

            const scriptPath = path.join(__dirname, scriptFileName);

            exec(`${scriptPath}`, (error, stdout, stderr) => {
                if (error) {
                    console.error(`Error executing script: ${error}`);
                    return;
                }

                console.log(stdout);

                res.writeHead(302, { 'Location': '/show_details' });
                res.end();
            });
        } else if (url === '/show_details') {
            res.setHeader('Content-Type', 'text/html');
            const filePath = path.join(__dirname, 'public', 'details.html');
            fs.createReadStream(filePath).pipe(res);
        } else {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.end('Not Found');
        }
    }
});

const port = 3000;
server.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

