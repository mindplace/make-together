$(document).ready(function(){
  $('.inbox').on("click", "a", function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#inbox-div').empty();
      $('#inbox-div').append(response);
    })
  })
  $('.whole-inbox-page').on("submit", "#message-form", function(e){
    e.preventDefault();
    $.ajax({
      url: e.target.action,
      method: 'post',
      data: $(e.target).serialize()
    }).done(function(response){
      $('#messages-box').append(response);
      $(".body-input").val("");
    })
  })
})