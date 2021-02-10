# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:contacts) { FactoryBot.create_list(:contact, 5) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:email) { Faker::Internet.unique.email }
  let(:phone) { Faker::PhoneNumber.phone_number }
  let(:contact_attrs) do
    {
      first_name: first_name, last_name: last_name, email: email, phone: phone
    }
  end

  before { contacts }

  describe 'GET #index' do
    let(:json_response) { JSON.parse(response.body) }

    before { get :index }

    it_behaves_like 'renders success status'

    it { expect(json_response['data'].count).to eq 5 }
  end

  describe 'POST #create' do
    before { post :create, params: { contact: contact_attrs } }

    context 'with correct data' do
      let(:first_name) { Faker::Name.first_name }

      it_behaves_like 'renders success status'

      it_behaves_like 'renders json with correct data'
    end

    context 'with incorrect data' do
      let(:first_name) { nil }

      it_behaves_like 'renders bad request status'

      it_behaves_like 'renders err message', "First name can't be blank"
    end
  end

  describe 'PUT #update' do
    let(:contact_to_edit) { Contact.last }

    before do
      put :update, params: { id: contact_to_edit.id, contact: contact_attrs }
    end

    context 'with correct data' do
      it_behaves_like 'renders success status'

      it_behaves_like 'renders json with correct data'
    end

    context 'with incorrect data' do
      let(:email) { Contact.first.email }

      it_behaves_like 'renders bad request status'

      it_behaves_like 'renders err message', 'Email has already been taken'
    end
  end

  describe 'DELETE #destroy' do
    let(:contact_to_delete) { Contact.last }

    before { delete :destroy, params: { id: contact_to_delete.id } }

    it_behaves_like 'renders success status'

    it_behaves_like 'renders json with correct data'
  end
end
