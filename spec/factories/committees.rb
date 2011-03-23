Factory.define :legislature do |l|
  l.sequence(:name) {|n| "legislature #{n}" }
  l.state { |state| state.association(:state) }
end

Factory.define :committee do |c|
  c.sequence(:name) {|n| "committee#{n}" }
  c.url  "http://www.google.com"
  c.type "Committee"
  # c.legislature nil
  c.legislature { |leg| leg.association(:legislature) }
end


