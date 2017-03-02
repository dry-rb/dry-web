require "dry/web/settings/file_parser"

RSpec.describe Dry::Web::Settings::FileParser do
  let(:klass) { Dry::Web::Settings::FileParser }
  let(:parser) { klass.new  }

  describe "#call" do
    context "with existing file" do
      let(:file) { SPEC_ROOT.join("fixtures/test/.env.test") }
      subject(:settings) { parser.(file) }

      it "will retrun a hash with all variables and its value" do
        expect(subject["API_KEY"]).to eq ("yaml123")
        expect(subject["PRECOMPILE_ASSETS"]).to eq ("1")
        expect(subject["UNDECLARED"]).to eq ("not declared in settings")
        expect(subject["TESTING"]).to eq ("variables with = in it")
      end
    end

    context "without existing file" do
      let(:file) { SPEC_ROOT.join("fixtures/test/.env") }
      subject(:settings) { parser.(file) }

      it "will retrun a empty hash" do
        expect(subject).to eq ({})
      end
    end
  end
end
