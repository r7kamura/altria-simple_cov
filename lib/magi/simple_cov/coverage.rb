module Magi
  module SimpleCov
    class Coverage
      attr_reader :job

      def initialize(job)
        @job = job
      end

      def after_execute
        save if enabled? && has_coverage?
      end

      def enabled?
        !!job.enable_simplecov
      end

      def workspace_path
        job.workspace.path + "coverage"
      end

      def last_coverage
        JSON.parse(last_run_json)["result"]["covered_percent"]
      rescue JSON::ParserError, NoMethodError
      end

      def last_run_json
        last_run_json_path.read
      end

      def has_last_run_json?
        last_run_json_path.exist?
      end

      def has_coverage?
        has_last_run_json?
      end

      def last_run_json_path
        job.workspace.path + "repository/coverage/.last_run.json"
      end

      def assets_path
        job.workspace.path + "repository/coverage/assets"
      end

      def assets_relative_path
        assets_path.relative_path_from(current_build_path)
      end

      def result_html_path
        job.workspace.path + "repository/coverage/index.html"
      end

      def current_build_path
        workspace_path + job.current_build.id.to_s
      end

      def symlink_assets
        File.symlink(assets_relative_path, current_build_path + "assets")
      end

      def copy_result_html
        FileUtils.cp(result_html_path, current_build_path)
      end

      def save
        save_files
        save_build
      end

      def save_files
        current_build_path.mkpath
        symlink_assets
        copy_result_html
      end

      def save_build
        job.current_build.update_properties(coverage: last_coverage)
      end
    end
  end
end
