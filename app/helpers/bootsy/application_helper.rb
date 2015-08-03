module Bootsy
  module ApplicationHelper
    def resource_or_nil(resource)
      resource if resource.present? && resource.persisted?
    end
  end
end
