FROM selenium/base:2.52.0
MAINTAINER Selenium <selenium-developers@googlegroups.com>

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "US/Pacific"
RUN echo "US/Pacific" | sudo tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

  
RUN apt-get update && apt-get -q -y install phantomjs 

#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh



USER seluser

CMD ["/opt/bin/entry_point.sh"]