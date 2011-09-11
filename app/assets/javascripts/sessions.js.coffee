# Login header box
$ ->
  # Vars
  $loginBox = $('#user-box')
  $loginButton = $('#user-button')
  closed = true
  height = $loginBox.find('.wrap').outerHeight()
  
  # Methods
  close = (ev) ->
    $loginBox.animate top: -height, 400
    $loginButton.toggleClass "active"
    closed = not closed
  
  open = (ev) ->
    $loginBox.animate top: 0, 400
    $loginButton.toggleClass "active"
    closed = not closed
  
  # Events handlers
  clickHandler = (ev) ->
    if closed then open(ev) else close(ev)
    false
    
  clickWHandler = (ev) ->
    if not closed and not ($(ev.target).parents('#user-box').length > 0)
      close()
  
  # Events
  $loginButton.bind 'click', clickHandler
  $(window).bind 'click', clickWHandler
  
  false