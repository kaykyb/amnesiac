defmodule Amnesiac.Repo do
  use Ecto.Repo,
    otp_app: :amnesiac,
    adapter: Ecto.Adapters.Postgres
end
