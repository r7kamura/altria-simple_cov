Build.property(:coverage)

Job.property(:enable_simplecov, type: :boolean)

Job.after_execute { Magi::SimpleCov::Coverage.new(self).after_execute }

JobsController.prepend_view_path File.expand_path("../../../../app/views", __FILE__)

JobsController.before_filter only: :show do
  if @resource.enable_simplecov
    view_context.content_for :jobs_show, render_to_string(partial: "coverage").html_safe
  end
end
