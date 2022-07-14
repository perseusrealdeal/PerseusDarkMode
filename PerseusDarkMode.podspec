Pod::Spec.new do |p|

p.name           = "PerseusDarkMode"
p.version        = "1.0.4"
p.summary        = "It gives a controll of Dark Mode of iOS devices."
p.description    = "Aimed to use for building Dark Mode sensitive features."
p.homepage       = "https://github.com/perseusrealdeal/PerseusDarkMode"

p.license        = { :type => "MIT", :file => "LICENSE" }
p.author         = { "perseusrealdeal" => "mzhigulin@gmail.com" }

p.source         = { :git => "https://github.com/perseusrealdeal/PerseusDarkMode.git", :tag => p.version.to_s }
p.platform       = :ios, '9.0'
p.swift_version  = "5.3"
p.requires_arc   = true

p.source_files   = 'Sources/**/*.swift'

end
