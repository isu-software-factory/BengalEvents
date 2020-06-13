module ActivitiesHelper
  def get_all_repeats(id)
    activities = Activity.where(identifier: id)
    activities
  end
end
