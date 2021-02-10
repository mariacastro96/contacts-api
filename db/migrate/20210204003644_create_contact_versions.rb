# frozen_string_literal: true

class CreateContactVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_versions do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :contact

      t.timestamps
    end
  end
end
