module ApplicationHelper
  def nice_date(date)
    date.strftime("%m/%d/%y")
  end
  def long_date(date)
    date.strftime("%B %d, %Y")
  end
end
