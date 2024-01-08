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
FactoryBot.define do
  factory :stripe_subscription, class: 'StripeSubscription' do
    uuid { SecureRandom.uuid }
    stripe_id { SecureRandom.uuid }
    status { 'unpaid' }

    trait :paid do
      after(:build) do |subscription, _evaluator|
        subscription.mark_paid
      end
    end

    trait :canceled do
      after(:create) do |subscription, _evaluator|
        subscription.mark_canceled
      end

      deleted_at { Time.zone.now }
    end
  end
end
