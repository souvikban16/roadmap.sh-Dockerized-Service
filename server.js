const express = require('express');
const basicAuth = require('express-basic-auth');
require('dotenv').config();

const app = express();
const port = Number(process.env.PORT) || 3000;
// const username = process.env.USERNAME || process.env.BASIC_AUTH_USERNAME || 'username';
// const password = process.env.PASSWORD || process.env.BASIC_AUTH_PASSWORD || 'password';
// const secretMessage = process.env.SECRET_MESSAGE || 'You reached the secret route';


const username = process.env.BASIC_AUTH_USERNAME;
const password = process.env.PASSWORD;
const secretMessage = process.env.SECRET_MESSAGE;

app.get('/', (req, res) => {
  res.send('Service is running');
});

app.get(
  '/secret',
  basicAuth({
    users: { [username]: password },
    challenge: true,
  }),
  (req, res) => {
    res.send(secretMessage);
  },
);

app.listen(port, () => {
  console.log(`Service listening on port ${port}`);
});