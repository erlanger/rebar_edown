-module(rebar_edown).

-export([edown/2, edoc/2, clean/2]).

%% @doc Generate edown program documentation.
%%      This function uses uwiger/edown doclet to generate
%%      github compatible documentation. It also adds an
%%      edoc macro `vsn' that will be replaced by the Version
%%      Control System application version in the documentation.
%%      For example, in your overview.edoc you can put
%%
%%      @version {@vsn} 
%%
%%      and it will be replaced into something like:
%%
%%      Version: 1.0-3-gbb3   
%%      
%% @end
edown(Config, AppFile) ->
   do_edoc(Config, AppFile, edown_doclet).

edoc(Config, AppFile) ->
   do_edoc(Config, AppFile, edoc_doclet).

%% @doc Remove the generated Erlang program documentation.
%% @end
clean(Config, _AppFile) ->
   EDocOpts = rebar_config:get(Config, edoc_opts, []),
   DocDir = proplists:get_value(dir, EDocOpts, "doc"),
   rebar_file_utils:rm_rf(DocDir).

%%--------------------------------------------------------------------------- 
%% Internal functions
%%--------------------------------------------------------------------------- 
do_edoc(Config, AppFile, Doclet) ->
   {_NewConfig, AppName} = rebar_app_utils:app_name(Config,AppFile),
   EDocOpts = rebar_config:get(Config, edoc_opts, []),
   EDocOpts1= lists:keystore(doclet, 1, EDocOpts, {doclet, Doclet}),
   {_,VSN} = rebar_app_utils:app_vsn(Config,AppFile),
   EDocOpts2= lists:keystore(def, 1, EDocOpts1, {def, {vsn, VSN }}),
   rebar_log:log(info,"~p: vsn macro set to ~p, use {@vsn} in your documentation ~n",
                 [Doclet,VSN]),
   ok = edoc:application(AppName, ".", EDocOpts2),
   ok.

