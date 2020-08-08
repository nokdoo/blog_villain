# Use the official image as a parent image.
FROM archlinux:20191006

# Set the working directory.
WORKDIR /usr/src/app

# Copy the file from your host to your current location.
COPY install.sh .

# Run the command inside your image filesystem.
# RUN npm install

# Run the specified command within the container.
CMD [ "bash", "install.sh" ]
