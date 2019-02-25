# vcl_backend

# this needs to be addressed prior to datacenter shut off
backend global_amp_uat {
	.host = "cs-275-web-uat-amp.v.advance.net";
	.port = "80";
}

probe www_to_amp_probe {
        .url = "/v1/varnish-health-check";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 301;
}

probe www_to_static_dot_probe {
        .url = "/robots.txt";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
	.expected_response = 200;
}

probe www_to_mt_web_probe {
        .url = "/robots.txt";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
        .expected_response = 200;
}

probe www_to_mt_api_probe {
        .url = "/robots.txt";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
        .expected_response = 200;
}

probe www_to_mt_admin_probe {
        .url = "/robots.txt";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
        .expected_response = 200;
}

probe varnish_dynamic_probe {
        .url = "/varnish-health/";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
        .expected_response = 200;
}

probe probe_adv_mt_avatars {
	.url = "/index.html";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
	.expected_response = 200;
}

probe probe_adv_mt_design {
	.url = "/index.html";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
	.expected_response = 200;
}

probe probe_static_buckets {
	.url = "/robots.txt";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
	.expected_response = 200;
}

probe probe_newsengin {
	.url = "/web/gateway.php";
	.interval = 5s;
	.timeout = 10s;
	.window = 5; 
	.threshold = 3;
	.initial = 3;
	.expected_response = 200;
}

probe probe_feedparser {
        .url = "/stack-check/";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_classifieds {
        .url = "/varnish-health/";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_minutes {
        .url = "/robots.txt";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_fetch {
        .url = "/river?tags=healthcheck&section=&limit=0&affiliate=nj.com";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_expo {
        .url = "/index.html";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_gallery {
        .url = "/index.html";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

probe probe_mmslideshow {
        .url = "/index.html";
        .interval = 5s;
        .timeout = 10s;
        .window = 5;
        .threshold = 3;
        .initial = 3;
        .expected_response = 200;
}

