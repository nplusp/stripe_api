# frozen_string_literal: true

# == Schema Information
#
# Table name: stripe_subscriptions
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  status     :integer          default("unpaid"), not null
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stripe_subscriptions_on_uuid  (uuid) UNIQUE
#
require 'rails_helper'

RSpec.describe Stripe::Subscription do
  describe 'status transitions' do
    let(:subscription) { create(:stripe_subscription) }

    it 'marks as paid' do
      subscription.mark_paid!

      expect(subscription.paid?).to be true
    end

    context 'when paid' do
      let(:subscription) { create(:stripe_subscription, :paid) }

      it 'marks as canceled and sets deleted_at', :aggregate_failures do
        subscription.mark_canceled!

        expect(subscription.canceled?).to be true
        expect(subscription.deleted_at).not_to be_nil
      end
    end
  end
end
