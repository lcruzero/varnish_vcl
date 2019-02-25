if (req.http.host ~ "mardigras.com$") {

if (req.url ~ "^/nola_mardigras_home/") { set req.url = regsub(req.url, "^/nola_mardigras_home/", "/mardigras_impact/"); }
elsif (req.url ~ "^/nola_mardigras_about/") { set req.url = regsub(req.url, "^/nola_mardigras_about/", "/about_new_orleans_mardi_gras/"); }
elsif (req.url ~ "^/nola_mardigras_parades/") { set req.url = regsub(req.url, "^/nola_mardigras_parades/", "/mardigras_parades/"); }
elsif (req.url ~ "^/nola_mardigras_photos_videos/") { set req.url = regsub(req.url, "^/nola_mardigras_photos_videos/", "/mardi_gras_photos_and_videos/"); }
elsif (req.url ~ "^/nola_mardigras_events/") { set req.url = regsub(req.url, "^/nola_mardigras_events/", "/new_orleans_mardi_gras_events/"); }

}
