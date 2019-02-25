if (bereq.http.host ~ "al.com") {

if (bereq.url ~ "^/news/anniston-gadsden/") { set bereq.url = regsub(bereq.url, "/news/anniston-gadsden/", "/impact/news_anniston-gadsden_impact/"); }
elsif (bereq.url ~ "^/news/beaches/") { set bereq.url = regsub(bereq.url, "/news/beaches/", "/impact/news_beaches/"); }
elsif (bereq.url ~ "^/news/birmingham/") { set bereq.url = regsub(bereq.url, "/news/birmingham/", "/news_birmingham_impact/"); }
elsif (bereq.url ~ "^/news/huntsville/") { set bereq.url = regsub(bereq.url, "/news/huntsville/", "/news_huntsville_impact/"); }
elsif (bereq.url ~ "^/news/mobile/") { set bereq.url = regsub(bereq.url, "/news/mobile/", "/news_huntsville_impact/"); }
elsif (bereq.url ~ "^/news/montgomery/") { set bereq.url = regsub(bereq.url, "/news/montgomery/", "/news_montgomery_impact/"); }
elsif (bereq.url ~ "^/news/tuscaloosa/") { set bereq.url = regsub(bereq.url, "/news/tuscaloosa/", "/news_tuscaloosa_impact/"); }

} elsif (bereq.http.host ~ "cleveland.com") {

if (bereq.url ~ "^/news/") { set bereq.url = regsub(bereq.url, "/news/", "/realtimenews/"); }
elsif (bereq.url ~ "^/arts/") { set bereq.url = regsub(bereq.url, "/arts/", "/ent_impact_arts/"); }
elsif (bereq.url ~ "^/movies/") { set bereq.url = regsub(bereq.url, "/movies/", "/ent_impact_movies/"); }
elsif (bereq.url ~ "^/tv/") { set bereq.url = regsub(bereq.url, "/tv/", "/ent_impact_tv/"); }
elsif (bereq.url ~ "^/top-restaurants/") { set bereq.url = regsub(bereq.url, "/top-restaurants/", "/dining-guide/"); }
elsif (bereq.url ~ "^/people/") { set bereq.url = regsub(bereq.url, "/people/", "/ent_impact_people/"); }
elsif (bereq.url ~ "^/detroit-shoreway/") { set bereq.url = regsub(bereq.url, "/detroit-shoreway/", "/detroit_shoreway_impact/"); }


} elsif (bereq.http.host ~ "masslive.com") {

if (bereq.url ~ "^/news/") { set bereq.url = regsub(bereq.url, "/news/", "/breakingnews/"); }

} elsif (bereq.http.host ~ "nj.com") {

if (bereq.url ~ "^/entertainment/celebrities/") { set bereq.url = regsub(bereq.url, "/entertainment/celebrities/", "/entertainment_impact_celebrities/"); }
elsif (bereq.url ~ "^/college-basketball/") { set bereq.url = regsub(bereq.url, "/college-basketball/", "/college_basketball_blog/"); }
elsif (bereq.url ~ "^/fathers-day/") { set bereq.url = regsub(bereq.url, "/fathers-day/", "/fathers_day/"); }
elsif (bereq.url ~ "^/flyers/") { set bereq.url = regsub(bereq.url, "/flyers/", "/flyers_main/"); }
elsif (bereq.url ~ "^/healthfit/") { set bereq.url = regsub(bereq.url, "/healthfit/", "/health_and_fitness_multiblog/"); }
elsif (bereq.url ~ "^/homegarden/") { set bereq.url = regsub(bereq.url, "/homegarden/", "/hg_impact/"); }
elsif (bereq.url ~ "^/hudson/") { set bereq.url = regsub(bereq.url, "/hudson/", "/hudsoncountynow_impact/"); }
elsif (bereq.url ~ "^/living/") { set bereq.url = regsub(bereq.url, "/living/", "/ledger_features/"); }
elsif (bereq.url ~ "^/entertainment/movies/") { set bereq.url = regsub(bereq.url, "/entertainment/movies/", "/stephen_whitty_on_movies/"); }
elsif (bereq.url ~ "^/news/") { set bereq.url = regsub(bereq.url, "/news/", "/ledgerupdates_impact/"); }
elsif (bereq.url ~ "^/south/") { set bereq.url = regsub(bereq.url, "/south/", "/southjersey_impact/"); }
elsif (bereq.url ~ "^/olympics/") { set bereq.url = regsub(bereq.url, "/olympics/", "/olympics_main/"); }
elsif (bereq.url ~ "^/passaic-county/") { set bereq.url = regsub(bereq.url, "/passaic-county/", "/passaic_impact/"); }
elsif (bereq.url ~ "^/redbulls/") { set bereq.url = regsub(bereq.url, "/redbulls/", "/red_bulls/"); }
elsif (bereq.url ~ "^/shore/blogs/fishing/") { set bereq.url = regsub(bereq.url, "/shore/blogs/fishing/", "/saltwaterfishing_impact/"); }
elsif (bereq.url ~ "^/sixers/") { set bereq.url = regsub(bereq.url, "/sixers/", "/sixers_main/"); }
elsif (bereq.url ~ "^/soccer-news/") { set bereq.url = regsub(bereq.url, "/soccer-news/", "/nj_soccer/"); }
elsif (bereq.url ~ "^/south/") { set bereq.url = regsub(bereq.url, "/south/", "/southjersey_impact/"); }
elsif (bereq.url ~ "^/super-bowl/") { set bereq.url = regsub(bereq.url, "/super-bowl/", "/super_bowl_blog/"); }
elsif (bereq.url ~ "^/susses-county/") { set bereq.url = regsub(bereq.url, "/susses-county/", "/sussex_impact/"); }
elsif (bereq.url ~ "^/entertainment/tv/") { set bereq.url = regsub(bereq.url, "/entertainment/tv/", "/entertainment_impact_tv/"); }
elsif (bereq.url ~ "^/cape-may-county/") { set bereq.url = regsub(bereq.url, "/cape-may-county/", "/capemay_impact/"); }
elsif (bereq.url ~ "^/gloucester-county/") { set bereq.url = regsub(bereq.url, "/gloucester-county/", "/gloucestercounty_impact/"); }
elsif (bereq.url ~ "^/hunterdon-county-democrat/") { set bereq.url = regsub(bereq.url, "/hunterdon-county-democrat/", "/hunterdonnews_impact/"); }
elsif (bereq.url ~ "^/essenger-gazette/") { set bereq.url = regsub(bereq.url, "/essenger-gazette/", "/essengergazette_impact/"); }


} elsif (bereq.http.host ~ "lehighvalleylive.com") {

if (bereq.url ~ "^/ironpigs/") { set bereq.url = regsub(bereq.url, "/ironpigs/", "/lvironpigs_impact/"); }


} elsif (bereq.http.host ~ "nola.com") {

if (bereq.url ~ "^/arts/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/arts/baton-rouge/", "/impact/arts_baton_rouge/"); }
elsif (bereq.url ~ "^/business/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/business/baton-rouge/", "/impact/business_baton_rouge/"); }
elsif (bereq.url ~ "^/community/st-tammany/") { set bereq.url = regsub(bereq.url, "^/community/st-tammany/", "/st-tammany-community_impact/"); }
elsif (bereq.url ~ "^/crime/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/crime/baton-rouge/", "/baton_rouge_crime/"); }
elsif (bereq.url ~ "^/dining/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/dining/baton-rouge/", "/impact/dining_baton_rouge/"); }
elsif (bereq.url ~ "^/dining-guide/") { set bereq.url = regsub(bereq.url, "^/dining-guide/", "/diningguide_impact/"); }
elsif (bereq.url ~ "^/education/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/education/baton-rouge/", "/impact/education_baton_rouge/"); }
elsif (bereq.url ~ "^/entertainment/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/entertainment/baton-rouge/", "/nola_river_baton_rouge_entertainment/"); }
elsif (bereq.url ~ "^/homegarden/") { set bereq.url = regsub(bereq.url, "^/homegarden/", "/home_impact/"); }
elsif (bereq.url ~ "^/live/") { set bereq.url = regsub(bereq.url, "^/live/", "/bourbocam_impact/"); }
elsif (bereq.url ~ "^/living/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/living/baton-rouge/", "/impact/living_baton_rouge/"); }
elsif (bereq.url ~ "^/music/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/music/baton-rouge/", "/impact/music_baton_rouge/"); }
elsif (bereq.url ~ "^/news/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/news/baton-rouge/", "/nola_river_baton_rouge_news/"); }
elsif (bereq.url ~ "^/news/gulf-oil-spill/") { set bereq.url = regsub(bereq.url, "^/news/gulf-oil-spill/", "/2010_gulf_oil_spill/"); }
elsif (bereq.url ~ "^/opinions/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/opinions/baton-rouge/", "/impact/opinions_baton_rouge/"); }
elsif (bereq.url ~ "^/soccer/") { set bereq.url = regsub(bereq.url, "^/soccer/", "/new_orleans_soccer_impact/"); }
elsif (bereq.url ~ "^/society/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/society/baton-rouge/", "/impact/society_baton_rouge/"); }
elsif (bereq.url ~ "^/southern-university/") { set bereq.url = regsub(bereq.url, "^/southern-university/", "/impact/southern_university/"); }
elsif (bereq.url ~ "^/sports/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/sports/baton-rouge/", "/impact/sports_baton_rouge/"); }
elsif (bereq.url ~ "^/sports/fantasy/") { set bereq.url = regsub(bereq.url, "^/sports/fantasy/", "/fantasy/"); }
elsif (bereq.url ~ "^/traffic/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/traffic/baton-rouge/", "/impact/traffic_baton_rouge/"); }
elsif (bereq.url ~ "^/weather/baton-rouge/") { set bereq.url = regsub(bereq.url, "^/weather/baton-rouge/", "/nola_river_baton_rouge_weather_and_hurricane/"); }

} elsif (bereq.http.host ~ "oregonlive.com") {

if (bereq.url ~ "^/sports/civilwar/") { set bereq.url = regsub(bereq.url, "/sports/civilwar/", "/civilwar_impact/"); }
elsif (bereq.url ~ "^/news/oregonian/steve_duin/") { set bereq.url = regsub(bereq.url, "/news/oregonian/steve_duin/", "/steve-duin-impact/"); }
elsif (bereq.url ~ "^/celebrity-news/") { set bereq.url = regsub(bereq.url, "/celebrity-news/", "/parade/"); }
elsif (bereq.url ~ "^/entertainment/") { set bereq.url = regsub(bereq.url, "/entertainment/", "/ent_impact_home/"); }
elsif (bereq.url ~ "^/performance/") { set bereq.url = regsub(bereq.url, "/performance/", "/ent_impact_performance/"); }
elsif (bereq.url ~ "^/art/") { set bereq.url = regsub(bereq.url, "/art/", "/ent_impact_arts/"); }
elsif (bereq.url ~ "^/music/") { set bereq.url = regsub(bereq.url, "/music/", "/ent_impact_music/"); }
elsif (bereq.url ~ "^/movies/") { set bereq.url = regsub(bereq.url, "/movies/", "/ent_impact_tvfilm/"); }
elsif (bereq.url ~ "^/dining/") { set bereq.url = regsub(bereq.url, "/dining/", "/ent_impact_dining/"); }
elsif (bereq.url ~ "^/clark-county/") { set bereq.url = regsub(bereq.url, "/clark-county/", "/clark_county/"); }
elsif (bereq.url ~ "^/happy-valley/") { set bereq.url = regsub(bereq.url, "/happy-valley/", "/happy_valley/"); }
elsif (bereq.url ~ "^/oregon-city/") { set bereq.url = regsub(bereq.url, "/oregon-city/", "/oregon_city/"); }
elsif (bereq.url ~ "^/lake-oswego/") { set bereq.url = regsub(bereq.url, "/lake-oswego/", "/lake_oswego/"); }
elsif (bereq.url ~ "^/west-linn/") { set bereq.url = regsub(bereq.url, "/west-linn/", "/west_linn/"); }
elsif (bereq.url ~ "^/sports/oregonian/bill_monroe/ /bill_monroe_impact/") { set bereq.url = regsub(bereq.url, "/sports/oregonian/bill_monroe/ /bill_monroe_impact/", ""); }
elsif (bereq.url ~ "^/aloha/") { set bereq.url = regsub(bereq.url, "/aloha/", "/aloha_news/"); }
elsif (bereq.url ~ "^/north-of-26/") { set bereq.url = regsub(bereq.url, "/north-of-26/", "/northof26/"); }

} elsif (bereq.http.host ~ "silive.com") {

if (bereq.url ~ "^/celebrations/milestones/") { set bereq.url = regsub(bereq.url, "/celebrations/milestones/", "/celebrations_milestones/"); }
elsif (bereq.url ~ "^/entertainment/") { set bereq.url = regsub(bereq.url, "/entertainment/", "/entertainment_impact_home/"); }
elsif (bereq.url ~ "^/entertainment/music/") { set bereq.url = regsub(bereq.url, "/entertainment/music/", "/entertainment_impact_music/"); }
elsif (bereq.url ~ "^/entertainment/tvfilm/") { set bereq.url = regsub(bereq.url, "/entertainment/tvfilm/", "/entertainment_impact_tvfilm/"); }
elsif (bereq.url ~ "^/guide/") { set bereq.url = regsub(bereq.url, "/guide/", "/the_staten_island_guide/"); }
elsif (bereq.url ~ "^/healthfit/") { set bereq.url = regsub(bereq.url, "/healthfit/", "/health_and_fitness_news_from_the_staten_island_advance/"); }
elsif (bereq.url ~ "^/knicks/") { set bereq.url = regsub(bereq.url, "/knicks/", "/knicks_blog/"); }
elsif (bereq.url ~ "^/news/") { set bereq.url = regsub(bereq.url, "/news/", "/latest_news/"); }
elsif (bereq.url ~ "^/opinion/columns/ /opinion_columns/") { set bereq.url = regsub(bereq.url, "/opinion/columns/ /opinion_columns/", ""); }
elsif (bereq.url ~ "^/opinion/danielleddy/ /opinion_danielleddy/") { set bereq.url = regsub(bereq.url, "/opinion/danielleddy/ /opinion_danielleddy/", ""); }
elsif (bereq.url ~ "^/opinion/editorials/ /editorials_impact/") { set bereq.url = regsub(bereq.url, "/opinion/editorials/ /editorials_impact/", ""); }
elsif (bereq.url ~ "^/opinion/letters/ /letters_impact/") { set bereq.url = regsub(bereq.url, "/opinion/letters/ /letters_impact/", ""); }
elsif (bereq.url ~ "^/rangers/") { set bereq.url = regsub(bereq.url, "/rangers/", "/rangers_blog/"); }
elsif (bereq.url ~ "^/sports/advance/dowd/ /advance/dowd/") { set bereq.url = regsub(bereq.url, "/sports/advance/dowd/ /advance/dowd/", ""); }
elsif (bereq.url ~ "^/sports/advance/gordon/ /advance/gordon/") { set bereq.url = regsub(bereq.url, "/sports/advance/gordon/ /advance/gordon/", ""); }
elsif (bereq.url ~ "^/sports/advanceonsports/ /advancesports_impact/") { set bereq.url = regsub(bereq.url, "/sports/advanceonsports/ /advancesports_impact/", ""); }
elsif (bereq.url ~ "^/weddings/") { set bereq.url = regsub(bereq.url, "/weddings/", "/celebrations_weddings/"); }
elsif (bereq.url ~ "^/sports/") { set bereq.url = regsub(bereq.url, "/sports/", "/sportsstories/"); }

} elsif (bereq.http.host ~ "syracuse.com") {

if (bereq.url ~ "^/celebrety-news/") { set bereq.url = regsub(bereq.url, "/celebrety-news/", "/parade/"); }
elsif (bereq.url ~ "^/collegelacrosse/") { set bereq.url = regsub(bereq.url, "/collegelacrosse/", "/college_lacrosse_impact/"); }
elsif (bereq.url ~ "^/music/") { set bereq.url = regsub(bereq.url, "/music/", "/musicscene_impact/"); }

}
