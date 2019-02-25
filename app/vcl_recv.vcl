# vcl_recv

call exploit_workaround_4_1;

# MINUTES REDIRECT TO HTTPS
if ((req.http.X-Forwarded-Proto != "https") && (req.url ~ "^/[0-9a-f]{4}00-.*\.html" || req.url ~ "^/[^/]+/[0-9a-f]{4}00-.*\.html")) {
        set req.http.Location = "https://" + req.http.host + req.url;
        return (synth(301, ""));
}

if (req.url ~ " ") {
        set req.url = regsuball(req.url, " ", "%20");
}

if (req.http.host !~ "^media") {
	unset req.http.If-Modified-Since;
}

if (req.method != "GET" && req.method != "HEAD" && req.method != "POST" && req.method != "PURGE") {
	return (synth(405));
	return(hash);
}

if (req.http.user-agent ~ "Go-http-client") {
        return (synth(403, ""));
}

if (req.http.host ~ "(dev|uat|stage)" && req.url ~ "/robots.txt") {
        set req.http.host = "xxxxxxxxxxx.com.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = static_buckets.backend("xxxxxxxxxxx.com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.url ~ "^/(news/|sports/|entertainment/|business/|opinion/|weather/|politics/)?(index.html)?$" && req.http.host ~ "^(blog|impact|media)") {
	set req.http.host = regsub(req.http.host, "^(blog|impact|media)", "www");
	set req.http.Location = "http://" + req.http.host + req.url;
	return (synth(301, ""));
}

if (req.esi_level > 0) {
	set req.http.X-ADI-ESI-LEVEL = req.esi_level;
	#unset req.http.cookie;
} else {
	unset req.http.X-ADI-ESI-LEVEL;
}

set req.url = regsub(req.url, "([a-z]{1})//", "\1/");

# Set X-ADI-SHORT and X-ADI-DOMAIN values
# Used for referencing s3 bucket names and directory names
#
if (req.http.host ~ "advance.net$") {
        set req.http.X-ADI-SHORT = "adv";
        set req.http.X-ADI-LONG = "advance";
} elsif (req.http.host ~ "al.com$") {
	set req.http.X-ADI-SHORT = "bama";
	set req.http.X-ADI-LONG = "al";
} elsif (req.http.host ~ "cleveland.com$") {
	set req.http.X-ADI-SHORT = "cleve";
	set req.http.X-ADI-LONG = "cleveland";
} elsif (req.http.host ~ "gulflive.com$") {
	set req.http.X-ADI-SHORT = "gulflive";
	set req.http.X-ADI-LONG = "gulflive";
} elsif (req.http.host ~ "lehighvalleylive.com$") {
	set req.http.X-ADI-SHORT = "lvlive";
	set req.http.X-ADI-LONG = "lehighvalleylive";
} elsif (req.http.host ~ "mardigras.com$") {
	set req.http.X-ADI-SHORT = "mardi";
	set req.http.X-ADI-LONG = "mardigras";
} elsif (req.http.host ~ "masslive.com$") {
	set req.http.X-ADI-SHORT = "mass";
	set req.http.X-ADI-LONG = "masslive";
} elsif (req.http.host ~ "mlive.com$") {
	set req.http.X-ADI-SHORT = "mlive";
	set req.http.X-ADI-LONG = "mlive";
} elsif (req.http.host ~ "newyorkupstate.com$") {
	set req.http.X-ADI-SHORT = "nyup";
	set req.http.X-ADI-LONG = "newyorkupstate";
} elsif (req.http.host ~ "nj.com$") {
	set req.http.X-ADI-SHORT = "njo";
	set req.http.X-ADI-LONG = "nj";
} elsif (req.http.host ~ "nola.com$") {
	set req.http.X-ADI-SHORT = "nola";
	set req.http.X-ADI-LONG = "nola";
} elsif (req.http.host ~ "oregonlive.com$") {
	set req.http.X-ADI-SHORT = "olive";
	set req.http.X-ADI-LONG = "oregonlive";
} elsif (req.http.host ~ "pennlive.com$") {
	set req.http.X-ADI-SHORT = "penn";
	set req.http.X-ADI-LONG = "pennlive";
} elsif (req.http.host ~ "silive.com$") {
	set req.http.X-ADI-SHORT = "silive";
	set req.http.X-ADI-LONG = "silive";
} elsif (req.http.host ~ "syracuse.com$") {
	set req.http.X-ADI-SHORT = "syr";
	set req.http.X-ADI-LONG = "syracuse";
}

