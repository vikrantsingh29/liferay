FROM openjdk:8-jdk-slim

ARG LIFERAY_HOME
ARG CATALINA_HOME

RUN cd /opt \
    && apt-get update \
    && apt-get install -y  curl telnet tree nano iputils-ping p7zip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -ms /bin/bash liferay

RUN set -x \
      && curl -fSL "https://sourceforge.net/projects/lportal/files/Liferay%20Portal/7.3.5%20GA6/liferay-ce-portal-tomcat-7.3.5-ga6-20200930172312275.7z/download" -o liferay-ce-portal-tomcat-7.3.5-ga6-20200930172312275.7z \
      && p7zip --decompress liferay-ce-portal-tomcat-7.3.5-ga6-20200930172312275.7z \ 
      && mv liferay-ce-portal-7.3.5-ga6 /opt/liferay 

# Configure permissions
RUN cd /opt \
&& chown -R liferay:liferay /opt/liferay \
&& ln -s /opt/liferay /opt/liferay \
&& ln -s /opt/liferay/tomcat-9.0.37 /opt/tomcat \
&& chown -R liferay:liferay /opt/liferay \
&& chmod +x /opt/tomcat/bin/*.sh

# Add env independent props
ENV LIFERAY_HOME=/opt/liferay
ENV CATALINA_HOME=/opt/tomcat
          
COPY ./setenv.sh $CATALINA_HOME/bin/setenv.sh
ADD /portal-ext.properties /opt/liferay/portal-ext.properties

# Change user and run liferay
USER liferay
WORKDIR /opt/tomcat


# Ports
EXPOSE 8080

# EXEC
CMD ["run"]
ENTRYPOINT ["bin/catalina.sh", "run"]

