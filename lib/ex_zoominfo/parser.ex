defmodule ExZoomInfo.Parser do
  @moduledoc """
  Generic parser to parse all the zoominfo api responses
  """

  @type status_code :: integer
  @type response ::
          {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map} | any

  @doc """
  Parses the response
  """
  @spec parse(tuple) :: response
  def parse(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}}
      when status in [200, 201] ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 204}} ->
        :ok

      {:ok, %HTTPoison.Response{body: "", headers: _, status_code: status}} ->
        {:error, "empty response", status}

      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:ok, json} = Poison.decode!(body)
        {:error, json, status}

      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, %{reason: reason}}

      _ ->
        response
    end
  end
end
