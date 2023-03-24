#include "crow.h"

int main() {
  crow::SimpleApp app;

  // GET request
  CROW_ROUTE(app, "/")
  ([]() {
    return "Hello, world!";
  });

  // POST request
  CROW_ROUTE(app, "/data")
  .methods("POST"_method)
  ([](const crow::request& req) {
    auto json_data = crow::json::load(req.body);
    if (!json_data) {
      return crow::response(400);
    }

    std::string message = json_data["message"].s();
    return crow::response("Received message: " + message);
  });

  app.port(8080).multithreaded().run();
}