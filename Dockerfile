
FROM centos/nodejs-10-centos7
 
ENV NPM_RUN="contrast"
ENV NODE_ENV="development"
ENV CONTRAST__ORG_ID="ac0ec4e6-f84a-46b5-8534-7a3a14632bf8"
ENV CONTRAST__API_KEY="9Xhur2FW4eK17pq7XNlO7uZ3L39LRdEA"
ENV CONTRAST__AUTHORIZATION="ZGF2aWQuZG9vbGV5QGNvbnRyYXN0c2VjdXJpdHkuY29tOklVVTdEMTBHQk00VzNOUVk="
ENV CONTRAST__BASEURL=https://apptwo.contrastsecurity.com/Contrast/api/ng/$CONTRAST__ORG_ID
ENV DEST=${APP_ROOT}/src
 
## Download nodejs agent and config file
RUN curl --max-time 15 $CONTRAST__BASEURL/agents/default/node -H API-Key:$CONTRAST__API_KEY -H Authorization:$CONTRAST__AUTHORIZATION -o $DEST/node-contrast.tgz
RUN curl --max-time 10 $CONTRAST__BASEURL/agents/external/default/NODE -H Accept:text/yaml -H API-Key:$CONTRAST__API_KEY -H Authorization:$CONTRAST__AUTHORIZATION -o $DEST/contrast_security.yaml
 
## patch s2i assemble script to include contrast install
USER root
RUN sed -i s/npm\ install/npm\ install\;npm\ install\ node-contrast.tgz\ --no-save/g  ${STI_SCRIPTS_PATH}/assemble
USER 1001
