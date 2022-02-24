defmodule Lyhyt.LinksTest do
  use Lyhyt.DataCase

  alias Lyhyt.Links

  describe "creating a new link" do
    test "success: creates a slug" do
      {:ok, link} =
        Links.create(%{
          href: "https://ainoweb.dev/"
        })

      assert link.slug
    end

    test "failure: validates a realistic URL" do
      {:error, changeset} =
        Links.create(%{
          href: "httpainoweb.dev/"
        })

      assert changeset.errors[:href]
    end
  end
end
