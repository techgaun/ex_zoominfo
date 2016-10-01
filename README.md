# ExZoomInfo

[![Build Status](https://semaphoreci.com/api/v1/samaracharya/ex_zoominfo/branches/master/badge.svg)](https://semaphoreci.com/samaracharya/ex_zoominfo)


> ZoomInfo Client for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add `ex_zoominfo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_zoominfo, "~> 0.1.0"}]
end
```

Or from github:

```elixir
def deps do
  [{:ex_google, github: "techgaun/ex_zoominfo"}]
end
```

2. Ensure `ex_zoominfo` is started before your application:

```elixir
def application do
  [applications: [:ex_zoominfo]]
end
```

## Configuration

1. Configure `ex_zoominfo` by providing appropriate configurations as below:

```elixir
config :ex_zoominfo, :api,
  partner_password: System.get_env("ZOOMINFO_PASSWORD"),
  partner_code: System.get_env("ZOOMINFO_CODE")
```

## Usage

1. You can now use `ex_zoominfo` as below:

```elixir
alias ExZoomInfo.Api, as: ZoomInfo
ZoomInfo.search(%{"companyName" => "zoominfo", "state" => "Massachusetts"}, [type: "search", object: "company"])
```

Refer to the [ZoomInfo API Documentation](http://www.zoominfo.com/business/zoominfo-new-api-documentation) for more information on what arguments you can pass.

Supported object types are:
- `person`
- `company`
- `usage`

Supported query types are:
- `match`
- `search`
- `detail`
- `query`
