# rebar plugin for edown #

### A smile ###
Notice erlang.mk in the root dir :)

## What you get ##

1. A `vsn` macro for the documentation (with the versioning information from
   git or any other VCS). You can use {@vsn} in your `overview.edoc` -- for
   example --, and it will be replaced with the VCS versioning information.
   Until now I was making a rebar.config.script only to define this macro.

2. The ability to run *both* edoc and edown. This is not very easy to do
   without this plugin. With it, you can just run `rebar edown edoc` and
   both are built for you (they co-exist in the same doc directory).

3. Uncluttered dependencies. You don't have to add neither edown, or
   rebar_edown to your dependencies, they are downloaded automatically
   _only_ if you are building the docs with `rebar edown` or `rebar edoc`.

#### Why would you want both edown and edoc? ####
   The edown docs are nice on github, but the erlang docs are great for local
   browsing. Both of them can be built in the same doc directory. Now I just
   run `rebar get-deps co edoc edown` and get the best of both worlds.

## How to use ##
1. Copy the scripts in priv/\*.script into your priv directory
2. Copy priv/rebar.config.script to the main directory of you app.

Run:
```sh
rebar get-deps co edown edoc
```

and you'll get all the documentation built both in edoc and edown.

## Behind the scenes ##

rebar_edown wants to be unobtrusive, reducing the number of unnecessary
depenencies for your app. People don't have to get edown or rebar_edown
if you are not going to build the docs. The author of edown had already
done most of the work, I just built a rebar plugin to make things easier.

Behind the scenes rebar_edown does the following:
1. Automatically add dependencies for edown and rebar_edown *only* if you run
   `rebar doc` or `rebar edown`. So if you don't have the dependencies you just
   run `rebar get-deps co edown` and everything will be added and downloaded
   automatically.

2. Automatically add the rebar_edown plugin to your rebar.config *only* if you
   run `rebar edoc` or `rebar edown`.

3. Automatically add a {def, {vsn, VCS_VERSION}} option to your edoc_opts
   tuple, so that you automatically have the VCS version number available for
   your documentation much like it is already available for your `app.src`
   files already. I don't know why rebar doesn't provide this.
