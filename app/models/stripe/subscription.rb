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
module Stripe
  class Subscription < ApplicationRecord
    include AASM

    enum status: { unpaid: 0, paid: 1, canceled: 2 }

    aasm column: :status, enum: true do
      state :unpaid, initial: true
      state :paid
      state :canceled

      after_all_transitions :log_status_change

      event :mark_paid do
        transitions from: :unpaid, to: :paid
      end

      event :mark_canceled do
        transitions from: :paid, to: :canceled

        after do
          update(deleted_at: Time.zone.now)
        end
      end
    end

    private

    def log_status_change
      Rails.logger.info("changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})")
    end
  end
end
