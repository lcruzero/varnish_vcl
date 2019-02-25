vcl 4.0;

sub exploit_workaround_4_1 {
        # This needs to come before your vcl_recv function
        # The following code is only valid for Varnish Cache and
        # Varnish Cache Plus versions 4.1.x and 5.0.0
        if (req.http.transfer-encoding ~ "(?i)chunked") {
                C{
                struct dummy_req {
                        unsigned magic;
                        int step;
                        int req_body_status;
                };
                ((struct dummy_req *)ctx->req)->req_body_status = 5;
                }C

                return (synth(503, "Bad request"));
        }
}

acl purgers {
    "127.0.0.1";
    "10.0.0.0"/16;
}

acl ipv4_only { "0.0.0.0"/0; }
import named;
include "app/backend.vcl";

sub vcl_init {
	include "app/vcl_init.vcl";
}
sub vcl_fini {
	include "app/vcl_fini.vcl";
}
sub vcl_recv {
	include "app/vcl_recv.vcl";
}
sub vcl_pipe {
	include "app/vcl_pipe.vcl";
}
sub vcl_pass {
	include "app/vcl_pass.vcl";
}
sub vcl_hash {
	include "app/vcl_hash.vcl";
}
sub vcl_purge {
	include "app/vcl_purge.vcl";
}
sub vcl_hit {
	include "app/vcl_hit.vcl";
}
sub vcl_miss {
	include "app/vcl_miss.vcl";
}
sub vcl_deliver {
	include "app/vcl_deliver.vcl";
}
sub vcl_synth {
	include "app/vcl_synth.vcl";
}
sub vcl_backend_fetch {
	include "app/vcl_backend_fetch.vcl";
}
sub vcl_backend_response {
	include "app/vcl_backend_response.vcl";
}
sub vcl_backend_error {
	include "app/vcl_backend_error.vcl";
}
