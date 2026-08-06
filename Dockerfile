# syntax=docker/dockerfile:1

# base python image for custom image
FROM python:3.9.13-slim-buster

# CVE-FINDER-OS-UPGRADES-BEGIN
RUN apt-get update && apt-get install -y --no-install-recommends \
    glibc=0:2.28-10+deb10u2 \
    libtasn1-6=0:4.13-3+deb10u1 \
    openssl=NotAvailable \
    zlib=1:1.2.11.dfsg-1+deb10u2 \
    && rm -rf /var/lib/apt/lists/*
# CVE-FINDER-OS-UPGRADES-END

# create working directory and install pip dependencies
WORKDIR /hello-py
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# copy python project files from local to /hello-py image working directory
COPY . .

# run the flask server  
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
