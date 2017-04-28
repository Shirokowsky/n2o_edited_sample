-module(posts).
-export([get/0, get/1]).

-include("records.hrl").

get() -> [
  #post{id=1, title="first post", text="interesting text"},
  #post{id=2, text="not interesting text"},
  #post{id=3, title="third post"}
         ].

get(Id) ->
  lists:keyfind(Id, #post.id, ?MODULE:get()).
