# Install the app dependencies in a full Node docker image
FROM node:19.7

WORKDIR "/app"

# Install OS updates
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies'

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm install -g npm@9.6.2 --save-exact

# Copy the dependencies into a Slim Node docker image
FROM node:19

WORKDIR "/app"

# Install OS updates
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies'

# Install app dependencies
COPY --from=0 /app/node_modules /app/node_modules
COPY . /app

ENV NODE_ENV production
ENV PORT 30555


EXPOSE 30555
CMD ["npm", "start"]
