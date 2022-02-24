defmodule Lyhyt.Web.LinksTest do
  use Lyhyt.DataCase

  alias Aino.Token
  alias Lyhyt.Web.Links

  describe "creating a new slug" do
    test "success: redirects to the preview" do
      token =
        create_token()
        |> Map.put(:params, %{"href" => "https://ainoweb.dev/"})
        |> Links.create()

      assert token.response_status == 302
      [location] = Token.response_header(token, "Location")
      assert location =~ ~r/preview$/
    end

    test "failure: redirects to the root" do
      token =
        create_token()
        |> Map.put(:params, %{"href" => "httpsainoweb.dev/"})
        |> Links.create()

      assert token.response_status == 302
      [location] = Token.response_header(token, "Location")
      assert location == "http://example.com:8080/"
    end
  end

  describe "previewing a link" do
    test "success: viewing the preview page" do
      {:ok, link} = Lyhyt.Links.create(%{href: "https://ainoweb.dev/"})

      token =
        create_token()
        |> Map.put(:params, %{"slug" => link.slug})
        |> Links.preview()

      assert token.response_status == 200
    end

    test "failure: slug not found" do
      token =
        create_token()
        |> Map.put(:params, %{"slug" => "unknown"})
        |> Links.preview()

      assert token.response_status == 302
    end
  end

  describe "visint a link" do
    test "success: redirected to the href" do
      {:ok, link} = Lyhyt.Links.create(%{href: "https://ainoweb.dev/"})

      token =
        create_token()
        |> Map.put(:params, %{"slug" => link.slug})
        |> Links.show()

      assert token.response_status == 302
      [location] = Token.response_header(token, "Location")
      assert location == "https://ainoweb.dev/"
    end

    test "failure: slug not found" do
      token =
        create_token()
        |> Map.put(:params, %{"slug" => "unknown"})
        |> Links.show()

      assert token.response_status == 302
    end
  end

  defp create_token() do
    %{
      session: %{},
      scheme: "http",
      host: "example.com",
      port: "8080",
      default_assigns: %{},
      params: %{}
    }
  end
end
