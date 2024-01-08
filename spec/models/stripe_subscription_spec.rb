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
#  stripe_id  :string
#
# Indexes
#
#  index_stripe_subscriptions_on_stripe_id  (stripe_id) UNIQUE
#  index_stripe_subscriptions_on_uuid       (uuid) UNIQUE
#
require 'rails_helper'

RSpec.describe StripeSubscription do
  describe 'status transitions' do
    let(:subscription) { create(:stripe_subscription) }

    it 'marks as paid' do
      subscription.mark_paid!

      expect(subscription.paid?).to be true
    end

    it 'does not mark as paid when already paid' do
      subscription.mark_paid!

      expect { subscription.mark_paid! }.to raise_error(AASM::InvalidTransition)
    end

    it 'does not mark as canceled when unpaid' do
      expect { subscription.mark_canceled! }.to raise_error(AASM::InvalidTransition)
    end

    context 'when paid' do
      let(:subscription) { create(:stripe_subscription, :paid) }

      it 'marks as canceled and sets deleted_at', :aggregate_failures do
        subscription.mark_canceled!

        expect(subscription.canceled?).to be true
        expect(subscription.deleted_at).not_to be_nil
      end

      it 'does not mark as canceled when already canceled' do
        subscription.mark_canceled!

        expect { subscription.mark_canceled! }.to raise_error(AASM::InvalidTransition)
      end
    end
  end
end
