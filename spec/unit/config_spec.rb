require "dry/web/config"

RSpec.describe Dry::Web::Config do
  describe ".new" do
    it "builds a validation schema" do
      config = Dry::Web::Config.new do
        key(:api_key).required
      end

      expect(config.schema).to be_a Dry::Validation::Schema
      expect(config.schema.rules.keys).to include :api_key
    end
  end

  describe "#load" do
    subject(:config) { Dry::Web::Config.new(&schema).load(*sources) }

    let(:schema) {->{
      key(:api_key).required
      key(:precompiled_assets).required(:bool?)
      key(:assets_host).required
    }}

    let(:sources) { [source] }

    let(:source) {
      {
        "api_key" => "abc123",
        "precompiled_assets" => "1",
        "assets_host" => "http://localhost:1234/",
        "foo" => "bar"
      }
    }

    it "sanitizes input" do
      expect(config).not_to respond_to(:foo)
    end

    it "coerces input" do
      expect(config.precompiled_assets).to eq true
    end

    context "invalid config" do
      let(:schema) {->{
        key(:maximum_fneeps).required
      }}

      it "raises an exception" do
        expect { config }.to raise_error Dry::Web::Config::ConfigNotValidException
      end
    end

    describe "using multiple sources (e.g. YAML file and ENV)" do
      let(:sources) { [source, env_source] }

      let(:source) {
        {"api_key" => "abc123"}
      }

      let(:env_source) {
        {
          "API_KEY" => "env123",
          "PRECOMPILED_ASSETS" => "1",
          "ASSETS_HOST" => "http://localhost:1234/provided_by_env",
          "PATH" => "/usr/local/bin:/usr/bin",
        }
      }

      it "prioritises keys from the YAML source" do
        expect(config.api_key).to eq "abc123"
      end

      it "falls back to the ENV source for keys missing from the YAML source, and can find keys using conventional uppser-cased ENV vars" do
        expect(config.assets_host).to eq "http://localhost:1234/provided_by_env"
      end
    end

    describe "using a source that supports nesting" do
      let(:schema) {->{
        key(:aws).schema do
          key(:access_key).required
          key(:bucket_name).required
        end
      }}

      let(:source) {
        {
          "aws" => {
            "access_key" => "xyz",
            "bucket_name" => "my-bucket",
          }
        }
      }

      it "supports access to nested keys" do
        expect(config.aws.bucket_name).to eq "my-bucket"
      end
    end
  end
end
