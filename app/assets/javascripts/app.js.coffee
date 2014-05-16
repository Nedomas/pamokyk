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
    $('#post').click(share)

  share = ->
    FB.login(->
      FB.api '/me/feed', 'post',
        message: 'Hello, world!',
        access_token: 'CAACEdEose0cBAPUOfbfRZBvQJ4jphYLtPa4zc63bMNZBP4Od8eKQWoPJ07XPZCbbsb6GVKxk1c3xgDeXBSI91LhzufP1goR8VP738arqWaQbVL0hwSAXU5QPe40xUECgSIVfocLB6gGpC1ZCRrjOQakmV3C3JGS5VkwtintWwoa7YRP9xqOPo9ZA9l7J0XoYZD'
    ,
      scope: 'publish_actions'
    )
    # FB.ui(
    #   method: 'feed',
    #   name: 'The Facebook SDK for Javascript',
    #   caption: 'Bringing Facebook to the desktop and mobile web',
    #   description: 'Shit',
    #   link: 'https://developers.facebook.com/docs/reference/javascript/',
    #   picture: 'http://www.fbrell.com/public/f8.jpg'
    # # method: 'share',
    # # href: 'https://developers.facebook.com/docs/',
    # , (response) ->
    #   console.log(response)
    #   debugger
    #   # if response && response.post_id
    #   #   alert('Post was published.')
    #   # else
    #   #   alert('Post was not published.')
    # )

  return {
    init: init,
    share: share
  })()

$(document).ready ->
  App.init()
