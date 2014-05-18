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
    message = 'Pamokysiu tave ' + inputs.teach + ', jei tu pamokysi mane ' + inputs.learn + ' ' + inputs.where
    name = 'Pamokyk ir išmok'
    description = 'Čia sąrašas žmonių, kurie nori tau padėti išmokti naudingų įgūdžų.'

    post_data = {
      message: message,
      name: name,
      description: description,
      link: 'http://www.pamokyk.lt',
      picture: 'http://www.pamokyk.lt/assets/pamokyk.png'
    }

    FB.api('/me/feed', 'post', post_data, afterPost)

  afterPost = (post_info) ->
    if !post_info.error
      FB.api('/me', save)

  save = (resp) ->
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
