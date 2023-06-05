using HTTP

HTTP.serve("127.0.0.1", 8081) do request::HTTP.Request
    return HTTP.Response("Hello, World!")
end
