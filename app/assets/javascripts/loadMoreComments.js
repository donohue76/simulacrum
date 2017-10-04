// wait for the document to be ready before running the code
$( document ).ready(function() {
  // Listen for a click on the .more-comments class (each of the 'view all x comments' links)
  $('.more-comments').click( function() {
    // Once the AJax call has been successfull, move on to the next lines
    $(this).on('ajax:success', function(event) {
      // Assign a postId variable based on the contents of the data-post-id html attribute (which we assigned in our post partial)
      var postId = $(this).data("post-id");
      // replace the #comments_ + postOd div with the contents of the returned AJAX data
      $("#comments_" + postId).html(event.detail[2].responseText);
      $("#comments-paginator-" + postId).html("<a id='more-comments' data-post-id=" + postId + "data-type='html' data-remote='true' href='/posts/" + postId + "/comments>show more comments</a>");
    });
  });
});
