from tornado.web import Application, RequestHandler
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop

class HelloHandler(RequestHandler):
  def get(self):
    self.write(
        {'message': 'hello world'}
    )

def make_app():
    urls = [
        ("/api/", HelloHandler)
    ]
    return Application(urls, debug=True)

if __name__ == '__main__':
    app = make_app()
    server = HTTPServer(app)
    server.bind(9899)
    server.start(1)
    IOLoop.current().start()
