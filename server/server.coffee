http = require 'http'
router = require './route.coffee'

http
  .createServer (req, res)->
    router.route(req, res)
  .listen 4000

console.log 'server is running at localhost:4000'