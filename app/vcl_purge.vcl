# vcl_purge

#if (req.method == "PURGE") {
#        set req.method = "GET";
#        return (restart);
#}

return (synth(205, "PURGED"));

