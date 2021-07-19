function ValidateAnswer(obj) {
    var current = $(obj);
    var parent = current.parents(".rstquestion");
    if (current.val() == "correct") {
        parent.attr("class", "question alert alert-success");
    }
    else {
        parent.attr("class", "question alert alert-error");
    }
}