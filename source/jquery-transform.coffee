{isNumeric} = $

transformProperty = 'transform'

$ ->
  el = document.createElement('div')
  unless el.style[transformProperty]?
    hash =
      mozTransform:    '-moz-transform'
      msTransform:     '-ms-transform'
      webkitTransform: '-webkit-transform'
      WebkitTransform: '-webkit-transform'
    for prop of hash when el.style[prop]?
      transformProperty = hash[prop]
      return
  return

$.fn.transform = (transformation) ->
  length     = arguments.length
  return this if length < 2

  i          = 0
  allNumeric = true
  allPresent = true

  while ++i < length and (allNumeric or allPresent)
    allNumeric = false if not isNumeric(arguments[i])
    allPresent = false if not arguments[i] and arguments[i] isnt 0

  if allNumeric or allPresent
    value = "#{transformation}("
    i     = 0
    while ++i < length
      unit   = if isNumeric(arguments[i]) then 'px' else ''
      value += "#{arguments[i]}#{unit}#{if (i + 1) < length then ',' else ''} "
    value += ')'
  else
    value = ''

  if value?
    el.style[transformProperty] = value for el in this
  this

$.fn.translate = ->
  if arguments.length is 2
    @transform('translate', arguments[0], arguments[1])
  else if arguments.length is 1
    @transform('translate', arguments[0])

$.fn.translate3d = ->
  if arguments.length is 3
    @transform('translate3d', arguments[0], arguments[1], arguments[2])
  else if arguments.length is 2
    @transform('translate3d', arguments[0], arguments[1])
  else if arguments.length is 1
    @transform('translate3d', arguments[0])

# TODO matrix, rotate, scale, skew