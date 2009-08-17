# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include CurrentTags
  protect_from_forgery

  before_filter :find_current_tags

  protected
  def find_current_tags
    if current_tag.present?
      @current_tags ||= [current_tag]
    end
  end
  alias :current_tags :find_current_tags

  def scoped_conditions(conditions = {})
    if current_tags && !current_tags.empty?
      conditions.deep_merge({:tags => current_tags})
    else
      conditions
    end
  end
end
