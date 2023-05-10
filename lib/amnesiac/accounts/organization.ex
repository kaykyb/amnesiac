defmodule Amnesiac.Accounts.Organization do
  use Amnesiac.Schema

  import Ecto.Changeset

  alias Amnesiac.Accounts.User

  schema "organizations" do
    field :name, :string

    has_many :users, User

    timestamps()
  end

  def new_organization_changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
