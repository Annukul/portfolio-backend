defmodule Portfolio.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :user_name, :string
      add :email, :string
      add :password, :string
      add :active, :boolean, default: false, null: false
      add :role, :string

      timestamps()
    end
  end
end
