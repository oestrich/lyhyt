defmodule Lyhyt.Links.Link do
  @moduledoc """
  Schema for a link
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "links" do
    field(:slug, :string)
    field(:href, :string)

    timestamps()
  end

  def create_changeset(struct, params) do
    struct
    |> cast(params, [:href])
    |> validate_required([:href])
    |> validate_format(:href, ~r/https?:\/\/\w+\.\w+\/?/)
    |> put_change(:slug, generate_slug())
    |> unique_constraint(:slug)
  end

  defp generate_slug() do
    Base.url_encode64(:crypto.strong_rand_bytes(6))
  end
end

defmodule Lyhyt.Links do
  @moduledoc """
  Context module for creating and looking up links
  """

  alias Lyhyt.Links.Link
  alias Lyhyt.Repo

  def create(params) do
    %Link{}
    |> Link.create_changeset(params)
    |> Repo.insert()
  end

  def get(slug) do
    case Repo.get_by(Link, slug: slug) do
      nil ->
        {:error, :not_found}

      link ->
        {:ok, link}
    end
  end
end
