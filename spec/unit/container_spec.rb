RSpec.describe "Dry::Web::Container" do
  subject(:container) { Dry::Web::Container }

  describe "settings" do
    # Do some acrobatics to make the container reload a setting from scratch
    # and apply a new default
    def reload_setting_for(key)
      if Dry::Web::Container.instance_variables.include?(:@_config)
        Dry::Web::Container.remove_instance_variable(:@_config)
      end

      Dry::Web::Container.instance_variable_get(:@_settings).delete_if do |setting|
        setting.name == :env
      end
      load "dry/web/container.rb"
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
