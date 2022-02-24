defmodule Lyhyt.Web.Pages do
  @moduledoc false

  alias Aino.Token

  alias Lyhyt.Web.PagesView

  def index(token) do
    token
    |> Token.response_status(200)
    |> Token.response_header("Content-Type", "text/html")
    |> PagesView.render("index.html")
  end
end

defmodule Lyhyt.Web.PagesView do
  require Aino.View

  alias Lyhyt.Web.Handler.Routes

  Aino.View.compile([
    "lib/lyhyt/web/templates/pages/index.html.eex"
  ])
end
