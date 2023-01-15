defmodule Portfolio.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Portfolio.Users.User
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @derive {Jason.Encoder, only: [:name, :email, :user_name, :active, :role]}
  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :name, :string
    field :password, :string
    field :role, :string
    field :user_name, :string

    # Virtual fields:
    field :password_virtual, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :user_name, :email, :active, :role, :password_virtual, :password_confirmation])
    |> validate_required([:name, :user_name, :email, :active, :role, :password_virtual, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_virtual, min: 8)
    |> validate_confirmation(:password_virtual)
    |> unique_constraint([:email, :user_name])
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_virtual: pass}}
        ->
          put_change(changeset, :password, hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
