defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

# mix.exsのmodの値がそのまま引数に
  def start(_type, args) do
      {:ok, _pid} = Sequence.Supervisor.start_link(args)
  end
end
