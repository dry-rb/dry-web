RSpec.describe "Dry::Web::Container" do
  subject(:container) { Class.new(Dry::Web::Container) }

  describe "settings" do
    # Do some acrobatics to make the container reload a setting from scratch
    # and apply a new default
    def reload_setting_for(key)
      if Dry::Web::Container.instance_variables.include?(:@_config)
        Dry::Web::Container.remove_instance_variable(:@_config)
      end

      Dry::Web::Container.instance_variable_get(:@_settings).delete_if do |setting|
        setting.name == key
      end
      load "dry/web/container.rb"
    end

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

    describe ".config.env" do
      context "existing RACK_ENV environment variable" do
        before do
          @rack_env = ENV["RACK_ENV"]
          ENV["RACK_ENV"] = "production"

          reload_setting_for :env
        end

        after do
          ENV["RACK_ENV"] = @rack_env
        end

        it "returns the RACK_ENV" do
          expect(Dry::Web::Container.config.env).to eq :production
        end
      end

      context "no RACK_ENV set" do
        before do
          @rack_env = ENV["RACK_ENV"]
          ENV.delete("RACK_ENV")

          reload_setting_for :env
        end

        after do
          ENV["RACK_ENV"] = @rack_env
        end

        it "defaults to development" do
          expect(Dry::Web::Container.config.env).to eq :development
        end
      end
    end
  end
end
