module DaterangeParams
  protected

  def since_filter
    date_param(:since, Time.zone.now.beginning_of_day)
  end

  def upto_filter
    date_param(:upto, Time.zone.now)
  end

  def date_param(key, default)
    filter = params[key]
    return default if filter.blank?

    Time.parse(filter)
  end
end
