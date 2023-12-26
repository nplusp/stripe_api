# frozen_string_literal: true

module Stripe
  class << self
    def table_name_prefix
      'stripe_'
    end
  end
end
