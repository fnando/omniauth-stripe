# frozen_string_literal: true

require "test_helper"

class ClientOptionsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Stripe.new(app, "client_id", "client_secret")
  end

  test "sets name" do
    assert_equal "stripe", strategy.options.name
  end

  test "sets site" do
    assert_equal "https://api.stripe.com",
                 strategy.options.client_options.site
  end

  test "sets authorize url" do
    assert_equal "https://connect.stripe.com/oauth/authorize",
                 strategy.options.client_options.authorize_url
  end

  test "sets token url" do
    assert_equal "https://connect.stripe.com/oauth/token",
                 strategy.options.client_options.token_url
  end

  test "sets default scope" do
    strategy.stubs(:session).returns({})
    assert_equal "read_only", strategy.authorize_params.scope
  end
end
