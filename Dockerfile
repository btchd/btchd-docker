FROM ubuntu:18.04 AS btchd-pkg
ENV BHD_VERSION "v1.4.3"
ENV BHD_PKGDLURL "https://github.com/btchd/btchd/releases/download/v1.4.3/bhd-v1.4.3-7fe720529-x86_64-linux-gnu.tar.gz"
ADD "$BHD_PKGDLURL" /

FROM btchd-pkg
MAINTAINER goomario.gg <goomario.gg@gmail.com>

ARG USER_ID
ARG GROUP_ID

ENV HOME /btchd

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} btchd \
	&& useradd -u ${USER_ID} -g btchd -s /bin/bash -m -d /btchd btchd

# download and install btchd
RUN mkdir -p /usr/local \
	&& tar zxf "/$(basename $BHD_PKGDLURL)" -C /tmp && rm "/$(basename $BHD_PKGDLURL)" \
	&& cp -frp "/tmp/bhd-$BHD_VERSION/bin" /usr/local/ \
	&& cp -frp "/tmp/bhd-$BHD_VERSION/lib" /usr/local/ \
	&& cp -frp "/tmp/bhd-$BHD_VERSION/include" /usr/local/ \
	&& cp -frp "/tmp/bhd-$BHD_VERSION/share" /usr/local/ \
	&& rm -rf "/tmp/bhd-$BHD_VERSION"

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.12
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y \
		ca-certificates \
		wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./bin /usr/local/bin

VOLUME ["/btchd"]

EXPOSE 8732 8733 18732 18733

WORKDIR /btchd

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["btchd_oneshot"]