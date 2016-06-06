$(document).ready(function(){
  $('.sorted-projects').hide();
  $('#recent').show();
  $('.project-sort-button').on("click", function(e){
    clicked = $(e.target.parentElement).attr('class')
    $('.sorted-projects').hide();
    $(clicked).show();
  })
  $('#search-form').on("submit", function(e){
    e.preventDefault();
    $.ajax({
      url: '/search',
      data: $('#search-field').serialize(),
      method: 'POST'
    }).done(function(response){
      $('.sorted-projects').hide();
      $('.sorted-projects-list').append(response);
    })
  })

})
