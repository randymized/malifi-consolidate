# malifi-consolidate

Adds template support to Malifi for the consolidate.js template engine consolidation library.

Using this, any template library supported by Consolidate.js should be usable with Malifi.

Usage:
In the metadata `template_map_` object for the target MIME type, map file extension(s) to `malifi-consolidate([engine_name]).

For example, to establish template mapping for an entire site, in the site's root directory `_default.meta.coffee` file:
```
malifi_consolidate= require 'malifi-consolidate'

module.exports=
  template_map_:
    'text/html': [
      ['html', malifi_consolidate('underscore')]
      ['jade', malifi_consolidate('jade')]
    ]
```

In the preceding example, if an HTML document were requested, templates with an `html` extension will be mapped to the Underscore template engine.  Templates with a `jade` extension would be mapped to the Jade template engine.

Alternatively, the same could be expressed in `_default.meta.js` as:
```
(function() {
  var malifi_consolidate;

  malifi_consolidate = require('../../../index');

  module.exports = {
    template_map_: {
      'text/html': [
      	['html', malifi_consolidate('underscore')],
      	['jade', malifi_consolidate('jade')]
      ]
    }
  };

}).call(this);

Of course, the metadata file could define other metadata, and the mapping could be established for any directory or even for individual URLs.
