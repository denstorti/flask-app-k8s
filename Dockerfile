FROM python:3.8.6-slim as build
RUN apt update && \
	apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
ENV STATIC_URL /static
ENV STATIC_PATH /var/www/app/static

WORKDIR /var/www

COPY src/ /var/www/

RUN pip install -r /var/www/requirements.txt --target .

COPY start.sh /var/www/

FROM python:3.8.6-slim as final
WORKDIR /var/www

COPY --from=build /var/www .

EXPOSE 5000

CMD [ "bash", "-c", "./start.sh" ]
# CMD uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi:app
# CMD ["uwsgi", "--socket", "0.0.0.0:5000", "--protocol=http", "-w", "wsgi:app"]