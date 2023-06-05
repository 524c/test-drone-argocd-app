FROM node:16-bullseye-slim as build

WORKDIR /app
ENV NODE_ENV=production
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    tini:arm64 \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R node:node /app
USER node

COPY ["package.json", "package-lock.json", "./"]
COPY tsconfig.json ./
COPY svelte.config.js ./
COPY vite.config.ts ./
COPY .eslint.cjs ./
COPY .eslintignore ./
RUN pnpm install

COPY ["src/", "./src/"]
RUN npm run build && npm prune --omit=dev && npm cache clean --force

# install only production packages
FROM node:16-bullseye-slim as prod
WORKDIR /app

RUN apt-get update && apt-get upgrade -y --no-install-recommends

USER node
ENV NODE_ENV=production

COPY --chown=node:node build /app/build
COPY --chown=node:node package.json /app/package.json
COPY --chown=node:node node_modules /app/node_modules
COPY --chown=node:node static /app/static
COPY --from=build /usr/bin/tini /usr/bin/tini

#RUN ls -lahtr /app

EXPOSE 3000
ENV NODE_ENV=production
ENV PATH=/app/node_modules/.bin:$PATH

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/node", "build/index.js"]
#CMD ["/nodejs/bin/node", "build/index.js"]