if (req.method == "PURGE") {
        if (!client.ip ~ purgers) {
                return (synth(405, "Purging not allowed for " + client.ip));
        }

        if (req.url ~ "^/(static|menumanager)/") {
                set req.http.host = "static-uat.advance.net";
        } elsif (req.url ~ "^/cgi-bin/mte/") {
                set req.http.host = "blog-stage." + req.http.X-ADI-LONG + ".com";
        } else {
                set req.http.host = "static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
        }
        return (purge);

}

# Force a cache missed on X-ADI-MISS
#
if (req.http.X-ADI-MISS) {
	set req.hash_always_miss = true;
}

# Option to show unparsed ESI grid
#
if (req.http.X-ADI-NOESI) {
	set req.http.X-ADI-NOESI = true;
}
if (req.url ~ "noesi=true") {
	set req.http.X-ADI-NOESI = true;
}

# Health checks
#
if (req.url == "/varnish-health/" || req.url ~ "^/stack-check" || req.url == "/server-status/") {
	return (synth(200, "Varnish is responding"));
	set req.http.Connection = "close";
}

# Instead, for now, we'll just remove that from path
#
if (req.url ~ "/index.ssf/" && req.url !~ "services/oembed") {
	set req.url = regsub(req.url, "index\.ssf/", "");
}

# Allow js and css to rev
if (req.url ~ "^/static/" && req.url ~ "\.[0-9]{1,9}\.(js|css)$") {
	set req.url = regsub(req.url, "\.[0-9]{1,9}\.(js|css)$", ".\1");
}

if (req.url ~ "^/zzz-articles/") {
	set req.http.host = "amp.advance.net";
	set req.backend_hint = global_amp_uat;
	return(hash);
}

if (req.url ~ "^/articles/(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)/(.*)\.amp$") {
	set req.url = regsub(req.url, "^/articles/(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)/(.*)\.amp$", "/\8\7\6\5\4\3\2\1-\9");
	set req.http.host = "xxxxxxxxxxx.s3-website-us-east-1.amazonaws.com";
	set req.backend_hint = static_buckets.backend("stage.amp-articles.s3-website-us-east-1.amazonaws.com");
	return(hash);
}

