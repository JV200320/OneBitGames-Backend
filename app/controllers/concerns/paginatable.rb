module Paginatable
  extend ActiveSupport::Concern

  max_per_page = 10
  default_page = 1

  included do
    scope :paginate, -> (page, length) do
      page = page.present? && page > 0 ? page : default_page
      length = length.present? && length > 0 ? length : max_per_page
      starts_at = (page-1) * length
      limit(length).offset(starts_at)
    end
  end
end
