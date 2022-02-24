defmodule Lyhyt.Web.Links do
  @moduledoc false

  alias Aino.Token
  alias Aino.Session
  alias Lyhyt.Links
  alias Lyhyt.Web.Handler.Routes
  alias Lyhyt.Web.LinksView

  def create(token) do
    case Links.create(token.params) do
      {:ok, link} ->
        token
        |> Session.Flash.put(:info, "Shortened!")
        |> Token.Response.redirect(Routes.preview_url(token, slug: link.slug))

      {:error, _changeset} ->
        token
        |> Session.Flash.put(:error, "Could not shorten, did you enter a URL?")
        |> Token.Response.redirect(Routes.root_url(token))
    end
  end

  def preview(%{params: %{"slug" => slug}} = token) do
    case Links.get(slug) do
      {:ok, link} ->
        token
        |> Token.response_header("Content-Type", "text/html")
        |> Token.response_status(200)
        |> LinksView.render("preview.html", %{link: link})

      {:error, :not_found} ->
        token
        |> Session.Flash.put(:error, "Could not find this link")
        |> Token.Response.redirect(Routes.root_url(token))
    end
  end

  def show(%{params: %{"slug" => slug}} = token) do
    case Links.get(slug) do
      {:ok, link} ->
        Token.Response.redirect(token, link.href)

      {:error, :not_found} ->
        token
        |> Session.Flash.put(:error, "Could not find this link")
        |> Token.Response.redirect(Routes.root_url(token))
    end
  end
end

defmodule Lyhyt.Web.LinksView do
  require Aino.View

  alias Lyhyt.Web.Handler.Routes

  Aino.View.compile([
    "lib/lyhyt/web/templates/links/preview.html.eex"
  ])
end
