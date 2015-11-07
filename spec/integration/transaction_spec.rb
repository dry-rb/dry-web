require 'rodakase/request/composer'

RSpec.describe 'Rodakase Transaction' do
  subject(:request) { Rodakase::Transaction::Composer.new(container) }

  let(:container) do
    {
      validate_params: -> params {
        if params[:email]
          Rodakase::Transaction::Success(params)
        else
          Rodakase::Transaction::Failure(:validation, 'missing email')
        end
      },
      persist_user: -> input {
        input.fmap do |value|
          Test::DB.concat([value])
        end
      },
      render_ui: -> input {
        input.fmap do |db|
          "user #{db.last[:email]} created"
        end
      }
    }
  end

  let(:pipeline) do
    request.define do
      steps :validate_params, :persist_user, :render_ui
    end
  end

  before do
    module Test
      DB = []
    end
  end

  it 'works with success' do
    result = []

    pipeline.(email: 'jane@doe.org') do |m|
      m.success do |value|
        result << value
      end
    end

    expect(result).to include('user jane@doe.org created')
  end

  it 'works with failure' do
    result = []

    pipeline.(foo: 'jane@doe.org') do |m|
      m.failure do |f|
        f.on(:validation) do |err|
          result << err
        end
      end
    end

    expect(result).to include('missing email')
  end
end
