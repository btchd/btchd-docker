btchdd config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v btchdd-data:/btchd --name=btchdd-node -d \
            -p 8733:8733 \
            -p 127.0.0.1:8732:8732 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            btchd/btchdd

Or you can use your very own config file like that:

        docker run -v btchdd-data:/btchd --name=btchdd-node -d \
            -p 8733:8733 \
            -p 127.0.0.1:8732:8732 \
            -v /etc/mybtchd.conf:/btchd/.btchd/btchd.conf \
            btchd/btchdd
