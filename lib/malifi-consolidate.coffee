###!
 * malifi-consolidate
 * Copyright(c) 2013 Randy McLaughlin <8b629a9884@snkmail.com>
 * MIT Licensed
###

cons = require('consolidate')

module.exports= consolidate_renderer= (engine_name)->
  engine_renderer = cons[engine_name]
  return {}=
    compile_file: (req,res,filename,when_compiled)->
      when_compiled null,
        render: (context,done)->
          try
            engine_renderer filename, context, (err, html)->
              if (err)
                done(err)
              else
                done(null,html)
          catch err
            done(err)
