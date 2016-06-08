$(document).ready(function(){
  $('.sorted-projects').hide();
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
  $('.project-box').on("click", ".favorite-button a", function(e){
    e.preventDefault();
    clicked = e.target.parentElement.parentElement
    $.ajax({
      url: $(e.target.parentElement).attr('href'),
      method: "POST"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.project-box').on("click", ".unfavorite-button a", function(e){
    e.preventDefault();
    clicked = e.target.parentElement.parentElement
    $.ajax({
      url: $(e.target.parentElement).attr('href'),
      method: "DELETE"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.categories').on("click", "a", function(e){
    selected = $(e.target);
    $('.highlight').css("color", "#8E8F91").removeClass('highlight');
    selected.css("color", "#FF8A7A").addClass('highlight');

  })
})
  $('.project-box').on("click", "#report-button a", function(e){
    e.preventDefault();
    clicked = e.target
    $.ajax({
      url: $(e.target).attr('href'),
      method: "POST"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.project-box').on("click", "#unreport-button a", function(e){
    e.preventDefault();
    clicked = e.target
    $.ajax({
      url: $(e.target).attr('href'),
      method: "DELETE"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })



