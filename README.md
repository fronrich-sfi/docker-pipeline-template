# Docker Pipeline Template

## Overview

This repo contains files that allow users to deploy web apps to a docker container. It is designed for use with any frontend framework that builds to a `/build` directory, with a core `index.html` file at the root of `/build`.

## Installation

To install this template to an existing repo, execute the following commands from within the root folder of the repo:

```sh
npx degit fronrich-sfi/docker-pipeline-template#main temp


mv temp/src/* ./

rm -rf temp/

```

## Usage

Example docker command:

```sh
docker build -t react-frontend .

docker run  --name react-frontend -d -p 3000:80 react-frontend

try create again
```
