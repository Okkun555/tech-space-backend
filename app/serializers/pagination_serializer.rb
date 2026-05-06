class PaginationSerializer
  def self.render(pagy)
    {
      current_page: pagy.page,
      total_pages: pagy.pages,
      total_count: pagy.count,
      limit: pagy.limit
    }
  end
end
