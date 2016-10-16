FROM ubuntu:16.04

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential libpq-dev python-dev python-software-properties python-pip libmysqlclient-dev mysql-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD scripts/requirements.txt /code/scripts/requirements.txt
WORKDIR /code/scripts
RUN pip install -r requirements.txt

ADD . /code
VOLUME /code

CMD ./run.sh