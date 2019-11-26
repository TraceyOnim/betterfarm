defmodule BetterfarmWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use BetterfarmWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
