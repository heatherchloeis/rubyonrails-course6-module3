require 'rails_helper'

RSpec.describe "FooApiErrorReportings", type: :request do
  include_context 'db_cleanup_each', :transaction
  
  context "invalid Foo reports API error" do
  	let!(:foo_state) { { foo: { id: 1 } } }

  	it do
  	  jpost foos_path, foo_state
	  expect(response).to have_http_status(:bad_request) or have_http_status(:unprocessable_entity)
	  expect(response.content_type).to eq("application/json") 

	  payload=parsed_body
	  expect(payload).to have_key("errors")
	  expect(payload["errors"]).to have_key("full_messages")
	  expect(payload["errors"]["full_messages"][0]).to include("name cannot be null")
	end
  end
end