// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Today {
    /// Today
    internal static let title = L10n.tr("Localizable", "Today.title")
  }

  internal enum WeatherCondition {
    /// Broken Clouds
    internal static let brokenClouds = L10n.tr("Localizable", "WeatherCondition.brokenClouds")
    /// Clear
    internal static let clear = L10n.tr("Localizable", "WeatherCondition.clear")
    /// Dust
    internal static let dust = L10n.tr("Localizable", "WeatherCondition.dust")
    /// Extreme Rain
    internal static let extremeRain = L10n.tr("Localizable", "WeatherCondition.extremeRain")
    /// Few Clouds
    internal static let fewClouds = L10n.tr("Localizable", "WeatherCondition.fewClouds")
    /// Fog
    internal static let fog = L10n.tr("Localizable", "WeatherCondition.fog")
    /// Freezing Rain
    internal static let freezingRain = L10n.tr("Localizable", "WeatherCondition.freezingRain")
    /// Haze
    internal static let haze = L10n.tr("Localizable", "WeatherCondition.haze")
    /// Heavy Intensity Rain
    internal static let heavyIntensityRain = L10n.tr("Localizable", "WeatherCondition.heavyIntensityRain")
    /// Heavy Intensity Shower Rain
    internal static let heavyIntensityShowerRain = L10n.tr("Localizable", "WeatherCondition.heavyIntensityShowerRain")
    /// Heavy Shower Snow
    internal static let heavyShowerSnow = L10n.tr("Localizable", "WeatherCondition.heavyShowerSnow")
    /// Heavy Snow
    internal static let heavySnow = L10n.tr("Localizable", "WeatherCondition.heavySnow")
    /// Heavy Thunderstorm
    internal static let heavyThunderstorm = L10n.tr("Localizable", "WeatherCondition.heavyThunderstorm")
    /// Light Intensity Shower Rain
    internal static let lightIntensityShowerRain = L10n.tr("Localizable", "WeatherCondition.lightIntensityShowerRain")
    /// Light Rain
    internal static let lightRain = L10n.tr("Localizable", "WeatherCondition.lightRain")
    /// Light Rain Snow
    internal static let lightRainSnow = L10n.tr("Localizable", "WeatherCondition.lightRainSnow")
    /// Light Shower Sleet
    internal static let lightShowerSleet = L10n.tr("Localizable", "WeatherCondition.lightShowerSleet")
    /// Light Shower Snow
    internal static let lightShowerSnow = L10n.tr("Localizable", "WeatherCondition.lightShowerSnow")
    /// Light Snow
    internal static let lightSnow = L10n.tr("Localizable", "WeatherCondition.lightSnow")
    /// Light Thunderstorm
    internal static let lightThunderstorm = L10n.tr("Localizable", "WeatherCondition.lightThunderstorm")
    /// Mist
    internal static let mist = L10n.tr("Localizable", "WeatherCondition.mist")
    /// Moderate Rain
    internal static let moderateRain = L10n.tr("Localizable", "WeatherCondition.moderateRain")
    /// Overcast Clouds
    internal static let overcastClouds = L10n.tr("Localizable", "WeatherCondition.overcastClouds")
    /// Ragged Shower Rain
    internal static let raggedShowerRain = L10n.tr("Localizable", "WeatherCondition.raggedShowerRain")
    /// Ragged Thunderstorm
    internal static let raggedThunderstorm = L10n.tr("Localizable", "WeatherCondition.raggedThunderstorm")
    /// Rain Snow
    internal static let rainSnow = L10n.tr("Localizable", "WeatherCondition.rainSnow")
    /// Sand
    internal static let sand = L10n.tr("Localizable", "WeatherCondition.sand")
    /// Sand Dust Whirls
    internal static let sandDustWhirls = L10n.tr("Localizable", "WeatherCondition.sandDustWhirls")
    /// Scattered Clouds
    internal static let scatteredClouds = L10n.tr("Localizable", "WeatherCondition.scatteredClouds")
    /// Shower Rain
    internal static let showerRain = L10n.tr("Localizable", "WeatherCondition.showerRain")
    /// Shower Sleet
    internal static let showerSleet = L10n.tr("Localizable", "WeatherCondition.showerSleet")
    /// Shower Snow
    internal static let showerSnow = L10n.tr("Localizable", "WeatherCondition.showerSnow")
    /// Sleet
    internal static let sleet = L10n.tr("Localizable", "WeatherCondition.sleet")
    /// Smoke
    internal static let smoke = L10n.tr("Localizable", "WeatherCondition.smoke")
    /// Snow
    internal static let snow = L10n.tr("Localizable", "WeatherCondition.snow")
    /// Squalls
    internal static let squalls = L10n.tr("Localizable", "WeatherCondition.squalls")
    /// Thunderstorm
    internal static let thunderstorm = L10n.tr("Localizable", "WeatherCondition.thunderstorm")
    /// Thunderstorm with Drizzle
    internal static let thunderstormDrizzle = L10n.tr("Localizable", "WeatherCondition.thunderstormDrizzle")
    /// Thunderstorm with Heavy Drizzle
    internal static let thunderstormHeavyDrizzle = L10n.tr("Localizable", "WeatherCondition.thunderstormHeavyDrizzle")
    /// Thunderstorm with Heavy Rain
    internal static let thunderstormHeavyRain = L10n.tr("Localizable", "WeatherCondition.thunderstormHeavyRain")
    /// Thunderstorm with Light Drizzle
    internal static let thunderstormLightDrizzle = L10n.tr("Localizable", "WeatherCondition.thunderstormLightDrizzle")
    /// Thunderstorm with Light Rain
    internal static let thunderstormLightRain = L10n.tr("Localizable", "WeatherCondition.thunderstormLightRain")
    /// Thunderstorm with Rain
    internal static let thunderstormRain = L10n.tr("Localizable", "WeatherCondition.thunderstormRain")
    /// Tornado
    internal static let tornado = L10n.tr("Localizable", "WeatherCondition.tornado")
    /// Very Heavy Rain
    internal static let veryHeavyRain = L10n.tr("Localizable", "WeatherCondition.veryHeavyRain")
    /// Volcanic Ash
    internal static let volcanicAsh = L10n.tr("Localizable", "WeatherCondition.volcanicAsh")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
