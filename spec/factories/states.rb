Factory.define :state do |s|
  s.name "Texas"
  s.abbrev "TX"
  s.fips_code 27
  s.official_url "http://www.google.com"
end


  # create_table "states", :force => true do |t|
  #   t.string   "name",                                         :null => false
  #   t.string   "abbrev",       :limit => 2,                    :null => false
  #   t.boolean  "unicameral",                :default => false
  #   t.integer  "fips_code"
  #   t.datetime "launch_date"
  #   t.string   "official_url"
  # end