if (req.url ~ "^/articles/(\d)(\d)(\d)(\d)(\d)(\d)(\d)/(.*)\.amp$") {
        set req.url = regsub(req.url, "^/articles/(\d)(\d)(\d)(\d)(\d)(\d)(\d)/(.*)\.amp$", "/\7\6\5\4\3\2\1-\8");
        set req.http.host = "xxxxxxxxxxx.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = static_buckets.backend("dev.amp-articles.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

# Any request with no subdomain gets redirected to www (carried over from 275 prod modrewrite)
#
if (req.http.host == "^(al|cleveland|gulflive|lehighvalleylive|mardigras|masslive|mlive|nj|nola|newyorkupstate|oregonlive|pennlive|silive|syracuse).com$") {
	set req.http.Location = "http://www." + req.http.host;
}

# Events

if (req.url ~ "^/events/(event/|venue/|artist/|city/|category/|\?)") {
	set req.url = "/events/index.html";
	set req.http.host = "static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
	set req.backend_hint = static_buckets.backend("static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com");
	return(hash);
}

if (req.url ~ "^/events/.*_escaped_fragment_") {
	if (req.url ~ "^/events/(event|venue|artist)/") {
		set req.url = regsub(req.url, "^/events/(event|venue|artist)/.+?/(.+?)/", "/web/gateway.php?site=default&tpl=v3_\1_detail&hidemap=1&snapshot=1&\1id=\2");
	} else {
		set req.url = "/web/gateway.php?site=default&hidemap=1&snapshot=1&tpl=v3_regular_event_grid";
	}
	return (synth(301, ""));
}

if (req.url ~ "^/web/gateway.php") {
	if (req.http.host ~ "al.com$" || req.http.host ~ "xxxxxxxxxxx.com$") {
		set req.http.host = "birmingham-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("xxxxxxxxxxx.com");
	} elsif (req.http.host ~ "cleveland.com$") {
		set req.http.host = "xxxxxxxxxxx.com";
		set req.backend_hint = newsengin.backend(".com");
	} elsif (req.http.host ~ "lehighvalleylive.com$") {
		set req.http.host = "lv-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend(".com");
	} elsif (req.http.host ~ "masslive.com$") {
		set req.http.host = "springfield-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("xxxxxxxxxxx.com");
	} elsif (req.http.host ~ "mlive.com$") {
		set req.http.host = "michigan-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("michigan-etweb.newsengin.com");
	} elsif (req.http.host ~ "nj.com$") {
		set req.http.host = "newark-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("newark-etweb.newsengin.com");
	} elsif (req.http.host ~ "nola.com$") {
		set req.http.host = "neworleans-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("neworleans-etweb.newsengin.com");
	} elsif (req.http.host ~ "oregonlive.com$") {
		set req.http.host = "portland-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("portland-etweb.newsengin.com");
	} elsif (req.http.host ~ "pennlive.com$") {
		set req.http.host = "harrisburg-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("harrisburg-etweb.newsengin.com");
	} elsif (req.http.host ~ "silive.com$") {
		set req.http.host = "si-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("si-etweb.newsengin.com");
	} elsif (req.http.host ~ "syracuse.com$") {
		set req.http.host = "syracuse-etweb.newsengin.com";
		set req.backend_hint = newsengin.backend("syracuse-etweb.newsengin.com");
	}
	return(hash);
}

#
# GROUP 1: STATIC: (static.advance.net)
#

if (req.url ~ "^/static/" && req.http.host !~ "^expo") {
	if (req.url ~ "/aff/") {
		set req.url = regsub(req.url, "/aff/", "/" + req.http.X-ADI-SHORT + "/");
	} elsif (req.url ~ "^/static/common/js/jquery") {
		set req.url = regsub(req.url, "/jquery/", "/libs/");
	}
	set req.http.host = "static-uat.advance.net";
	set req.backend_hint = static_dot.backend("xxxxxxxxxxx.net");
	return(hash);
}

if (req.url ~ "^/menumanager/") {
	set req.http.host = "static-uat.advance.net";
	set req.backend_hint = static_dot.backend("xxxxxxxxxxx.net");
	return(hash);
}

if (req.url ~ "^/favicon.ico$") {
	set req.url = "/favicon/" + req.http.X-ADI-LONG + ".com/favicon.ico";
	set req.http.host = "static-uat.advance.net";
	set req.backend_hint = static_dot.backend("xxxxxxxxxxx.net");
	return(hash);
}

# BANDAID Make old toprail calls route to new toprail
if (req.url ~ "^/(toprail|footer)-(.*).html") {
	set req.url = regsub(req.url, "^/(toprail|footer)-(.*)\.html", "/menumanager/\1-\2.html");
	set req.http.host = "static-uat.advance.net";
	set req.backend_hint = static_dot.backend("xxxxxxxxxxx.net");
	return(hash);
}

# BANDAID Make old forums and weblog calls return nothing
if (req.url ~ "^/forums/" || req.url ~ "^/weblog/" || req.url ~ "/index\.ssf\?/base/.*/\d*\.xml" || req.url ~ "/\d\d\d\d/\d\d(/\d\d-week)?/index_?\d?\d?\.html$" || req.url ~ "\.html&title=") {
	return (synth(410, "Gone permanently"));
}

#
# GROUP 2: DYNAMIC:
#

# Special request: Fetch purposefully gets all tiers, unlike other backends
# Fetch start
if (req.http.host ~ "^fetch-dev") {
        set req.http.host = "fetch-dev.advance.net";
        set req.backend_hint = fetch.backend("xxxxxxxxxxx.net");
        return(hash);
} elsif (req.http.host ~ "^fetch-uat") {
        set req.http.host = "fetch-uat.advance.net";
        set req.backend_hint = fetch.backend("xxxxxxxxxxx.net");
        return(hash);
} elsif (req.http.host ~ "^fetch\.") {
        set req.http.host = "fetch.advance.net";
        set req.backend_hint = fetch.backend("xxxxxxxxxxx.net");
        return(hash);
}
# Fetch end

if (req.http.host ~ "^feedparser") {
	set req.backend_hint = feedparser.backend("xxxxxxxxxxx.net");
	return(hash);
}

if (req.http.host ~ "^classifieds") {
        set req.backend_hint = classifieds.backend("xxxxxxxxxxx.net");
        return(hash);
}

if (req.http.host ~ "^blog" && req.url ~ "^/community/") {
        set req.backend_hint = mt_web.backend("mt-web.nimbus-stage.r53.advance.net");
        return(pass);
}

if (req.http.host ~ "^(www|blog)" && (req.url ~ "\d\d\d\d/\d\d/mt-preview" || req.url ~ "/page/mt-preview")) {

  #temp
  if (req.http.host !~ "stage" && req.http.host !~ "uat" && req.http.host !~ "gulflive" && req.http.host !~ "silive" && req.http.host !~ "lehighvalleylive" && req.http.host !~ "pennlive") {

	if (req.http.host ~ "^(www|impact)") {
		set req.url = regsub(req.url, "^/(.*)/(\d\d\d\d)/(\d\d)/(.*)\.html", "/" + req.http.X-ADI-SHORT + "_impact_\1/\2/\3/\4.html");
	}

        if (req.http.host ~ "^www" && req.url ~ "/page/") {
                set req.url = regsub(req.url, "^/", "/" + req.http.X-ADI-SHORT + "_impact_\1");
        }

	if (req.url ~ "_impact_") {
		include "app/includes/alias.vcl";
	}

  #temp
  }

	set req.http.host = "blog-stage." + req.http.X-ADI-LONG + ".com";
	set req.backend_hint = mt_admin.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);
}

