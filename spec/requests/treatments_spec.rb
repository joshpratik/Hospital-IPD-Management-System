require 'swagger_helper'

RSpec.describe 'treatments', type: :request do

  path '/treatments' do

    post('create treatment') do
      tags "Treatment"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          treatment: {
            type: :object,
            properties: {
              quantity: { type: :string },
              admission_id: { type: :integer},
              medicine_id: { type: :integer }
            },
          },
        },
        required: ["treatment", "quantity", "admission_id", "medicine_id"],
      }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(422, "Unprocessable Entity") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
      response(402, "Unauthorized") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end
  end
end
