// Generated by CoffeeScript 1.3.3
var americano, port;

americano = require('americano');

port = process.env.PORT || 9250;

americano.start({
  name: 'Bookmark',
  port: port
});
