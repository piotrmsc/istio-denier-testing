FROM alpine:3.8

ENV KUBECTL_VERSION 1.10.6
# Install kubectl
RUN apk --no-cache upgrade \
	&& apk --no-cache --update add curl \
	&& curl -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl


WORKDIR /data

COPY ./input/ .

RUN apk add bash
ENTRYPOINT ["./test.sh"]