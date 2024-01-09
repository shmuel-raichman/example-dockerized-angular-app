# B"H
# Use official node image as the base image
FROM node:20.10.0-bullseye as build


# Set the working directory
ENV WORKDIR=/opt/app/
WORKDIR ${WORKDIR}

# Install all the dependencies, with cache.
COPY ./package*.json ${WORKDIR}
RUN npm install

# Add the source code to app
COPY ./ ${WORKDIR}

# Generate the build of the application
RUN npm run build

# Stage 2: Serve app with nginx server
# Use official nginx image as the base image
FROM nginx:latest

# Set the working directory
ENV WORKDIR=/usr/share/nginx/html
WORKDIR ${WORKDIR}

# Copy the build output to replace the default nginx contents.
COPY --from=build /opt/app/dist/example-dockerized-angular-app/browser/ ${WORKDIR}

# Add entrypoint script to change env variables at container startup.
COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Expose port 80
EXPOSE 80

# Example of env variable used by the entrypoint script.
ENV ENV_NAME="This is my env name text"

ENTRYPOINT [ "/opt/entrypoint.sh" ]