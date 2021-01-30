--

 -- setup piggyback functions. Useful pig function library

 --

 register file:/home/hadoop/lib/pig/piggybank.jar

 DEFINE ApacheCommonLogLoader org.apache.pig.piggybank.storage.apachelog.CommonLogLoader();

 --

 -- import log file and parse into individual components

 --

 logs = LOAD ‘$INPUT’ USING ApacheCommonLogLoader as (remoteHost, hyphen, user, time, method, uri, protocol, statusCode, responseSize);

 --

 -- Filter Apache GET requests from the log where the HTTP status code is 400 or greater

 --

 logsfiltered = FILTER logs BY method == ‘GET’ AND statusCode >= 400;

 --

 -- Retrieve the remote host list that generated the HTTP errors

 --

 logsremoteaddr = FOREACH logsfiltered GENERATE remoteHost;

 --

 -- Group parsed information by the remote hosts performing GET requests

 --  and create counts on the number of times the host generated an error

 --

 groupedByRemote = GROUP logsremoteaddr BY remoteHost;

 statusCounts = FOREACH groupedByRemote GENERATE group AS remoteHost, COUNT(logsremoteaddr) AS numStatus;

 --

 --Store HTTP status error report to S3

 --

 STORE statusCounts INTO ‘$OUTPUT’;
