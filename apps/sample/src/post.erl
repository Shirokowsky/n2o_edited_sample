-module(post).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include_lib("records.hrl").

main() ->
  {Id, _} = string:to_integer(binary_to_list(wf:q(<<"id">>))),
  Post = posts:get(Id),
  wf:info("Message: ~p ~p", [Post#post.title]),
  #dtl{ file="post", bindings=[{title, Post#post.title}, {text, Post#post.text}] }.

