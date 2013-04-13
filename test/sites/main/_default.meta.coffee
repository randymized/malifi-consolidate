malifi_consolidate= require '../../../index'

module.exports=
  template_map_:
    'text/html': [
      ['html', malifi_consolidate('underscore')]
      ['jade', malifi_consolidate('jade')]
    ]
