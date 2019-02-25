# vcl_deliver

unset resp.http.Age;
unset resp.http.Server;

if (resp.http.X-ADI-ContentMissing) {
	return(synth(404, "ADI Content Missing"));
}

if (obj.hits > 0) {
	set resp.http.X-ADI-VCache = "HIT";
} else {
	set resp.http.X-ADI-VCache = "MISS";
}

if (!req.http.X-ADI-NOESI) {
	unset resp.http.ETag;
}

if (req.url ~ "river\d\.html$" || req.url ~ "river_noads\d\.html$" || req.url ~ "\.json$") {
	set resp.http.Access-Control-Allow-Origin = "*";
	set resp.http.Access-Control-Allow-Methods = "GET, OPTIONS";
	set resp.http.Access-Control-Allow-Headers = "Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token";
	set resp.http.Access-Control-Allow-Credentials = "true";
}

