# syntax=docker/dockerfile:1.4

FROM node:19.9-alpine as builder

ENV NODE_ENV $ENV
# WARNING: if container limit < MAX_OLD_SPACE_SIZE => Killed
# Docs: https://developer.ibm.com/languages/node-js/articles/nodejs-memory-management-in-container-environments/
ARG MAX_OLD_SPACE_SIZE=8192
ENV NODE_OPTIONS=--max_old_space_size=${MAX_OLD_SPACE_SIZE}

WORKDIR /app

# COPY the source code as the last step
COPY --chown=node:node . .

RUN npm ci --cache .npm --prefer-offline --force

CMD ["npm", "run", "prod"]
