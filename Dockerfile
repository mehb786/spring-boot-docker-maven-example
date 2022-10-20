FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jdk-11.0.3_7


RUN mkdir -p /user/share/[artifactId]/static/songs

RUN mkdir -p /user/share/[artifactId]/bin

ADD .  /user/share/cisapify/bin/[artifactId].jar

WORKDIR /user/share/[artifactId]
EXPOSE 8085

ENTRYPOINT ["/opt/java/openjdk/bin/java", "-jar", "bin/[artifactId].jar"]
