allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount(){
    echo "$allLogs" | cut -d' ' -f3 | sort | uniq -c
}

function countingCurlAccess(){
	cat /var/log/apache2/access.log | grep "curl" | cut -d' ' -f1,12 \
	| sort | uniq -c
}

#getAllLogs
#ips
#pageCount

countingCurlAccess
