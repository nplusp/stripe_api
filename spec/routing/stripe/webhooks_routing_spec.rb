# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stripe::WebhooksController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/stripe/webhooks').to route_to('stripe/webhooks#create')
    end
  end
end
