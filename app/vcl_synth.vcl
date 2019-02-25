# vcl_synth

if (resp.status == 301) {
	set resp.status = 301;
	set resp.http.location = req.http.location;
        # MINUTES REDIRECT TO HTTPS
        if (req.url ~ "^/[0-9a-f]{4}00-.*\.html" || req.url ~ "^/[^/]+/[0-9a-f]{4}00-.*\.html") {
                set resp.http.Cache-Control = "no-store, private";
        }
	return(deliver);

} elsif (resp.status == 200) {
	set resp.status = 200;
	return(deliver);

} elsif (resp.status == 205) {
        synthetic("PURGED");
        set resp.status = 205;
        return (deliver);

} elsif (resp.status == 405) {
        synthetic(resp.reason);
        set resp.status = 405;
        return (deliver);

} elsif (resp.status == 410) {
        synthetic(resp.reason);
        set resp.status = 410;
        return (deliver);

} else {
	synthetic("<!--  BACKEND ERROR: response status != 200,304, or 301  -- or varnish-health-response-->");
	set resp.status = 404;
	return (deliver);
}

