# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Collect'
  app.icons = ['icon.png', 'icon@2x.png']
  app.prerendered_icon = true

  app.files << './app/config.rb'

  app.libs << '/usr/lib/libz.1.1.3.dylib'
  app.libs << '/usr/lib/libsqlite3.dylib'
  app.frameworks += [
    'AudioToolbox',
    'CFNetwork',
    'CoreGraphics',
    'CoreLocation',
    'MapKit',
    'MobileCoreServices',
    'QuartzCore',
    'Security',
    'StoreKit',
    'SystemConfiguration']

  # in case app.deployment_target < '6.0'
  app.weak_frameworks += [
    'Accounts',
    'AdSupport',
    'Social']

  app.vendor_project('vendor/Parse.framework', :static,
    :products => ['Parse'],
    :headers_dir => 'Headers')

  # Required by Parse for some reason ...
  # https://parse.com/questions/parse-126-and-rubymotion-135-compilation-error
  app.vendor_project('vendor/FacebookSDK.framework', :static,
    :products => ['FacebookSDK'],
    :headers_dir => 'Headers')
end
