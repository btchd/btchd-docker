# Debugging

## Things to Check

* RAM utilization -- btchdd is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The btchd blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 10GB+ is necessary.

## Viewing btchdd Logs

    docker logs btchdd-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the btchdd node, but will not connect to already running containers or processes.

    docker run -v btchdd-data:/btchd --rm -it btchd/btchdd bash -l

You can also attach bash into running container to debug running btchdd

    docker exec -it btchdd-node bash -l


