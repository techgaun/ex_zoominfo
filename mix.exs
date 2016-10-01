defmodule ExZoomInfo.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_zoominfo,
     version: "0.1.0",
     elixir: "~> 1.2",
     description: "Elixir SDK for ZoomInfo Partner API",
     source_url: "https://github.com/techgaun/ex_zoominfo",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [extras: ["README.md"]],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:dogma, "~> 0.1", only: [:dev, :test]}
    ]
  end

  defp package do
    [
      maintainers: [
        "Samar Acharya"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/techgaun/ex_zoominfo"}
    ]
  end
end
