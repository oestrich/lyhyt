defmodule Lyhyt.Web.Layout do
  @moduledoc false

  alias Aino.Session
  alias Lyhyt.Web.Handler.Routes

  require Aino.View

  Aino.View.compile([
    "lib/lyhyt/web/templates/layout/app.html.eex"
  ])

  def wrap(token) do
    assigns = Map.take(token, [])
    assigns = Map.put(assigns, :inner_content, {:safe, token.response_body})
    render(token, "app.html", assigns)
  end
end
