defmodule ExZoomInfo.Api do
  @moduledoc """
  Simple API wrapper for ZoomInfo
  """
  use HTTPoison.Base
  alias __MODULE__
  alias ExZoomInfo.Parser

  @base_url "https://partnerapi.zoominfo.com/partnerapi"
  @defaults %{OutputType: "json"}
  # @query_type ["match", "search", "detail", "query"]
  @supported_object ["person", "company", "usage"]
  @user_agent [{"User-agent", "ExZoominfo"}]
  @content_type [{"Content-Type", "application/json"}]
  @accept [{"Accept", "applicationjson"}]

  @doc """
  Search zoominfo using partner api

  ## Examples

      alias ExZoomInfo.Api, as: ZoomInfo
      ZoomInfo.search(%{"companyName" => "zoominfo", "state" => "Massachusetts"}, [type: "search", object: "company"])
  """
  @spec search(map, String.t()) :: {:ok, binary} | {:error, binary}
  def search(params, opts \\ [])

  def search(params, opts) when is_map(params) and map_size(params) > 0 do
    object = if opts[:object] in @supported_object, do: opts[:object], else: "person"
    type = opts[:type] || "search"

    params
    |> Map.merge(%{pc: config()[:partner_code], key: hashkey(params)})
    |> Map.merge(@defaults)
    |> build_url(object, type)
    |> Api.get(request_headers())
    |> Parser.parse()
  end

  def search(_, _), do: {:error, "invalid request"}

  @spec build_url(map, String.t(), String.t()) :: String.t()
  def build_url(params, object, type) do
    "#{@base_url}/#{object}/#{type}?#{URI.encode_query(params)}"
  end

  @spec process_response_body(binary) :: term
  def process_response_body(body) do
    body
  end

  defp hashkey(params) when map_size(params) > 0 do
    prefix =
      params
      |> Enum.reduce("", fn {_k, v}, acc ->
        acc <> String.slice(v, 0, 2)
      end)

    {y, m, d} = :erlang.date()

    :md5
    |> :crypto.hash("#{prefix}#{config()[:partner_password]}#{d}#{m}#{y}")
    |> Base.encode16()
    |> String.downcase()
  end

  defp request_headers, do: @user_agent ++ @content_type ++ @accept
  defp config, do: Application.get_env(:ex_zoominfo, :api)
end
