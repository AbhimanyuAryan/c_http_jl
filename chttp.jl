# First, define the path to the shared library
const httplib = "./libf.so"

struct http_settings_s
    on_request::Ptr{Cvoid}
    log::Cint
    # Add other fields as needed
end

function on_request(request::Ptr{Cvoid})
    ccall((:http_send_body, httplib), Cvoid, (Ptr{Cvoid}, Cstring, Csize_t), request, "Hello World!\r\n", 14)
end

# Convert the Julia function to a C function pointer
const on_request_c = @cfunction(on_request, Cvoid, (Ptr{Cvoid},))

# Define the C struct
const settings = http_settings_s(on_request_c, 1)

println("before listen")

# Start listening on the specified port
@async ccall((:http_listen, httplib), Cintmax_t, (Cstring, Cstring, Ref{http_settings_s}), "3000", C_NULL, settings)

println("after listen")

# Start the server
ccall((:fio_start, httplib), Cvoid, (Cint,), 1)

println("after start")