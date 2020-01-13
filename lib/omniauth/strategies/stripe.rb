# frozen_string_literal: true

require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Stripe < OmniAuth::Strategies::OAuth2
      EXTRA_KEYS_EXCEPTION = %i[id email display_name].freeze

      option :client_options,
             site: "https://api.stripe.com",
             authorize_url: "https://connect.stripe.com/oauth/authorize",
             token_url: "https://connect.stripe.com/oauth/token"

      option :scope, "read_only"

      uid do
        access_token["stripe_user_id"]
      end

      info do
        {
          email: raw_info[:email],
          name: raw_info[:display_name]
        }
      end

      extra do
        raw_info.dup.delete_if {|key, _| EXTRA_KEYS_EXCEPTION.include?(key) }
      end

      def raw_info
        @raw_info ||= deep_symbolize(access_token.get("/v1/account").parsed)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
