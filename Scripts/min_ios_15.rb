# Clamp every pod's iOS deployment target to >= 15.0.
#
# Xcode 27 errors out on any target built for a deployment target below iOS 15.0,
# and CocoaPods gives each pod target the deployment target declared by its *own*
# podspec. APIKit 5.4.0 (the latest release, unmaintained since 2021) still declares
# iOS 9.0, so `pod lib lint` / `pod trunk push` cannot build it as-is.
#
# Load via RUBYOPT so it applies to the lint that `pod trunk push` runs internally:
#
#   RUBYOPT="-r$(pwd)/Scripts/min_ios_15.rb" pod lib lint --allow-warnings
#
# See the `lint` and `release` targets in the Makefile.
#
# NOTE: `pod trunk push` uploads a JSON serialization of the *loaded* spec, so this
# shim must never be the thing that raises OUR deployment target -- Pokepay.podspec
# declares 15.0 for real, which makes this a no-op on our own spec.
require 'cocoapods'

module Pod
  class Specification
    MIN_IOS_DEPLOYMENT_TARGET = Gem::Version.new('15.0')

    alias_method :_min_ios_15_orig_deployment_target, :deployment_target

    def deployment_target(platform_name = nil)
      value = _min_ios_15_orig_deployment_target(platform_name)
      return value unless platform_name.to_s == 'ios' && value
      Gem::Version.new(value) < MIN_IOS_DEPLOYMENT_TARGET ? MIN_IOS_DEPLOYMENT_TARGET.to_s : value
    end
  end
end
