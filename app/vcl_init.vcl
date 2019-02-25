# vcl_init

new amp_aws = named.director(
        port = 80,
        probe = www_to_amp_probe,
        ttl = 1m);

new static_dot = named.director(
        port = 80,
        probe = www_to_static_dot_probe,
        ttl = 1m,
	whitelist = ipv4_only);

new mt_web = named.director(
        port = "80",
        probe = www_to_mt_web_probe,
        ttl = 1m);

new mt_api = named.director(
        port = "80",
        probe = www_to_mt_api_probe,
        ttl = 1m);

new mt_admin = named.director(
        port = "80",
        probe = www_to_mt_admin_probe,
        ttl = 1m);

new varnish_dynamic = named.director(
        port = "80",
        probe = varnish_dynamic_probe,
        ttl = 1m);

new adv_mt_avatars = named.director(
	port = 80,
	probe = probe_adv_mt_avatars,
	ttl = 1m);

new adv_mt_design = named.director(
	port = 80,
	probe = probe_adv_mt_design,
	ttl = 1m);

new static_buckets = named.director(
	port = 80,
	probe = probe_static_buckets,
	ttl = 1m);

new newsengin = named.director(
	port = 80,
	probe = probe_newsengin,
	ttl = 1m);

new feedparser = named.director(
        port = 80,
        probe = probe_feedparser,
        ttl = 1m);

new classifieds = named.director(
        port = 80,
        probe = probe_classifieds,
        ttl = 1m);

new minutes = named.director(
        port = 80,
        probe = probe_minutes,
        ttl = 1m);

new fetch = named.director(
        port = 80,
        probe = probe_fetch,
        ttl = 1m,
	whitelist = ipv4_only);

new expo = named.director(
        port = 80,
        probe = probe_expo,
        ttl = 1m);

new gallery = named.director(
        port = 80,
        probe = probe_gallery,
        ttl = 1m);

new mmslideshow = named.director(
        port = 80,
        probe = probe_mmslideshow,
        ttl = 1m);

