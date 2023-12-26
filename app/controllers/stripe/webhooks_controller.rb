# frozen_string_literal: true

module Stripe
  class WebhooksController < ApplicationController
    def create
      head :ok
    end
  end
end
