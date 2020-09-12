#!/bin/ash 

# Execute certbot immediately and exit
if [ "$1" = "--single-run" ]; then
    /root/letsencryptrenew.sh
    exit $?;
fi;


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
