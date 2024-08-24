from http.server import BaseHTTPRequestHandler, HTTPServer
import pendulum
import os


class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()

        _env = '\n'.join([f'{k}={v}' for k, v in os.environ.items() if k.startswith('DEMO_PORTAL_')])

        self.wfile.write(f'Hello world!\n'
                         f'Today is {pendulum.now(tz='UTC').format('YYYY-MM-DD HH:mm:ss z')}.\n\n'
                         f'{_env}'.encode()
                         )


def run(server_class=HTTPServer, handler_class=RequestHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting http server on port {port}...')
    httpd.serve_forever()


if __name__ == '__main__':
    run()
