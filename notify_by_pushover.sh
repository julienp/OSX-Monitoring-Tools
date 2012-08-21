#!/bin/bash

#	Notify by Pushover
#	by Jedda Wignall
#	http://jedda.me

#	v1.0 - 21 Aug 2012
#	Initial release.

# 	This script sends a Pushover (http://pushover.net/) notification to your account.

#	IMPORTANT
#	You will need to create a Pushover 'Application' for this script in your account, and use the provided API key as an argument
#	for this script. You can register an app once logged into Pushover at the follwing link:
#	https://pushover.net/apps/build
# 	Takes the following REQUIRED arguments:

# 	-u		Your Pushover user key.
# 	-a		Your Pushover application key.
# 	-t		The notification title.
# 	-m		The notification body.

# 	and the following OPTIONAL argument:

# 	-p		Notification priority. Set to 1 to ignore quiet times.

# 	Example:
#	./notify_by_pushover.sh -u r5j7mjYjd -a noZ9KuR5T -t "server.pretendco.com" -m "DISK WARNING - free space: /dev/disk0s2 4784 MB"

while getopts "u:a:t:m:p:" optionName; do
case "$optionName" in
u) userKey=( "$OPTARG" );;
a) appToken=( "$OPTARG" );;
t) title=( "$OPTARG" );;
m) message=( "$OPTARG" );;
p) priority=( "$OPTARG" );;

esac
done

if [ "$priority" != "" ]; then
	priorityString="priority=$priority"
else
	priorityString="priority=0"
fi

curl -F "token=$appToken" \
-F "user=$userKey" \
-F "title=$title" \
-F "message=$message" \
-F "$priorityString" \
https://api.pushover.net/1/messages

exit 0