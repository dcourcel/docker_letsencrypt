#!/bin/ash 

if [ $# -gt 1 ]; then
    echo "The entrypoint can only run with 0 or 1 parameter."
    exit 1
fi

if [ -n "$1" ]; then
    # Execute certbot immediately with --standalone and exit
    if [ "$1" = "--no-server" ]; then
        /root/letsencryptcreate.sh
        exit $?
    fi;

    # Execute certbot immediately and exit
    if [ "$1" = "--single-run" ]; then
        /root/letsencryptrenew.sh
        exit $?;
    fi;

    echo "Unknown parameter $1. Exit."
    exit 2
fi


stopSequence()
{
    echo Stopping cron
    kill -s SIGTERM $(cat /var/run/crond.pid)
    exit
}

trap stopSequence SIGINT SIGTERM


printenv | sed -e 's/^\(.*\)$/"export \1"/g' -e '/^affinity:container/ d' > /root/project_env.sh
chmod u+x /root/project_env.sh

crond
tail -f /var/log/cron.log &
echo "Cron and tail started."
while true
do
    sleep infinity &
    wait $!
done
