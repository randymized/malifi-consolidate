_= require('underscore')
path= require('path')
connect= require('connect')
assert = require('assert')
malifi = require('malifi')
http = require('http')
port= 8889
host = 'localhost'

app= connect.createServer()
app.use(connect.urlencoded())
app.use(malifi(__dirname+'/sites/main'))
app.listen(port)

getResponse= (res,expected,statusCode,done)->
  if _.isFunction(expected)
    done= expected
  buf= ''
  res.statusCode.should.equal(statusCode)
  res.setEncoding('utf8')
  res.on 'data', (chunk)->
    buf += chunk
  res.on 'end', ()->
    if _.isFunction(expected)
      expected(null,buf,res)
    else
      buf.should.equal(expected)
      done()
  res.on 'error', (exception) ->
    done(exception)

get= (url, expected, statusCode, done)->
  unless done?
    done= statusCode
    statusCode=200
  options =
    host: host,
    port: port,
    path: url
  req= http.get options, (res)->
    if typeof expected is 'number'
      res.statusCode.should.equal(expected)
      done()
    else
      getResponse(res,expected,statusCode,done)

describe 'Malifi', ->
  before (cb) ->
    process.nextTick cb
  after ->
    app.close

  it 'should render a underscore template via Consolidate and set the correct content-type header', (done) ->
    get '/under',(err,buf,res)->
      if err
        done(err)
      else
        buf.should.equal('<body>xyz</body>')
        res.headers['content-type'].should.equal('text/html')
        done()
  it 'should render a jade template via Consolidate', (done) ->
    get('/jaded','<div id="user">me &lt;human@example.com&gt;</div>', done)
