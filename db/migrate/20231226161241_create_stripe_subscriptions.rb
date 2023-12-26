# frozen_string_literal: true

class CreateStripeSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :stripe_subscriptions do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.integer :status, null: false, default: 0

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
