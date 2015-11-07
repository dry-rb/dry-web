require 'rodakase/transaction'

RSpec.describe 'Rodakase Transaction' do
  subject(:transaction) { Rodakase::Transaction::Composer.new(container) }

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
    transaction.define do
      step :validate_params do
        step :persist_user, publish: true do
          step :render_ui
        end
      end
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

  it 'works with publisher' do
    Test::NOTIFICATIONS = []

    module Test::Listener
      def self.persist_user_success(result)
        result.fmap { |db| Test::NOTIFICATIONS << db.last }
      end
    end

    pipeline.subscribe(persist_user: Test::Listener)

    pipeline.(email: 'jane@doe.org')

    expect(Test::NOTIFICATIONS).to include(email: 'jane@doe.org')
  end
end
