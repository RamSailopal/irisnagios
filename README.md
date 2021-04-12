AUTHOR - Raman Sailopal

BACKGROUND - Linux command line utility to parse Nagios logs and import them into an Intersystems IRIS database global

The utility will allow a full import of the Nagios archive logs and then subsequent periodic import of the "live" nagios.log file set up off a cron job

PREREQUISITES -
                  A working Intersystems IRIS implementation
                  A working Nagios implementation
                  iriscmd - Attained from https://github.com/RamSailopal/iriscmd

PARAMETERS -
                  IRIS instance name - First parameter
                  IRIS namespace - Second Parameter
                  full - (optional) - Third Parameter - Whether to parse the archive files

USAGE EXAMPLE - 
                  
  To run for the first time, run:
                  
                  irisnagios "IRIS" "USER" "full"

This will process all log files in /var/log/nagios/archives

After the import of the archives, remove the full third parameter in order to process the "live" /var/log/nagios/nagios.log file only, and so:

                  irisnagios "IRIS" "USER"

This execution can then be set up of a periodic cron job

Taking the example host check line from the Nagios logs:

                  [1618182000] CURRENT HOST STATE: gateway;UP;HARD;1;PING OK - Packet loss = 0%, R
                  TA = 0.70 ms

This line would be translated to:

                  ^NAGIOS("gateway","1618182000","hostchk","date")="Mon 12 Apr 2021 00:00:00 BST"
                  ^NAGIOS("gateway","1618182000","hostchk","State")="UP"
                  ^NAGIOS("gateway","1618182000","hostchk","Check")="HARD"
                  ^NAGIOS("gateway","1618182000","hostchk","Info")="PING OK - Packet loss = 0%, R
TA = 0.70 ms"                  

   NOTE - The subscript "hostchk" is reserved for Nagios host checks and so try not to have service names with this reserved word

Taking the example service check line:

                   [1618182000] CURRENT SERVICE STATE: server1;CPU Temp;OK;HARD;1;sensor ok

This line would be translated to:

                   ^NAGIOS("server1","1618182000","CPU Temp","date")="Mon 12 Apr 2021 00:00:00 BST"
                   ^NAGIOS("gateway","1618182000","hostchk","State")="OK"
                   ^NAGIOS("gateway","1618182000","hostchk","Check")="HARD"
                   ^NAGIOS("gateway","1618182000","hostchk","Info")="sensor ok"

INSTALLATION:

    git clone https://github.com/RamSailopal/irisnagios.git
    mv irisnagios/irisnagios /usr/local/bin/
