url = require 'url'
jade = require 'jade'
mimeType = require './mimetype.coffee'
child_process = require 'child_process'
fs = require 'fs'

route = (req, res)->
  pathname = url.parse(req.url).pathname
  contentType = mimeType.getType pathname
  res.setHeader 'Content-Type', contentType
  switch contentType
    when 'text/css'
      fs.readFile "#{process.cwd()}/src_target/stylesheets#{pathname}", (err, data)->
        unless err
          res.write data, 'utf-8'
          res.end()
    when 'text/javascript'
      fs.readFile "#{process.cwd()}/src_target/scripts#{pathname}", (err, data)->
        unless err
          res.write data, 'utf-8'
          res.end()
    when 'image/png', 'image/jpg', 'image/gif'
      fs.readFile "#{process.cwd()}/src/images#{pathname}", 'binary', (err, data)->
        res.write data, 'binary'
        res.end()
    when 'text/html'
      pathname = 'index' if pathname is '/'
      fs.readFile "#{process.cwd()}/src_target/templates/#{pathname}.html", (err, data)->
        unless err
          res.write data, 'utf-8'
          res.end()
    else
      res.write 'file not found'
      res.end()

module.exports =
  route: route