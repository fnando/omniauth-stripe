# frozen_string_literal: true

require "test_helper"

class DataTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Stripe.new(app, "client_id", "client_secret")
  end

  test "returns callback url" do
    strategy.stubs(:full_host).returns("https://example.com")
    strategy.stubs(:script_name).returns("/script_name")
    strategy.stubs(:callback_path).returns("/callback_path")

    assert_equal "https://example.com/script_name/callback_path",
                 strategy.callback_url
  end

  test "returns raw info" do
    payload = {"id" => "ID"}
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/v1/account").returns(response)
    strategy.stubs(:access_token).returns(access_token)

    assert_equal Hash[:id, "ID"], strategy.raw_info
  end

  test "returns info" do
    strategy
      .stubs(:raw_info)
      .returns(object: "OBJECT", display_name: "NAME", email: "EMAIL")

    info = strategy.info

    assert_equal "EMAIL", info[:email]
    assert_equal "NAME", info[:name]
  end

  test "returns uid" do
    strategy.stubs(:access_token).returns("stripe_user_id" => "ID")
    assert_equal "ID", strategy.uid
  end

  test "returns extra info" do
    extra_info = {extra_info: "EXTRA_INFO"}
    raw_info = {
      extra_info: "EXTRA_INFO",
      email: "EMAIL",
      display_name: "DISPLAY_NAME",
      id: "ID"
    }

    strategy.stubs(:raw_info).returns(raw_info)

    assert_equal extra_info, strategy.extra
  end
end
