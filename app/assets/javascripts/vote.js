
var styleAsUpvote = function(target) {
    target.addClass("btn-primary")
    target.closest("div").find(".btn-downvote").removeClass("btn-primary")
}

var styleAsDownvote = function(target) {
    target.addClass("btn-primary")
    target.closest("div").find(".btn-upvote").removeClass("btn-primary")
}

var updateStaticValue = function (target, vote_value) {
    var value = $(target.parent().closest("tr").find('td')[0])
    var index = target.parent().data("post-value")
    value.text(staticValues[index] + vote_value)
    console.log("hey", value, target.parent().data("post-value"))
}

var serverVoteRequest = function(vote_object, success_function) {
    var current_post = vote_object.parent().data("post-value")
    var vote_value = vote_object.data("vote-value")

    $.ajax({
        url:        "/votes.json",
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
        console.log(vote)
        switch (vote) {
        case 1:
            console.log("something")
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
