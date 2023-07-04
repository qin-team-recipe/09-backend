FROM ruby:3.2.2 AS production

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        build-essential \
        default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /recipe_09_api
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8080

CMD rails server -b 0.0.0.0 -e production -p ${PORT:-8080}

FROM ruby:3.2.2 AS development

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        build-essential \
        default-mysql-client \
        vim \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /recipe_09_api
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD rails server -b 0.0.0.0 -e development -p ${PORT:-4001}
