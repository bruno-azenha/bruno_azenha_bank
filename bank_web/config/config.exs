# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :bank_web, BankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SNJ41Ccskae8Cw077QzgrRNCVUZlpv4got+bcTgfYw1DwucPV5qnEVz2AaUA2u5S",
  render_errors: [view: BankWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BankWeb.PubSub,
  live_view: [signing_salt: "ioIQwCbK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
