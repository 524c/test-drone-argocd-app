FROM node:16-bullseye-slim as build

WORKDIR /app
ENV NODE_ENV=production
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    tini:arm64 \
    && rm -rf /var/lib/apt/lists/*

COPY ["package.json", "package-lock.json", "tsconfig.json", "svelte.config.js", "vite.config.ts", ".eslintrc.cjs", ".eslintignore", "./"]
COPY ["src", "./src"]
RUN npm install --include=dev && npm cache clean --force
RUN npm run build && npm prune --omit=dev && npm cache clean --force

# install only production packages
FROM node:16-bullseye-slim as prod

RUN apt-get update && apt-get upgrade -y --no-install-recommends

WORKDIR /app
RUN chown -R node:node /app
USER node
ENV NODE_ENV=production

COPY --chown=node:node build /app/build
COPY --chown=node:node package.json /app/package.json
COPY --chown=node:node node_modules /app/node_modules
COPY --chown=node:node static /app/static
COPY --from=build /usr/bin/tini /usr/bin/tini

EXPOSE 3000
ENV NODE_ENV=production
ENV PATH=/app/node_modules/.bin:$PATH

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/node", "build/index.js"]
#CMD ["/nodejs/bin/node", "build/index.js"]
