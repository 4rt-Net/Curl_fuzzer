# Curl_fuzzer
a tool for when all else fails but curl appears to get results. 


The tool ingests a wordlist and sends GET requests to the specified webserver using each word within the wordlist. 
When a valid directory is found on the server it will be printed to terminal and written to an output file. 

At times normal fuzzers such as ffuf/gobuster/dirbuster might fail where curl can still get results. 

By default the tool is set on a time-delay of 2 seconds, adjust as needed depending on the sensitivity of the network.
The tool is not adjustable via switches, any changes needs to be made to the code itself as needed. 
