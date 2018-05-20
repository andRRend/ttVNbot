require_relative 'GetJson'
require_relative 'GetHashParse'

module GetParse
  def get_parse_list (url,login,password)
    include GetJson
    json_file = GetJson.request(URL,LOGIN,PASSWORD)
    tt_hash = JSON.parse(json_file)
    include HashParse
    return HashParse.get_list(tt_hash)
  end
  def get_parse_tt (url,login,password,tt_number)
    include GetJson
    json_file = GetJson.request(URL,LOGIN,PASSWORD)
    tt_hash = JSON.parse(json_file)
    include HashParse
    return HashParse.tt_by_number(tt_hash,tt_number)
  end
end
