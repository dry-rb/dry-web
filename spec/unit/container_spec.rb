# frozen_string_literal: true

require 'rack'
require 'dry/monitor'
require 'dry/monitor/rack/middleware'
require 'dry/monitor/rack/logger'

RSpec.describe "Dry::Web::Container" do
  subject(:container) { Class.new(Dry::Web::Container) }

  describe "settings" do
    describe ".config.logger" do
      it 'sets up default logger for development env' do
        container.configure do |config|
          config.env = :development
        end

        expect(container[:logger].level).to be(Logger::DEBUG)
      end

      it 'sets up default logger for non-development env' do
        container.configure do |config|
          config.env = :production
        end

        expect(container[:logger].level).to be(Logger::ERROR)
      end

      it 'allows presetting a loggert' do
        container.configure do |config|
          config.logger = 'my logger'
        end

        expect(container[:logger]).to eql('my logger')
      end
    end

    describe '.config.notifications' do
      it 'sets up notifications by default' do
        container.configure do |config|
          config.env = :development
        end

        expect(container[:notifications].id).to be(container.config.name)
      end
    end

    describe '.config.rack_monitor' do
      it 'sets up rack monitor by default' do
        container.configure do |config|
          config.env = :development
        end

        expect(container[:rack_monitor].notifications).to be(container[:notifications])
      end
    end

    describe '.config.rack_logger' do
      it 'sets up rack logger by default' do
        logger = spy(:logger)

        container.configure do |config|
          config.env = :development
          config.logger = logger
          config.listeners = true
        end

        payload = { a_rack: :env_hash }

        container[:rack_monitor].instrument(:start, env: payload)

        expect(logger).to have_received(:info)
      end
    end

    describe ".config.env" do
      context "existing RACK_ENV environment variable" do
        it "returns the RACK_ENV" do
          expect(Class.new(Dry::Web::Container).config.env).to eq :test
        end
      end
    end
  end
end
