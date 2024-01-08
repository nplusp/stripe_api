# frozen_string_literal: true

class AddStripeIdToStripeSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :stripe_subscriptions, :stripe_id, :string
    add_index :stripe_subscriptions, :stripe_id, unique: true
  end
end
