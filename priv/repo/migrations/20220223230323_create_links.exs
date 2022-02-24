defmodule Lyhyt.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add(:slug, :text, null: false)
      add(:href, :text, null: false)

      timestamps()
    end

    create index(:links, :slug, unique: true)
  end
end
