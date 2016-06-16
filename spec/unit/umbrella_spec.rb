require "dry/web/settings"
require "dry/web/umbrella"

RSpec.describe Dry::Web::Umbrella do
  subject(:umbrella) {
    Class.new(Dry::Web::Umbrella) do
      configure do |config|
        config.root = SPEC_ROOT.join("fixtures/test")
      end
    end
  }

  describe "config" do
    describe "#settings" do
      subject(:settings) { umbrella.config.settings }

      context "no settings specified" do
        it "is an empty object" do
          expect(:settings).not_to be_nil
        end

        it "does not offer any settings" do
          expect(:settings).not_to respond_to(:some_setting)
        end
      end

      context "settings loader specified" do
        let(:settings_loader) { class_double("Dry::Web::Settings") }

        it "loads the settings using the specified settings_loader" do
          allow(settings_loader).to receive(:load).with(umbrella.config.root, :test) {
            double("settings", foo: "bar")
          }

          umbrella.configure do |config|
            config.settings_loader = settings_loader
          end

          expect(settings.foo).to eq "bar"
        end
      end

      context "settings object specified" do
        before do
          umbrella.configure do |config|
            config.settings = double("custom settings", bar: "baz")
          end
        end

        it "leaves the settings object in place" do
          expect(settings.bar).to eq "baz"
        end
      end
    end
  end
end
