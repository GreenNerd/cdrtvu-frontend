path = require 'path'

mimeMaps =
  'css': 'text/css'
  'js': 'text/javascript'
  'txt': 'text/plain'
  'html': 'text/html'
  'xml': 'text/xml'
  'htm': 'text/html'

  'json': 'application/json'
  'pdf': 'application/pdf'
  'zip': 'application/zip'
  'gzip': 'application/gzip'

  'svg': 'image/svg+xml'
  'png': 'image/png'
  'jpg': 'image/jpeg'
  'gif': 'image/gif'
  'ico': 'image/x-icon'

  'mp1': 'audio/mp1'
  'mp2': 'audio/mp2'
  'mp3': 'audio/mpeg'

  'mp4': 'video/mp4'
  'ogg': 'video/ogg'
  'webm': 'video/webm'
  'mpeg': 'video/mpeg'
  'avi': 'video/avi'

  'xls': 'application/vnd.ms-excel'
  'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  'ppt': 'application/vnd.ms-powerpoint'
  'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
  'doc': 'application/vnd.ms-document'
  'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'

getExtName = (dir)->
  path.extname(dir).slice(1)

getType = (dir)->
  mimeMaps[getExtName(dir)] || mimeMaps.html

module.exports =
  getType: getType
  getExtName: getExtName