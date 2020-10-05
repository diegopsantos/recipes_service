# Marley Spoon Web Challenge - Contentful Recipe

This repository contains my resolution for the **Marley Spoon Web Challenge - Contentful Recipe**. The challenge instructions are found [here](https://gist.github.com/lawitschka/063f2e28bd6993cac5f8b40b991ae899).

## Solution

I decided to go for a simple sinatra app because of the size of the problem. I tried to focus on simplicity, isolation and legibility, using a context approuch where the contentful context are different and isolated from my app's context and logic.

## Running the app

### Enviropment Variables

Before running the app, we need to set up the env vars for contentful connection.
Don't forget to change it for your real token

```sh
echo 'CONTENTFUL_ACCESS_TOKEN = INSERT_YOUR_TOKEN_HERE' > recipes/.env
```

### If you have docker compose
Just run it on your console:

```sh
docker-compose up --build
```

### Simple way
Just run it on your console:

```sh
cd recipes
bundle install
puma config.ru -C puma.rb
```

After that just access http://localhost:3000/

## Running the test suit

```sh
cd recipes
rspec
```
