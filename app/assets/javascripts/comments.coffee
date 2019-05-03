# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.comments = App.cable.subscriptions.create "CommentsChannel",
connected: ->
  
disconnected: ->

received: (data) ->
  $("#messages .comment-fix:first").prepend(data) # messages is the id 
  $("#no_comments").hide()
