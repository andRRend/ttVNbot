module GetCSV
  def get_csv message
    return CSV.read("lib/users/#{message.from.id}")
  end
  def set_csv array, message
    CSV.open("lib/users/#{message.from.id}", "w+"){|csv| array.each {|a| csv << a}}
  end
end