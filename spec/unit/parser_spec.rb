require "dry/web/parser"

RSpec.describe Dry::Web::Parser do
  let(:klass) { Dry::Web::Parser }
  let(:parser) { klass.new(file) }
  let(:file) { SPEC_ROOT.join("fixtures/test/.env.test") }

  describe "#parse" do
    subject { parser.parse }

    it "will retrun a hash with all variables and its value" do
      expect(subject["API_KEY"]).to eq ("yaml123")
      expect(subject["PRECOMPILE_ASSETS"]).to eq ("1")
      expect(subject["UNDECLARED"]).to eq ("not declared in settings")
      expect(subject["TESTING"]).to eq ("variables with = in it")
    end
  end
end
