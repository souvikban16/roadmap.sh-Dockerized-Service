# Simple Node.js service

Install dependencies and start the service:

```sh
npm install
npm start
```

The service listens on port `3000` by default. Set `PORT` to change it.

- `GET /` is public.
- `GET /secret` requires HTTP Basic Auth. The default credentials are `username` and `password`.

Override the credentials with `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD` environment variables. Basic Auth should only be used over HTTPS outside local development.

Try the routes with curl:

```sh
curl http://localhost:3000/
curl -i http://localhost:3000/secret
curl -u username:password http://localhost:3000/secret
```