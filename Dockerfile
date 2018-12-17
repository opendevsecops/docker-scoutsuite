FROM opendevsecops/launcher:latest as launcher

# ---

FROM python:alpine

RUN true \
	&& apk add \
		--no-cache \
		--virtual .deps \
		build-base \
		python3-dev \
		libffi-dev openssl-dev

RUN true \
	&& pip install scoutsuite

RUN true \
	&& apk del .deps

RUN true \
	&& apk add \
		--no-cache \
		ca-certificates \
		libstdc++

WORKDIR /run

COPY --from=launcher /bin/launcher /bin/launcher

WORKDIR /session

ENTRYPOINT ["/bin/launcher", "Scout"]
