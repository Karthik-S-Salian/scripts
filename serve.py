import http.server
import socketserver
import os
import socket
import sys

port = 8000

class CustomRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        try:
            if self.path == "/custom_endpoint":
                self.send_response(200)
                self.send_header("Content-type", "text/html")
                self.end_headers()
                self.wfile.write(b"<html><body><h1>Custom Endpoint</h1></body></html>")
            else:
                # Serve files from the current directory
                super().do_GET()
        except ConnectionAbortedError:
            print(f"Connection aborted by client {self.path}")


if __name__=="__main__":

    path = sys.argv[1]
    os.chdir(path)

    with socketserver.TCPServer(("", port), CustomRequestHandler) as httpd:

        # get ipv4 address
        hostname = socket.getfqdn()
        ip = socket.gethostbyname_ex(hostname)[2][0]
        
        print(f"Serving on  http://{ip}:{port} from {path}")

        # Start serving
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("shutting down server")

