use Mix.Config

config :ex_zoominfo, :api,
  partner_password: System.get_env("ZOOMINFO_PASSWORD"),
  partner_code: System.get_env("ZOOMINFO_CODE")
