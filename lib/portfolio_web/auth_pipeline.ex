defmodule Portfolio.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Portfolio,
  module: Portfolio.Guardian,
  error_handler: Portfolio.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
