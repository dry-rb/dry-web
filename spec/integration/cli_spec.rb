require "dry/web/cli"

RSpec.describe Dry::Web::CLI do
  before do
    $PROGRAM_NAME = "dry-web"
  end

  let(:application) { double(:application, name: "dry-web test application") }

  it "prints commands" do
    cli = described_class.new(Dry::Web::CLI::Commands, application)
    out = StringIO.new
    cli.(out: out)

    out.rewind
    out = out.read
    expect(out).to include "dry-web console"
  end

  it "provides the application to commands" do
    module Test
      class Commands
        extend Hanami::CLI::Registry
      end

      class InspectCommand < Dry::Web::CLI::Command
        desc "Inspects the application"

        def call(**)
          puts application.name
        end
      end

      Commands.register "inspect", InspectCommand
    end

    cli = described_class.new(Test::Commands, application)

    expect {
      cli.(arguments: ["inspect"])
    }.to output("dry-web test application\n").to_stdout
  end
end
