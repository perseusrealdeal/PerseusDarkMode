Pod::Spec.new do |p|

p.name           = "PerseusDarkMode"
p.version        = "1.1.0"
p.summary        = "It gives an accessible variable of Dark Mode."
p.description    = "Designed for constructing Dark Mode sensitive features."
p.homepage       = "https://github.com/perseusrealdeal/PerseusDarkMode"

p.license        = { :type => "MIT", :file => "LICENSE" }
p.author         = { "perseusrealdeal" => "mzhigulin@gmail.com" }

p.source         = { :git => "https://github.com/perseusrealdeal/PerseusDarkMode.git", :tag => p.version.to_s }
p.platform       = :ios, '9.3'
p.platform       = :osx, '10.9'
p.swift_version  = "4.2"
p.requires_arc   = true

p.source_files   = 'Sources/**/*.swift'

end
