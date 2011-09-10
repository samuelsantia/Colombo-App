# Login header box
$ ->
  $loginBox = $('#login-box')
  $loginButton = $('#login-button')
  closed = true
  height = $loginBox.find('.wrap').outerHeight()
  
  close = (ev) ->
    $loginBox.animate top: -height, 400
    $loginButton.toggleClass "active"
    closed = not closed
  
  open = (ev) ->
    $loginBox.animate top: 0, 400
    $loginButton.toggleClass "active"
    closed = not closed
  
  clickHandler = (ev) ->
    if closed then open(ev) else close(ev)
    false
    
  $loginButton.bind 'click', clickHandler
  
  false