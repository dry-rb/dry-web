require "dry/web/settings"

RSpec.describe Dry::Web::Settings do
  describe ".setting" do
    it "raises an error if a duplicate setting is specified" do
      expect {
        Class.new(Dry::Web::Settings) do
          setting :foo
          setting :foo
        end
      }.to raise_error(ArgumentError)
    end
  end

  describe ".load" do
    subject(:settings) {
      Class.new(Dry::Web::Settings) do
        setting :api_key
        setting :precompile_assets
        setting :env_only_setting
        setting :text_with_erb
      end.load(SPEC_ROOT.join("fixtures/test"), :test)
    }

    it "loads settings from ENV first (as upper-cased variables)" do
      ENV["ENV_ONLY_SETTING"] = "hello"
      expect(settings.env_only_setting).to eq "hello"
    end

    it "loads settings from a YAML file (as lower-cased keys) if unavailable from ENV" do
      expect(settings.api_key).to eq "yaml123"
    end

    it "ignores undeclared settings in the YAML file" do
      expect(settings).not_to respond_to(:undeclared)
    end

    it "allows ERB the YAML file" do
      ENV["ERB_TEXT"] = "ERB"
      expect(settings.text_with_erb).to eq "Some text with ERB inserted"
    end

    context "settings with types" do
      before do
        Test::CoercingBool = Class.new do
          def self.[](val)
            %w[1 true].include?(val.to_s)
          end
        end

        Test::ConstraintNotMatched = Class.new(ArgumentError)

        Test::LongString = Class.new do
          def self.[](val)
            raise Test::ConstraintNotMatched, "string must be 12 characters or longer" if val.length < 12
          end
        end
      end

      context "coercing types" do
        subject(:settings) {
          Class.new(Dry::Web::Settings) do
            setting :precompile_assets, Test::CoercingBool
          end.load(SPEC_ROOT.join("fixtures/test"), :test)
        }

        it "supports coercion input data" do
          expect(settings.precompile_assets).to eq true
        end
      end

      context "constraining types" do
        subject(:settings) {
          Class.new(Dry::Web::Settings) do
            setting :api_key, Test::LongString
          end.load(SPEC_ROOT.join("fixtures/test"), :test)
        }

        it "raises helpful exceptions if input data does not match constraints" do
          expect { settings }.to raise_error(Dry::Web::Settings::SettingValueError)
          expect { settings }.to raise_error(/error typecasting \+api_key\+/)
        end
      end
    end
  end
end
