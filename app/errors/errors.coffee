@Errors = new ->
  _locales = new Array; _locale = null
  
  @init = (locale) ->
    count = 0
    
    for entry, i in _locales
      matches = entry.key.exec locale
      if matches && matches.length > count
        count = matches.length; _locale = entry.value
    
    throw new Error 'The specified locale is currently not defined.' unless _locale
  
  @get = (code) ->
    return _locale[code] if _locale[code]
    return _locale['Default']
    
  @add = (locale) ->
    _locales.push locale
    
  @
