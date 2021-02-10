# frozen_string_literal: true

class Contact < ApplicationRecord
  has_many :contact_versions, dependent: :destroy
  before_update :create_contact_version
  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  private

  def create_contact_version
    attrs = attributes.except('id', 'updated_at', 'created_at')

    old_attributes = attrs.each { |k, _v| attrs[k] = send("#{k}_was") }
    ContactVersion.create(old_attributes.merge(contact_id: id))
  end
end
