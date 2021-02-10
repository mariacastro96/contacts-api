# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contacts) { FactoryBot.create_list(:contact, 5) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:email) { Faker::Internet.unique.email }
  let(:phone) { Faker::PhoneNumber.phone_number }
  let(:contact_attrs) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone
    }
  end

  context 'when data is valid' do
    it { expect(contact).to be_valid }
  end

  context 'when data is invalid' do
    context 'with nil param' do
      let(:first_name) { nil }

      it { expect(contact).not_to be_valid }
    end

    context 'with dup email' do
      before { contact.dup.save }

      it { expect(contact).not_to be_valid }
    end
  end

  describe '#create_contact_version' do
    let(:email) { 'mail@mail.co' }

    before do
      contact.save
      contact.update(email: email)
    end

    it { expect(ContactVersion.count).to eq 1 }
    it { expect(ContactVersion.last.contact).to eq contact }
    it { expect(ContactVersion.last.email).to eq email }
  end
end
