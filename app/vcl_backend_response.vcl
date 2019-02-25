# vcl_backend_response

if (bereq.retries > 2) {
        set beresp.http.X-ADI-RETRY = bereq.retries;
}

if (bereq.http.host ~ "minutes" || bereq.url ~ "preview") {
        set beresp.ttl = 0s;
} elsif (bereq.url ~ "/$" || bereq.url ~ "/index\.html$" || bereq.url ~ "river" || bereq.url ~ "\.xml$" || bereq.http.host ~ "fetch") {
        set beresp.ttl = 1m;
} elsif (bereq.url ~ "/\d\d\d\d/\d\d/.*\.html$" || bereq.url ~ "\.(css|js)$") {
        set beresp.ttl = 0s;
} elsif (bereq.url ~ "(expo|gallery)" || bereq.http.host ~ "^expo") {
        set beresp.ttl = 3m;
} elsif (bereq.url ~ "\.(jpg|JPG|png|PNG|gif|GIF)$" || bereq.url ~ "^/(static|menumanager|design)/") {
        set beresp.ttl = 40m;
} else {
        set beresp.ttl = 5m;
}

set bereq.http.User-Agent = "Mozilla/5.0";
unset bereq.http.Cookie;

if (bereq.url ~ "right_rail.html" && beresp.status != 200) {
	if (bereq.http.X-ADI-SHORT == "mardi") {
		set bereq.url = "/right_rail.html";
	} else {
		set bereq.url = "/news/right_rail.html";
	}
	return(retry);
}

if ((beresp.status == 403 || beresp.status == 404) && bereq.url !~ "(^/404/|gallery/|mmslideshow/|cgi-bin/)") {

        if (bereq.url ~ "\.html" && bereq.url !~ "^/services/oembed") {

                if (bereq.url ~ "_impact_" && bereq.url !~ "^/impact/") {
                        set bereq.url = regsub(bereq.url, "^/(.*)_impact_", "/impact/");
                        return(retry);

                #} elsif (bereq.http.host ~ "(gulflive|silive|lehighvalleylive|pennlive)" && bereq.url !~ "_impact_" && bereq.url ~ "^/(.*)/(\d\d\d\d)/(\d\d)/(.*).html") {
                #        set bereq.url = regsub(bereq.url, "^/(.*)/(\d\d\d\d)/(\d\d)/(.*)\.html", "/" + bereq.http.X-ADI-SHORT + "_impact_\1/\2/\3/\4.html");
                #        include "app/includes/alias-backend.vcl";
                #        return(retry);

                } elsif (bereq.url !~ "^/impact/") {
                        set bereq.url = regsub(bereq.url, "^/", "/impact/");
                        return(retry);

                #} elsif (bereq.url ~ "^/impact/" && bereq.retries > 0) {
                #        set bereq.url = regsub(bereq.url, "^/impact/", "/");
                #        return(retry);

                } elsif (bereq.http.X-ADI-ESI-LEVEL) {
                        set beresp.http.X-ADI-ContentMissing = 1;
                } elsif (bereq.url !~ "^/(static|articles)/" && bereq.http.host !~ "^(videos|feeds|media)") {
                        set bereq.url = "/404/index.html";
                        return(retry);
                } else {
                        set beresp.status = 404;
                        return(deliver);
                }

        } elsif (bereq.url ~ "\.xml$") {

                if (bereq.retries == 0 && bereq.url !~ "^/impact/") {
                        set bereq.url = regsub(bereq.url, "^/", "/impact/");
                        return(retry);
                } elsif (bereq.retries == 1) {
                        set bereq.url = regsub(bereq.url, "^/impact/(.*)/", "/\1_impact/");
                        return(retry);
                } elsif (bereq.retries == 2) {
                        set bereq.url = regsub(bereq.url, "^/(.*)_impact/", "/\1/");
                        include "app/includes/alias-feeds.vcl";
                        return(retry);
                } else {
                        set beresp.status = 404;
                        return(deliver);
                }

        } else {

                if (bereq.http.X-ADI-ESI-LEVEL) {
                        set beresp.http.X-ADI-ContentMissing = 1;
                } elsif (bereq.url !~ "^/(static|articles)/" && bereq.http.host !~ "^(videos|feeds|media)" && bereq.url !~ "\.(png|PNG|jpg|JPG)$") {
                        set bereq.url = "/404/index.html";
                        return(retry);
                } else {
                        set beresp.status = 404;
                        return(deliver);
                }

        }

}

# set ESI processing to default unless query string noesi=True is passed
if (bereq.http.X-ADI-NOESI) {
	set beresp.do_esi = false;
} else {
	set beresp.do_esi = true;
}

if (bereq.url ~ "^/404/index.html") {
	set beresp.status = 404;
	return(deliver);
}

if (beresp.status == 200 || beresp.status == 304) {
        if (bereq.http.host ~ "minutes" || bereq.url ~ "preview") {
                set beresp.http.Cache-Control = "max-age=0";
        } elsif (bereq.url ~ "/$" || bereq.url ~ "/index\.html$" || bereq.url ~ "river" || bereq.url ~ "\.xml$" || bereq.http.host ~ "fetch") {
                set beresp.http.Last-Modified = beresp.http.date;
                set beresp.http.Cache-Control = "max-age=60";
        } elsif (bereq.url ~ "/\d\d\d\d/\d\d/.*\.html$" || bereq.url ~ "\.(css|js)$") {
                set beresp.http.Cache-Control = "no-cache, no-store, must-revalidate";
                set beresp.http.Pragma = "no-cache";
                set beresp.http.Expires = 0;
                set beresp.http.Surrogate-Control = "max-age=31536000, stale-while-revalidate=31536000, stale-if-error=31536000";
        } elsif (bereq.url ~ "(expo|gallery)" || bereq.http.host ~ "^expo") {
                set beresp.http.Cache-Control = "max-age=180";
        } elsif (bereq.url ~ "\.(jpg|JPG|png|PNG|gif|GIF)$" || bereq.url ~ "^/(static|menumanager|design)/") {
                set beresp.http.Cache-Control = "max-age=2400";
        } else {
                set beresp.http.Cache-Control = "max-age=300";
        }       
}

if (bereq.url ~ "^/cgi-bin/mte/") {
        set beresp.http.X-Robots-Tag = "noindex, nofollow";
}

