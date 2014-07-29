
var seconds = function(date) {
  new Date(date).getTime() / 1000;
}

var Comment = {
  updateComments: function(){
    var latestCommentTime = {time: $(".comment li:last-child").attr("data-time")};
    $.ajax({
      url: "/retrieve_comments",
      method: "GET",
      data: latestCommentTime
    }).success(function(response){
      console.log("Successfully Got response (Comments)");
      for (var i=0; i < response.content.length; i++) {
        var time = response.content[i].obj.created_at;
        var time_in_seconds = seconds(time);
        if($(".comment li").size() >= 5) {
          $(".comment li:first-child").slideUp("slow").remove();
        }
        $('.comment').append('<li data-time="'+ time_in_seconds +'">' + response.content[i].obj.content + response.content[i].name + '</li>').fadeIn();
      };
    }).fail(function(response){
      console.log("No Comments yet");
    });
  },

  updateQueue: function(){
    $.ajax({
      url: "/retrieve_queue",
      method: "GET"
    }).success(function(response){
      console.log("Successfully Got response (queue");
      for (var i=0; i < response.queue.length; i++) {
        var comment = '<li>' + response.queue[i].name + '</li>';
        if ($('.queue li:contains("'+ response.queue[i].name +'")').length < 1) {
          $('.queue').append(comment);
        }
      }
    }).fail(function(response){
      console.log("FAILED updateQueue");
    });
  }
};

var _runPolling = function() {
  setTimeout(function(){
    console.log("polling");
    Comment.updateComments();
    Comment.updateQueue(); 
    _runPolling();
  }, 1000);
};

$(document).ready(function(){
  _runPolling();
  // setTimeout(Comment.updateComments, 5000);
  // setTimeout(Comment.updateQueue(), 5000);
});
