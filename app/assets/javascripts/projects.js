$(document).ready(function(){
  $('#recent').show();
  $('.project-sort-button').on("click", function(e){
    clicked = $(e.target.parentElement).attr('class')
    $('.sorted-projects').hide();
    $('#new-project-link').show();
    $('#new-project-div').remove();
    $(clicked).show();
  })
  $('#new-project-link').on("click", function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-project-link').hide();
      $('.sorted-projects-list').prepend(response);
      $('.sorted-projects').hide();
    })
  })
  $('.sorted-projects-list').on("submit", "#new_project", function(e){
    e.preventDefault();
    $.ajax({
      url: '/projects',
      method: 'POST',
      data: $(e.target).serialize()
    }).done(function(response){
      $('#new-project-div').remove();
      if (!response.includes("form")){
        $('#new-project-link').show();
        $('#recent-projects').prepend(response);
        $('.sorted-projects').show();
      } else {
        $('.sorted-projects-list').prepend(response);
        $('.sorted-projects').hide();
      }
    })
  })
  $('#search-form').on("submit", function(e){
    e.preventDefault();
    $.ajax({
      url: '/search',
      data: $('#search-field').serialize(),
      method: 'POST'
    }).done(function(response){
      $('#new-project-link').show();
      $('#new-project-div').remove();
      $('.sorted-projects').hide();
      $('.sorted-projects-list').append(response);
    })
  })
  $('')

})
