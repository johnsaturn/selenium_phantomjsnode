#!/bin/bash

if [ -z "$HUB_PORT_4444_TCP_ADDR" ]; then
  echo Not linked with a running Hub container 1>&2
  exit 1
fi

if [ -z "$HUB_PORT_4444_TCP_PORT" ]; then
	HUB_PORT_4444_TCP_PORT=4444
fi
function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

echo Retrieve Info from container in order to register to Hub

if [ -z "$myport" ]; then
  myport=28080
fi

myip="$(hostname -i)"


echo Preparing to execute phantomjs using configurations $myip:$myport


# TODO: Look into http://www.seleniumhq.org/docs/05_selenium_rc.jsp#browser-side-logs
phantomjs --webdriver=$myip:$myport --webdriver-selenium-grid-hub=http://$HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT  & NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID