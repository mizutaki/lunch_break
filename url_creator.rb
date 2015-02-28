module URLCreator
  def self.build_url(hash={})
    url = []
    dates = URLCreator.get_dates(2).join(",")
    hash.each do |key, value|
       tmp =value.join << dates
       url << tmp
    end
    return url
  end

  def self.get_dates(month)
    current_date = Date.today
    after_date = current_date >> month
    dates = []
    Date.parse(current_date.to_s).upto(Date.parse(after_date.to_s)){|i| dates << i.strftime("%Y%d%d")}
    return dates
  end
end