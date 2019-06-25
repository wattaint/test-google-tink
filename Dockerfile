FROM maven:3.6.1-jdk-8 as jarlibs

RUN wget https://repo1.maven.org/maven2/com/google/crypto/tink/tink/1.2.2/tink-1.2.2.pom -O /pom.xml
RUN mvn dependency:resolve
RUN mkdir /jars &&\
  cp $(find /root/.m2/repository/ -type f | grep ".jar$") /jars/
RUN wget https://repo1.maven.org/maven2/com/google/crypto/tink/tink/1.2.2/tink-1.2.2.jar -O /jars/tink-1.2.2.jar

FROM jruby:9.2.7.0-jre
COPY --from=jarlibs /jars /jars

COPY Gemfile Gemfile.lock /
RUN bundle install

COPY . /src
WORKDIR /src
