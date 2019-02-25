if (req.http.host ~ "al.com") {
        set req.http.Location = "https://www.youtube.com/user/aldotcom";
} elsif (req.http.host ~ "cleveland.com") {
        set req.http.Location = "https://www.youtube.com/channel/UCJkc1COQO0WiZ2CI7dRdwAQ";
} elsif (req.http.host ~ "gulflive.com") {
        set req.http.Location = "https://www.youtube.com/user/aldotcom";
} elsif (req.http.host ~ "lehighvalleylive.com") {
        set req.http.Location = "https://www.youtube.com/user/lehighvalleylive";
} elsif (req.http.host ~ "mardigras.com") {
        set req.http.Location = "https://www.youtube.com/channel/UCJvUK12OMDHh6gjQpvvXlFg";
} elsif (req.http.host ~ "masslive.com") {
        set req.http.Location = "https://www.youtube.com/channel/UCDmXyuvUm8aDC4asAOgFrgQ";
} elsif (req.http.host ~ "mlive.com") {
        set req.http.Location = "https://www.youtube.com/user/mlivevideo";
} elsif (req.http.host ~ "newyorkupstate.com") {
        set req.http.Location = "https://www.youtube.com/channel/UCm3af9XtbGdk_TiQy1mYvbw";
} elsif (req.http.host ~ "nj.com") {
        set req.http.Location = "https://www.youtube.com/tvjersey/";
} elsif (req.http.host ~ "nola.com") {
        set req.http.Location = "https://www.youtube.com/user/noladotcom";
} elsif (req.http.host ~ "oregonlive.com") {
        set req.http.Location = "https://www.youtube.com/user/oregoniannews";
} elsif (req.http.host ~ "pennlive.com") {
        set req.http.Location = "https://www.youtube.com/user/pennlive";
} elsif (req.http.host ~ "silive.com") {
        set req.http.Location = "https://www.youtube.com/channel/UC1KF4bZvT5iAbAHVv4MuNxg";
} elsif (req.http.host ~ "syracuse.com") {
        set req.http.Location = "https://www.youtube.com/channel/UChbYn187BlBxq5LfGqZSv_A";
}

return (synth(301, ""));

