require "dry/web/environment_data"

RSpec.describe Dry::Web::EnvironmentData do
  let(:klass) { Dry::Web::EnvironmentData }
  let(:root) { SPEC_ROOT.join("fixtures/multiple_env_files") }
  let(:env) { :test }
  subject(:data) { klass.new.(root, env)  }

  describe "#call" do
    it "will create hash with both variables from files" do
      expect(subject["ONLY_ON_ENV"]).to eq ("will be loaded from env")
      expect(subject["ONLY_IN_TEST"]).to eq ("will be loaded from env.test")
      expect(subject["IN_BOTH_ENVIRONMENT"]).to eq (".env.test")
    end
  end
end
