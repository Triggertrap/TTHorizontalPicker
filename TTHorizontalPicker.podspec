Pod::Spec.new do |s|
  s.name             = "TTHorizontalPicker"
  s.version          = "1.0.0"
  s.summary          = "A custom UIView that acts as a horizontal value picker."
  s.description      = <<-DESC
                       A custom UIView that acts as a horizontal value picker. It is designed to scale depending on the size of the view and accepts values from plists. You can change the font, gradient start/end color, horizontal and vertical line colors and gradient direction.
                       DESC
  s.homepage         = "https://github.com/TriggerTrap/TTHorizontalPicker/"
  s.license          = 'MIT'
  s.author           = { "Valentin Kalchev" => "valentin@triggertrap.com" }
  s.source           = { :git => "https://github.com/TriggerTrap//TTHorizontalPicker.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'
  s.public_header_files = 'Source/**/*'
end
