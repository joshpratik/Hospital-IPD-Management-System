require 'swagger_helper'

RSpec.describe "Admissions", type: :request do
  
  path '/admissions' do

    get('list admissions') do
      tags "Admission"
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

    post('create admission') do
      tags "Admission"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          admission: {
            type: :object,
            properties: {
              admission_date: { type: :date },
              discharge_date: { type: :date },
              dignostic: { type: :string },
              admission_status: { type: :string },
              staff_id: { type: :integer},
              room_id: { type: :integer},
              patient_id: { type: :integer }
            },
          },
        },
        required: ["admission", "admission_date", "dignostic", "admission_status", "staff_id", "patient_id","room_id"],
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

  path '/admissions/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show admission') do
      tags "Admission"
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

    delete('discharge patient') do
      tags "Admission"
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

    put('update admission') do
      tags "Admission"
      consumes "application/json"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          admission: {
            type: :object,
            properties: {
              admission_date: { type: :date },
              discharge_date: { type: :date },
              dignostic: { type: :string },
              admission_status: { type: :string },
              staff_id: { type: :integer},
              room_id: { type: :integer},
              patient_id: { type: :integer }
            },
          },
        },
        required: ["admission", "admission_date", "dignostic", "admission_status", "staff_id", "patient_id","room_id"],
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

  path '/admissions/invoice/:id' do

    get('create invoice') do
      tags "Admission"
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
  end
end
