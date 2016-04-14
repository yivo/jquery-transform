((factory) ->

  # Browser and WebWorker
  root = if typeof self is 'object' and self isnt null and self.self is self
    self

  # Server
  else if typeof global is 'object' and global isnt null and global.global is global
    global

  # AMD
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery', 'exports'], ($) ->
      factory(root, $)

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    factory(root, require('jquery'))

  # Browser and the rest
  else
    factory(root, root.$)

  # No return value
  return

)((__root__, $) ->
  $.fn.transform = (transformation, x, y) ->
    switch arguments.length
      when 2
        value = if $.isNumeric(x)
          "#{transformation}(#{x}px)"
        else if x
          "#{transformation}(#{x})"
        else
          ''
      when 3
        value = "#{transformation}("
        value += if $.isNumeric(x) then "#{x}px, " else "#{x or ''}, "
        value += if $.isNumeric(y) then "#{y}px"   else (y or '')
        value += ')'
  
    @css(
      '-moz-transform':    value
      '-ms-transform':     value
      '-webkit-transform': value
      'transform':         value
    ) if value?
    this
  
  $.fn.translate = ->
    args = ['translate']
    args.push(arguments[0]) if arguments.length > 0
    args.push(arguments[1]) if arguments.length > 1
    @transform.apply(this, args)
  
  # TODO matrix, rotate, scale, skew
  
  # No global variable export
  return
)