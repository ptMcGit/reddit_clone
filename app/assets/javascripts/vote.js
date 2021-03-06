
var styleAsUpvote = function(target) {
    target.addClass("btn-primary")
    target.closest("div").find(".btn-downvote").removeClass("btn-primary")
}

var styleAsDownvote = function(target) {
    target.addClass("btn-primary")
    target.closest("div").find(".btn-upvote").removeClass("btn-primary")
}

var updateStaticValue = function (target, vote_value) {

    var current_vote_value = target.parent().data("static-vote-value")
    var value_field = $(target.parent().closest("tr").find('td')[0])
    var value = Number( value_field.text() )


    // subtract out the user's previous vote if there
    value -= (current_vote_value == 0) ? 0: current_vote_value;

    // update the user's vote value
    target.parent().data("static-vote-value", vote_value)
    var index = target.parent().data("post-value")

    // update the sum
    value_field.text(value + vote_value)
}

var serverVoteRequest = function(vote_object, success_function) {
    var current_post = vote_object.parent().data("post-value")
    var vote_value = vote_object.data("vote-value")
    var current_vote_value = vote_object.parent().data("static-vote-value")

    console.log(current_vote_value, vote_value)
    if (current_vote_value == vote_value) { return }

    $.ajax({
        url:        "/posts/" + current_post + "/votes.json",
        method:     "POST",
        data: {
            post_id:
            current_post,
            value: vote_value
        },
        success: (function () {
            success_function(vote_object)
            updateStaticValue(vote_object, vote_value)
        }),
        error:      function() { alert("request errored") }
    })
}

var staticValues = []

var styleForStartingVoteValues = function() {
    var voteBoxes = $(".vote-box")

    for (i = 0; i < voteBoxes.length; i++) {
        var vote    = $(voteBoxes[i]).data('static-vote-value')
        var post_id = $(voteBoxes[i]).data('post-value')
        staticValues[post_id] = vote

        switch (vote) {
        case 1:
            styleAsUpvote($(voteBoxes[i]).closest("div").find(".btn-upvote"))
            break
        case -1:
            styleAsDownvote($(voteBoxes[i]).closest("div").find(".btn-downvote"))
            break
        default:
            staticValues[post_id] = 0
        }
    }

}


$(document).ready(function() {
    styleForStartingVoteValues()
    $(".btn-upvote").click(function(e) {
        e.preventDefault()
        serverVoteRequest($(this), styleAsUpvote)
    })
    $(".btn-downvote").click(function(e) {
        e.preventDefault()
        serverVoteRequest($(this), styleAsDownvote)
    })
})