if (req.http.host ~ "^blog" && req.url ~ "^/mt-static/") {
	set req.http.host = "mt-admin-stage.advance.net";
	set req.backend_hint = mt_admin.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);
}

if (req.http.host ~ "^(blog|impact)" && req.url ~ "single_newsletter") {
	set req.http.host = regsub(req.http.host, "impact", "blog");
	set req.backend_hint = mt_web.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);

} elsif (req.url ~ "^/cgi-bin/mte/") {
	set req.http.host = "blog-stage." + req.http.X-ADI-LONG + ".com";
	set req.backend_hint = mt_web.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);

} elsif (req.http.host ~ "^photos" && req.url ~ "^/\d{2,6}/category/") {
	set req.backend_hint = mt_web.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);

} elsif (req.http.host ~ "^connect") {
	set req.backend_hint = mt_web.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);

} elsif (req.url ~ "^/services/oembed") {
	set req.http.host = "feeds-stage.advance.net";
	set req.backend_hint = mt_web.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);

} elsif (req.url ~ "^/mtrest/articles") {
	set req.http.host = "mt-api-stage.advance.net";
	set req.backend_hint = mt_api.backend("xxxxxxxxxxx.nimbus-stage.r53.advance.net");
	return(hash);
}


#
# GROUP 3: STATIC: (valence s3 bucket)
#


if (req.url ~ "^/expo/.+-\d{4}/\d{2}/.+/.*\.html") {
        set req.url = regsub(req.url, "^/expo", "/gallery");
        set req.http.host = "xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = expo.backend("xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.url ~ "^/expo/preview/.+/.*\.html") {
        set req.url = regsub(req.url, "^/expo/preview", "/preview");
        set req.http.host = "xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = expo.backend("xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^expo" && req.url ~ "^/static/.*/embed\.html") {
        set req.http.host = "xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = expo.backend("xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.url ~ "^/[0-9a-f]{4}00-.*\.(html|amp)" || req.url ~ "^/[^/]+/[0-9a-f]{4}00-.*\.(html|amp)" || req.url ~ "^/\.well-known/amphtml/apikey\.pub") {

        if (req.url ~ "^/[^/]+/[0-9a-f]{4}00-.*\.(html|amp)") {
                set req.url = regsub(req.url, "^/[^/]+/([0-9a-f]{4}00-.*\.)(html|amp)", "/\1\2");
        }

        set req.http.host = "xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = minutes.backend("xxxxxxxxxxx.net.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.url ~ "(^/404/|^/sitemap/|/modules/|right_rail).*\.html$") {
	set req.http.host = "static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
	set req.backend_hint = static_buckets.backend("static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com");
	return(hash);
}

if (req.http.host ~ "^impact" && req.url ~ "mt\.js$") {
	set req.url = regsub(req.url, "^/", "/impact/");
        # Do not return() here
}

