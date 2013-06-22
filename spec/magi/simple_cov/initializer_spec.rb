require File.expand_path("../../../spec_helper", __FILE__)
require "magi/simple_cov/initializer"

describe Job do
  let(:job) do
    FactoryGirl.create(:job, properties: { "repository_url" => "repository_url" })
  end

  let(:coverage) do
    Magi::SimpleCov::Coverage.any_instance
  end

  describe "#execute" do
    before do
      job.stub(:execute_without_before_executes)
    end

    it "executes Magi::SimpleCov::Coverage#after_execute" do
      coverage.should_receive(:after_execute)
      job.execute
    end
  end
end
