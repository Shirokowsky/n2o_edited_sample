-module(index).
-compile(export_all).

-include_lib("n2o/include/wf.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("records.hrl").

peer()    -> wf:to_list(wf:peer(?REQ)).
message() -> wf:js_escape(wf:html_encode(wf:to_list(wf:q(message)))).

main() ->
  #dtl{ file="index", bindings=[
                                {posts, posts()}, {num,num()}, {body,body()}]}.

body() ->
  [#panel{id=history},
  #textbox{id=message, class=["c-text-field"]},
  #button{id=send,class=["c-button"],body="Chat",postback=chat,source=[message]},
  #textbox{id=message2,class=['c-text-field']},
  #button{id=send2,class=['c-button'],postback=button_pressed,body="Console", source=[message2]}
  ].

title() ->
  "I am title".

event(init) ->
  wf:reg(room);
event(chat) ->
  wf:info(?MODULE,"Message: ~p", [wf:q(message)]),
  wf:send(room,{client,{peer(),message()}});
event({client,{P,M}}) ->
  wf:insert_bottom(history,#panel{id=history,body=[P,": ",M,#br{}]});
event(button_pressed) ->
  Message = wf:q(message2),
  wf:info(?MODULE,"Message 2: ~p", [Message]);
event(Event) ->
  wf:info(?MODULE,"Unknown Event: ~p~n",[Event]).

posts() -> [
            #panel{body=[
            #h2{body=#link{body=P#post.title,url="/post?id="++wf:to_list(P#post.id)}},
            #p{body=P#post.text}
             ]} || P <- posts:get()].

num() -> 2 + 8.
