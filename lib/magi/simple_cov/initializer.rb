Build.property(:coverage)
Job.property(:enable_simplecov, type: :boolean)
Job.after_execute { Magi::SimpleCov::Coverage.new(self).after_execute }
