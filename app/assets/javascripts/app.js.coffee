window.App = (->
  init = ->
    $.ajaxSetup
      cache: true
    $.getScript '//connect.facebook.net/en_UK/all.js', ->
      FB.init
        appId: '664103826970623',
        xfbml: true,
        version: 'v2.0'

    $('.ui.dropdown').dropdown()
    $('.timeago').timeago()
    $('#post').click(share)

  share = ->
    window.inputs = {}
    window.inputs.learn = $('#learn').val()
    window.inputs.teach = $('#teach').val()
    window.inputs.where = $('#where').val() || 'Vilniuje'

    fields_missing = _.any window.inputs, (val, key) ->
      _.isEmpty(val)

    if fields_missing
      alert('Pasakyk, ką nori išmokti')
    else
      FB.login(post, { scope: 'user_about_me,publish_actions' })

  post = ->
    main_text = 'Pamokysiu tave ' + inputs.teach + ', jei tu pamokysi mane ' + inputs.learn + ' ' + inputs.where

    post_data = {
      name: main_text,
      message: main_text,
      description: main_text,
      link: 'http://pamokyk.lt',
      picture: "http://www.domasbitvinskas.com/images/success-is-consistency.png",
      icon: 'https://www.namecheap.com/favicon.ico'
    }

    FB.api('/me/feed', 'post', post_data, afterPost)

  afterPost = (post_id) ->
    FB.api('/me', getData)

  getData = (resp) ->
    $.getJSON('/save',
      resp: resp,
      inputs: inputs
    ).then (success) ->
      location.reload()

  return {
    init: init,
    share: share
  })()

$(document).ready ->
  App.init()
