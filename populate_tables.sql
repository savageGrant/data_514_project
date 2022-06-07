COPY INTO "AIRBNB"."MAIN"."HOSTS" FROM @~/staged/sal_hosts.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."HOSTS" FROM @~/staged/la_hosts.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."HOSTS" FROM @~/staged/port_hosts.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."HOSTS" FROM @~/staged/sd_hosts.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."LISTINGS" FROM @~/staged/sal_slistings.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."LISTINGS" FROM @~/staged/la_slistings.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."LISTINGS" FROM @~/staged/port_slistings.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."LISTINGS" FROM @~/staged/sd_slistings.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;

COPY INTO "AIRBNB"."MAIN"."REVIEWS" FROM @~/staged/sd_reviews.csv FILE_FORMAT = '"AIRBNB"."MAIN"."CSVOPTIONAL"' ON_ERROR = 'ABORT_STATEMENT' PURGE = TRUE;
