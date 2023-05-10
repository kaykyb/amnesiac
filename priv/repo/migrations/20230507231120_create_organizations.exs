defmodule Amnesiac.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  import Ecto.Query

  def change do
    create table(:organizations) do
      add :name, :string, null: false

      timestamps()
    end

    # Add organizations
    alter table(:users) do
      add :organization_id, references(:organizations, type: :binary_id, on_delete: :delete_all)
    end

    execute &migrate_existing_users/0
  end

  defp migrate_existing_users() do
    flush()

    all_users_query =
      from(u in "users",
        select: %{
          user_id: u.id
        }
      )

    repo().all(all_users_query)
    |> Enum.each(fn %{user_id: user_id} ->
      {1, [%{id: org_id}]} =
        repo().insert_all(
          "organizations",
          [%{name: "Default", inserted_at: DateTime.utc_now(), updated_at: DateTime.utc_now()}],
          returning: [:id]
        )

      repo().update_all(from(u in "users", where: [id: ^user_id]), set: [organization_id: org_id])
    end)
  end
end
