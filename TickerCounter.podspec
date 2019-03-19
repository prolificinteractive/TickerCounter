Pod::Spec.new do |s|
  s.name             = "TickerCounter"
  s.version          = "0.2.0"
  s.summary          = "A counter with a ticker animation"
  s.description      = "A counter with a ticker animation." 
  s.homepage         = "https://github.com/ProlificInteractive/TickerCounter"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Kevin Miller" => "k.miller@prolificinteractive.com" }
  s.source           = { :git => "https://github.com/ProlificInteractive/TickerCounter.git", :tag => s.version.to_s }
  s.test_spec		 'TickerCounterTests' do |test_spec|
  						test_spec.source_files = 'Tests/*'
  					end
  
  s.platforms     = { :ios => "9.0" }
  s.requires_arc = true

  s.source_files     = 'Source/**/*.{swift}'

end
