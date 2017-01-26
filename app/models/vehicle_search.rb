class VehicleSearch
  attr_reader :where_clause, :where_args, :order

  def initialize(search_term)
  @search_term = search_term.downcase
  @where_clause = ""
  @where_args = {}
  build_for_license_search(search_term)
  end

  def build_for_license_search(search_term)
    @where_clause << case_insensitve_search(:license_plate)
    @where_args[:license_plate] = starts_with(search_term)
  end

  def starts_with(search_term)
  "%" + search_term + "%"
  end

  def case_insensitve_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end
end
