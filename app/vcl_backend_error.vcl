# vcl_backend_error

if (beresp.status == 503) {
        synthetic("<!-- Error 503 Service Unavailable Guru Meditation -->");
        return (deliver);
}

