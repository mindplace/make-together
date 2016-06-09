var ready = function () {

    /**
     * When the send message link on our home page is clicked
     * send an ajax request to our rails app with the sender_id and
     * receiver_id
     */

    $('.start-conversation').click(function (e) {
        e.preventDefault();

        var sender_id = $(this).data('sid');
        var receiver_id = $(this).data('rip');
        var conversation_type = $(this).data('im');

        $.post("/conversations", { sender_id: sender_id, receiver_id: receiver_id, conversation_type: conversation_type }, function (data) {
            chatBox.chatWith(data.conversation_id);
        });
    });

    /**
     * Used to minimize the chatbox
     */

    $(document).on('click', '.toggleChatBox', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.toggleChatBoxGrowth(id);
    });

    /**
     * Used to close the chatbox
     */

    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.close(id);
    });


    /**
     * Listen on keypress' in our chat textarea and call the
     * chatInputKey in chat.js for inspection
     */

    $(document).on('keydown', '.chatboxtextarea', function (event) {

        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });

    /**
     * When a conversation link is clicked show up the respective
     * conversation chatbox
     */

    $('a.conversation').click(function (e) {
        e.preventDefault();

        var conversation_id = $(this).data('cid');
        chatBox.chatWith(conversation_id);
    });


}

$(document).ready(ready);
$(document).on("page:load", ready);

$(document).ready(function(){
  $('.user-sort-button').on("click", function(e){
    $('.active').addClass('hidden');
    $('.active').removeClass('active')
    clicked = $(e.target.parentElement).attr('class')
    $(clicked).removeClass('hidden');
    $(clicked).addClass('active');
  })
  $('.following-div').on("click", '.follow-button a', function(e){
    e.preventDefault();
    $.ajax({
        url: $(e.target).attr('href'),
        method: "POST"
    }).done(function(response){
        $(this).replaceWith(response);
    }.bind(this))
  })
  $('.following-div').on("click", '.unfollow-button a', function(e){
    e.preventDefault();
    $.ajax({
        url: $(e.target).attr('href'),
        method: "DELETE"
    }).done(function(response){
        $(this).replaceWith(response);
    }.bind(this))
  })
})