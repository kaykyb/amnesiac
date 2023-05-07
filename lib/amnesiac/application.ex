defmodule Amnesiac.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AmnesiacWeb.Telemetry,
      # Start the Ecto repository
      Amnesiac.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Amnesiac.PubSub},
      # Start Finch
      {Finch, name: Amnesiac.Finch},
      # Start the Endpoint (http/https)
      AmnesiacWeb.Endpoint
      # Start a worker by calling: Amnesiac.Worker.start_link(arg)
      # {Amnesiac.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Amnesiac.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AmnesiacWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
