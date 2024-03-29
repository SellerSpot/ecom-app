# ---- Base Node ----
FROM alpine:3.12.3 AS base
# set work dir
WORKDIR /app
# install node
RUN apk add --no-cache nodejs npm
# copy project file
COPY . .

# ---- Dependencies ----
FROM base AS dependencies
# setting node environment to production
ENV NODE_ENV=production
# install node packages
RUN npm install

# ---- Dependencies ----
FROM base AS build
# install ALL node_modules, including 'devDependencies'
RUN npm install
# build application
RUN npm run build

# ---- Release ----
FROM base AS release
# setting node environment to production
ENV NODE_ENV=production
# copy node_modules from dependencies stage
COPY --from=dependencies /app/node_modules ./node_modules
# copy public folder from build stage
COPY --from=build /app/public ./public
# for fail safe on multi stage builds
RUN true
# copy .next folder from build stage
COPY --from=build /app/.next ./.next
# expose port
EXPOSE 7004
# define CMD
CMD ["npm", "start"]
