Factory.define :committee do |c|
  c.sequence(:name) {|n| "committee#{n}" }
  c.url  "http://www.google.com"
  c.type "Committee"
end

