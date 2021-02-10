# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'renders success status' do
  it { expect(response).to have_http_status(:success) }
end

RSpec.shared_examples 'renders bad request status' do
  it { expect(response).to have_http_status(:bad_request) }
end

RSpec.shared_examples 'renders json with correct data' do
  let(:json_response) { JSON.parse(response.body) }
  let(:expected_keys) do
    %w[
      created_at
      email
      first_name
      id
      last_name
      phone
      updated_at
    ]
  end

  it { expect(json_response['data'].keys).to match_array(expected_keys) }
end

RSpec.shared_examples 'renders err message' do |err_message|
  let(:json_response) { JSON.parse(response.body) }

  it { expect(json_response['message']).to eq err_message }
end
