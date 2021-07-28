#!/bin/bash

authid=" 1de7cf7ee29750d60967"
authsecret="797930636167fb9cbfa36d566cd69ce909d92f09"

url=$(curl -s -u $authid:$authsecret "https://api.github.com/users?since=$(shuf -i 1-100000000 -n 1)&per_page=100" | jq ".[$(shuf -i 1-100 -n 1)].repos_url")
url=$(echo $url | tr -d \")
i=$(curl -s -u $authid:$authsecret $url | jq length | shuf -i 0-${1:-$(</dev/stdin)} -n 1)
res=$(curl -s -u $authid:$authsecret $url | jq ".[$i].html_url")
if [ "$res" == "null" ]; then
	./random_repo.sh
else
	echo -e "\e[32mHere it is\e[0m $res"
fi
