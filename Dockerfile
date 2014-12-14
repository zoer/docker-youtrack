FROM dockerfile/java:oracle-java8
MAINTAINER Oleg Yashchuk <oazoer@gmail.com>

ENV YOUTRACK_VERSION 6.0.12223
RUN wget http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar -O youtrack.jar

# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
CMD \
    java \
    -Xmx1g \
    -Dorg.tanukisoftware.wrapper.WrapperSimpleApp.waitForStartMain=true \
    -Dorg.tanukisoftware.wrapper.WrapperSimpleApp.maxStartMainWait=300 \
    -XX:MaxPermSize=128m \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:+UseConcMarkSweepGC \
    -XX:+DisableExplicitGC \
    -XX:SoftRefLRUPolicyMSPerMB=10000 \
    -XX:+UseBiasedLocking \
    -Djava.awt.headless=true \
    -Xss4m \
    -Dcatalina.base=/home/youtrack/standalone \
    -Djetbrains.dnq.cachePercent=25 \
    -Djetbrains.dnq.sharedCache=false \
    -Djetbains.webr.uiQueryCancellingPolicyTimeout=80000 \
    -Djetbrains.dnq.fairLatches=false \
    -Djetbrains.dnq.readUncommittedForCachingThread=true \
    -Djetbrains.youtrack.disableBrowser=true \
    -jar youtrack.jar 80
