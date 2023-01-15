defmodule Portfolio.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :excerpt, :string
      add :content, :text
      add :likes, :integer
      add :dislikes, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
