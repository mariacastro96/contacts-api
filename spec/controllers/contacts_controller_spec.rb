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
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone
    }
  end

  shared_examples 'renders success status' do
    it { expect(response).to have_http_status(:success) }
  end

  shared_examples 'renders bad request status' do
    it { expect(response).to have_http_status(:bad_request) }
  end

  shared_examples 'renders json with correct data' do
    let(:json_response) { JSON.parse(response.body) }
    let(:expected_keys) { %w[created_at email first_name id last_name phone updated_at] }

    it { expect(json_response['data'].keys).to match_array(expected_keys) }
  end

  shared_examples 'renders correct err message' do |err_message|
    let(:json_response) { JSON.parse(response.body) }

    it { expect(json_response['message']).to eq err_message }
  end

  describe 'GET #index' do
    let(:json_response) { JSON.parse(response.body) }

    before do
      contacts
      get :index
    end

    it_behaves_like 'renders success status'

    it { expect(json_response['data'].count).to eq 5 }
  end

  describe 'POST #create' do
    before do
      contacts

      post :create,
           params: {
             contact: contact_attrs
           }
    end

    context 'with correct data' do
      let(:first_name) { Faker::Name.first_name }

      it_behaves_like 'renders success status'

      it_behaves_like 'renders json with correct data'
    end

    context 'with incorrect data' do
      let(:first_name) { nil }
      let(:expected_err_message) { "First name can't be blank" }

      it_behaves_like 'renders bad request status'

      it_behaves_like 'renders correct err message', expected_err_message
    end
  end

  describe 'PUT #update' do
    let(:contact_to_edit) { Contact.last }

    before do
      contacts

      put :update,
          params: {
            id: contact_to_edit.id,
            contact: contact_attrs
          }
    end

    context 'with correct data' do
      it_behaves_like 'renders success status'

      it_behaves_like 'renders json with correct data'
    end

    context 'with incorrect data' do
      let(:email) { Contact.first.email }
      let(:expected_err_message) { 'Email has already been taken' }

      it_behaves_like 'renders bad request status'

      it_behaves_like 'renders correct err message', expected_err_message
    end
  end

  describe 'DELETE #destroy' do
    let(:contact_to_delete) { Contact.last }

    before do
      contacts

      delete :destroy,
             params: {
               id: contact_to_delete.id
             }
    end

    it_behaves_like 'renders success status'

    it_behaves_like 'renders json with correct data'
  end
end
