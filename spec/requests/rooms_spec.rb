require 'swagger_helper'

RSpec.describe 'rooms', type: :request do

  path '/rooms' do

    get('list rooms') do
      tags "Room"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
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

    post('create room') do
      tags "Room"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          room: {
            type: :object,
            properties: {
              room_type: { type: :string },
              description: { type: :string },
              charges: { type: :integer },
              capacity: { type: :integer }
            },
          },
        },
        required: ["room", "room_type", "description", "charges", "capacity"],
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

  path '/rooms/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show room') do
      tags "Room"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      response(200, 'successful') do
        let(:id) { '123' }

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

    put('update room') do
      tags "Room"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          room: {
            type: :object,
            properties: {
              room_type: { type: :string },
              description: { type: :string },
              charges: { type: :integer },
              capacity: { type: :integer }
            },
          },
        },
        required: ["room", "room_type", "description", "charges", "capacity"],
      }
      response(200, 'successful') do
        let(:id) { '123' }

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
