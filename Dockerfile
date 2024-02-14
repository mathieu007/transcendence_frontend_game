FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    ca-certificates

RUN curl -fsSL https://deb.nodesource.com/setup_21.x 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get upgrade -y
RUN apt-get update -y
RUN apt-get install yarn -y
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN apt-get install vite -y
RUN npm install -g corepack
RUN corepack enable
RUN yarn set version stable
RUN yarn --version

# Set the working directory inside the container
WORKDIR /app

# Copying package.json, yarn.lock and other necessary files first to leverage Docker cache
COPY app/package.json app/yarn.lock app/.pnp.loader.mjs app/.pnp.cjs ./

COPY app/ ./
# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make sure the entrypoint script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
EXPOSE 5173

# Set the entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["yarn", "dev", "--host", "0.0.0.0"]
