%%%-----------------------------------------------------------------------------
%%% Use is subject to License terms.
%%% @copyright (C) 2012 FlowForwarding.org
%%% @doc Callback module for OpenFlow Logical Switch application.
%%% @end
%%%-----------------------------------------------------------------------------
-module(linc).
-author("Erlang Solutions Ltd. <openflow@erlang-solutions.com>").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%%-----------------------------------------------------------------------------
%%% Application callbacks
%%%-----------------------------------------------------------------------------

%% @doc Start the application.
-spec start(any(), any()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    case application:get_env(linc, of_config) of
        {ok, enabled} ->
            ok = application:start(ssh),
            ok = application:start(enetconf);
        _ ->
            ok
    end,
    linc_sup:start_link().

%% @doc Stop the application
-spec stop(any()) -> ok.
stop(_State) ->
    case application:get_env(linc, of_config) of
        {ok, enabled} ->
            ok = application:stop(enetconf),
            ok = application:stop(ssh);
        _ ->
            ok
    end.