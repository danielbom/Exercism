# Returns the acronym of the given phrase.
#
# + phrase - a string
# + return - the acronym
function abbreviate(string phrase) returns string {
    var groups = re `^([a-zA-Z])|[\s\-_]([a-zA-Z])`.findAllGroups(phrase);
    var initials = from var g in groups
        let var first = g[1]
        where first !is ()
        select first.substring().toUpperAscii();
    return "".join(...initials);
}
