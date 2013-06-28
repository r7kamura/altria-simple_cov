require File.expand_path("../../../spec_helper", __FILE__)

describe Altria::SimpleCov::Coverage do
  before do
    coverage.last_run_json_path.parent.mkpath
    FileUtils.touch(coverage.last_run_json_path)
  end

  let(:coverage) do
    described_class.new(job)
  end

  let(:build) do
    FactoryGirl.create(:build, job: job)
  end

  let(:job) do
    FactoryGirl.create(:job, properties: { "enable_simplecov" => true })
  end

  describe "#after_execute" do
    context "when not enabled" do
      before do
        job.enable_simplecov = false
      end

      it "does nothing" do
        coverage.should_not_receive(:save)
        coverage.after_execute
      end
    end

    context "without coverage file" do
      before do
        coverage.last_run_json_path.delete
      end

      it "does nothing" do
        coverage.should_not_receive(:save)
        coverage.after_execute
      end
    end

    context "with coverage file" do
      it "saves coverage of the build" do
        coverage.should_receive(:save)
        coverage.after_execute
      end
    end
  end

  describe "#save" do
    before do
      build.update_attributes(started_at: Time.now)
      FileUtils.touch(coverage.result_html_path)
    end

    it "saves assets and index.html for each build" do
      coverage.save
      Pathname.new("tmp/workspace/jobs/#{job.id}/coverage/#{build.id}/assets").should be_symlink
      Pathname.new("tmp/workspace/jobs/#{job.id}/coverage/#{build.id}/index.html").should be_file
    end
  end
end
