# WorkoutServer

## Initial setup

At the root of the project, run

```bash
docker-compose up --no-start db
docker-compose run server mix setup
docker-compose up
```

Now you can visit [`localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Generate tables

To generate, in the News module, a Link table with a string url and text description, run:

```bash
docker-compose run server mix generate_table News Link links url:string description:text
```

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
