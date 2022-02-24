defmodule Lyhyt.Web.Handler do
  @moduledoc false

  @behaviour Aino.Handler

  import Aino.Middleware.Routes, only: [routes: 1, get: 3, post: 3]

  routes([
    get("/", &Lyhyt.Web.Pages.index/1, as: :root),
    get("/:slug/preview", &Lyhyt.Web.Links.preview/1, as: :preview),
    post("/links", &Lyhyt.Web.Links.create/1, as: :links),
    get("/:slug", &Lyhyt.Web.Links.show/1, as: :link)
  ])

  @impl true
  def handle(token) do
    middleware = [
      Aino.Middleware.common(),
      &Aino.Middleware.assets/1,
      &Aino.Middleware.Development.recompile/1,
      &Aino.Session.config(&1, %Aino.Session.Cookie{key: "key", salt: "salt"}),
      &Aino.Session.decode/1,
      &Aino.Session.Flash.load/1,
      &Aino.Middleware.Routes.routes(&1, routes()),
      &Aino.Middleware.Routes.match_route/1,
      &Aino.Middleware.params/1,
      &Aino.Middleware.Routes.handle_route/1,
      &Lyhyt.Web.Layout.wrap/1,
      &Aino.Session.encode/1,
      &Aino.Middleware.logging/1
    ]

    Aino.Token.reduce(token, middleware)
  end
end