if (req.url ~ "^/sitemap.*\.xml$") {
        if (req.url ~ "^/sitemap\.xml$") {
                set req.url = "/sitemap-www.xml";
        }
	set req.http.host = "xxxxxxxxxxx." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
	set req.backend_hint = static_buckets.backend("static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^(blog|impact)" && req.url ~ "^/mmslideshow/\d*/\d*\.json") {
        set req.url = regsub(req.url, "^/mmslideshow/(\d*)/(\d*)\.json", "/\1/\2.json");
        set req.http.host = "xxxxxxxxxxx.mmslideshow.com.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = mmslideshow.backend("xxxxxxxxxxx.mmslideshow.com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^(blog|impact)" && req.url ~ "^/photogallery/\d*/\d*\.json") {
        set req.url = regsub(req.url, "^/photogallery/(\d*)/(\d*)\.json", "/\1/\2.json");
        set req.http.host = "xxxxxxxxxxx.photogallery.com.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = gallery.backend("xxxxxxxxxxx.photogallery.com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^(blog|impact)" && req.url ~ "^/\d*/gallery/[^/]+/index\.html") {
        set req.url = regsub(req.url, "^/(\d*)/gallery/([^/]+)/index\.html", "/\1/\2.html");
        set req.http.host = "static-stage.photogallery.com.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = gallery.backend("static-stage.photogallery.com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^(blog|impact)" && req.url ~ "^/\d*/gallery/[^/]+/embed\.html") {
        set req.url = regsub(req.url, "^/(\d*)/gallery/([^/]+)/embed\.html", "/\1/\2-embed.html");
        set req.http.host = "xxxxxxxxxxx.photogallery.com.s3-website-us-east-1.amazonaws.com";
        set req.backend_hint = gallery.backend("xxxxxxxxxxx.photogallery.com.s3-website-us-east-1.amazonaws.com");
        return(hash);
}

if (req.http.host ~ "^(www|blog|impact)") {

  #temp
  if (req.http.host !~ "stage" && req.http.host !~ "uat" && req.http.host !~ "gulflive" && req.http.host !~ "silive" && req.http.host !~ "lehighvalleylive" && req.http.host !~ "pennlive") {

	if (req.http.host ~ "^(www|impact)" && req.url ~ "^/(.*)/(\d\d\d\d)/(\d\d)/(.*).html" && req.url !~ "services/oembed" && req.url !~ "^/comments\.html") {
		set req.url = regsub(req.url, "^/(.*)/(\d\d\d\d)/(\d\d)/(.*)\.html", "/" + req.http.X-ADI-SHORT + "_impact_\1/\2/\3/\4.html");
	}

        if (req.http.host ~ "^www" && req.url ~ "/page/") {
                set req.url = regsub(req.url, "^/", "/" + req.http.X-ADI-SHORT + "_impact_\1");
        }

        if ((req.url ~ "index-more-links-responsive.html$" || req.url ~ "2featured-responsive.html$") && req.url !~ "_impact") {
                set req.url = regsub(req.url, "^/", "/" + req.http.X-ADI-SHORT + "_impact_\1");
        }

	if (req.url ~ "_impact_") {
		include "app/includes/alias.vcl";
	}

  #temp
  }

	if (req.http.host ~ "xxxxxxxxxxx.com") {
		if (req.url ~ "^(/|/|/index\.html)?(\?.*)?$") {
			set req.http.X-ADI-BETA-HP = "/";
		}
	}

	set req.http.host = "static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
	set req.backend_hint = static_buckets.backend("static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com");

        if (req.url ~ "/\d\d\d\d/\d\d/.*\.html$") {
                return(pass);
        } else {
                return(hash);
        }

}

if (req.http.host ~ "^media") {

	if (req.url ~ "^/avatars/") {

                if (req.url ~ "^/avatars/(\d\d)(\d\d?)\.png") {
                        set req.url = regsub(req.url, "^/avatars/(\d\d)(\d\d?)\.png", "/\1/\2.png");
                } elsif (req.url ~ "^/avatars/(\d\d)(\d\d)(\d\d?)\.png") {
                        set req.url = regsub(req.url, "^/avatars/(\d\d)(\d\d)(\d\d?)\.png", "/\1/\2/\3.png");
                } elsif (req.url ~ "^/avatars/(\d\d)(\d\d)(\d\d)(\d\d?)\.png") {
                        set req.url = regsub(req.url, "^/avatars/(\d\d)(\d\d)(\d\d)(\d\d?)\.png", "/\1/\2/\3/\4.png");
                } else {
			set req.url = regsub(req.url, "^/avatars/", "/");
		}

		set req.http.host = "xxxxxxxxxxx.avatars.com.s3-website-us-east-1.amazonaws.com";
		set req.backend_hint = adv_mt_avatars.backend("xxxxxxxxxxx.avatars.com.s3-website-us-east-1.amazonaws.com");
		return(hash);

	} elsif (req.url ~ "^/design/") {

		set req.url = regsub(req.url, "^/design/", "/");
		set req.http.host = "xxxxxxxxxxx.design.com.s3-website-us-east-1.amazonaws.com";
		set req.backend_hint = adv_mt_design.backend("xxxxxxxxxxx.design.com.s3-website-us-east-1.amazonaws.com");
		return(hash);

	} else {

		set req.http.host = "static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com";
		set req.backend_hint = static_buckets.backend("static-stage." + req.http.X-ADI-LONG + ".com.s3-website-us-east-1.amazonaws.com");
		return(hash);

	}

}

if (req.http.host ~ "^videos") {
        include "app/includes/video-redirects.vcl";
}
