//
//  Weather.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import UIKit

enum WeatherCondition: Int, Decodable {
    //Thunderstorm
    case thunderstormLightRain = 200
    case thunderstormRain = 201
    case thunderstormHeavyRain = 202
    case lightThunderstorm = 210
    case thunderstorm = 211
    case heavyThunderstorm = 212
    case raggedThunderstorm = 221
    case thunderstormLightDrizzle = 230
    case thunderstormDrizzle = 231
    case thunderstormHeavyDrizzle = 232
    //Rain
    case lightRain = 500
    case moderateRain = 501
    case heavyIntensityRain = 502
    case veryHeavyRain = 503
    case extremeRain = 504
    case freezingRain = 511
    case lightIntensityShowerRain = 520
    case showerRain = 521
    case heavyIntensityShowerRain = 522
    case raggedShowerRain = 531
    //Snow
    case lightSnow = 600
    case snow = 601
    case heavySnow = 602
    case sleet = 611
    case lightShowerSleet = 612
    case showerSleet = 613
    case lightRainSnow = 615
    case rainSnow = 616
    case lightShowerSnow = 620
    case showerSnow = 621
    case heavyShowerSnow = 622
    //Atmosphere
    case mist = 701
    case smoke = 711
    case haze = 721
    case sandDustWhirls = 731
    case fog = 741
    case sand = 751
    case dust = 761
    case volcanicAsh = 762
    case squalls = 771
    case tornado = 781
    //Clear
    case clear = 800
    //Clouds
    case fewClouds = 801
    case scatteredClouds = 802
    case brokenClouds = 803
    case overcastClouds = 804
}

//MARK: - Variables
extension WeatherCondition {
    var description: String {
        switch (self) {
        case .thunderstormLightRain: return L10n.WeatherCondition.thunderstormLightRain
        case .thunderstormRain: return L10n.WeatherCondition.thunderstormLightRain
        case .thunderstormHeavyRain: return L10n.WeatherCondition.thunderstormHeavyRain
        case .lightThunderstorm: return L10n.WeatherCondition.lightThunderstorm
        case .thunderstorm: return L10n.WeatherCondition.thunderstorm
        case .heavyThunderstorm: return L10n.WeatherCondition.heavyThunderstorm
        case .raggedThunderstorm: return L10n.WeatherCondition.raggedThunderstorm
        case .thunderstormLightDrizzle: return L10n.WeatherCondition.thunderstormLightDrizzle
        case .thunderstormDrizzle: return L10n.WeatherCondition.thunderstormDrizzle
        case .thunderstormHeavyDrizzle: return L10n.WeatherCondition.thunderstormHeavyDrizzle
        case .lightRain: return L10n.WeatherCondition.lightRain
        case .moderateRain: return L10n.WeatherCondition.moderateRain
        case .heavyIntensityRain: return L10n.WeatherCondition.heavyIntensityRain
        case .veryHeavyRain: return L10n.WeatherCondition.veryHeavyRain
        case .extremeRain: return L10n.WeatherCondition.extremeRain
        case .freezingRain: return L10n.WeatherCondition.freezingRain
        case .lightIntensityShowerRain: return L10n.WeatherCondition.lightIntensityShowerRain
        case .showerRain: return L10n.WeatherCondition.showerRain
        case .heavyIntensityShowerRain: return L10n.WeatherCondition.heavyIntensityShowerRain
        case .raggedShowerRain: return L10n.WeatherCondition.raggedShowerRain
        case .lightSnow: return L10n.WeatherCondition.lightSnow
        case .snow: return L10n.WeatherCondition.snow
        case .heavySnow: return L10n.WeatherCondition.heavySnow
        case .sleet: return L10n.WeatherCondition.sleet
        case .lightShowerSleet: return L10n.WeatherCondition.lightShowerSleet
        case .showerSleet: return L10n.WeatherCondition.showerSleet
        case .lightRainSnow: return L10n.WeatherCondition.lightRainSnow
        case .rainSnow: return L10n.WeatherCondition.rainSnow
        case .lightShowerSnow: return L10n.WeatherCondition.lightShowerSnow
        case .showerSnow: return L10n.WeatherCondition.showerSnow
        case .heavyShowerSnow: return L10n.WeatherCondition.heavyShowerSnow
        case .mist: return L10n.WeatherCondition.mist
        case .smoke: return L10n.WeatherCondition.smoke
        case .haze: return L10n.WeatherCondition.haze
        case .sandDustWhirls: return L10n.WeatherCondition.sandDustWhirls
        case .fog: return L10n.WeatherCondition.fog
        case .sand: return L10n.WeatherCondition.sand
        case .dust: return L10n.WeatherCondition.dust
        case .volcanicAsh: return L10n.WeatherCondition.volcanicAsh
        case .squalls: return L10n.WeatherCondition.squalls
        case .tornado: return L10n.WeatherCondition.tornado
        case .clear: return L10n.WeatherCondition.clear
        case .fewClouds: return L10n.WeatherCondition.fewClouds
        case .scatteredClouds: return L10n.WeatherCondition.scatteredClouds
        case .brokenClouds: return L10n.WeatherCondition.brokenClouds
        case .overcastClouds: return L10n.WeatherCondition.overcastClouds
        }
    }

    var dayImage: UIImage? {
        switch self {
        case .thunderstormLightRain,
             .thunderstormRain,
             .thunderstormHeavyRain,
             .lightThunderstorm,
             .thunderstorm,
             .heavyThunderstorm,
             .raggedThunderstorm,
             .thunderstormLightDrizzle,
             .thunderstormDrizzle,
             .thunderstormHeavyDrizzle: return R.image.thunderstormDay()
        case .lightRain,
             .moderateRain,
             .heavyIntensityRain,
             .veryHeavyRain,
             .extremeRain,
             .freezingRain: return R.image.rainDay()
        case .lightIntensityShowerRain,
             .showerRain,
             .heavyIntensityShowerRain,
             .raggedShowerRain: return R.image.showerRainDay()
        case .lightSnow,
             .snow,
             .heavySnow,
             .sleet,
             .lightShowerSleet,
             .showerSleet,
             .lightRainSnow,
             .rainSnow,
             .lightShowerSnow,
             .showerSnow,
             .heavyShowerSnow: return R.image.snowDay()
        case .mist,
             .smoke,
             .haze,
             .sandDustWhirls,
             .fog,
             .sand,
             .dust,
             .volcanicAsh,
             .squalls,
             .tornado: return R.image.mistDay()
        case .clear: return R.image.clearSkyDay()
        case .fewClouds: return R.image.fewCloudsDay()
        case .scatteredClouds: return R.image.scatteredCloudsDay()
        case .brokenClouds,
             .overcastClouds: return R.image.brokenCloudsDay()
        }
    }
    
    var nightImage: UIImage? {
        switch self {
        case .thunderstormLightRain,
             .thunderstormRain,
             .thunderstormHeavyRain,
             .lightThunderstorm,
             .thunderstorm,
             .heavyThunderstorm,
             .raggedThunderstorm,
             .thunderstormLightDrizzle,
             .thunderstormDrizzle,
             .thunderstormHeavyDrizzle: return R.image.thunderstormNight()
        case .lightRain,
             .moderateRain,
             .heavyIntensityRain,
             .veryHeavyRain,
             .extremeRain,
             .freezingRain: return R.image.rainNight()
        case .lightIntensityShowerRain,
             .showerRain,
             .heavyIntensityShowerRain,
             .raggedShowerRain: return R.image.showerRainNight()
        case .lightSnow,
             .snow,
             .heavySnow,
             .sleet,
             .lightShowerSleet,
             .showerSleet,
             .lightRainSnow,
             .rainSnow,
             .lightShowerSnow,
             .showerSnow,
             .heavyShowerSnow: return R.image.snowNight()
        case .mist,
             .smoke,
             .haze,
             .sandDustWhirls,
             .fog,
             .sand,
             .dust,
             .volcanicAsh,
             .squalls,
             .tornado: return R.image.mistNight()
        case .clear: return R.image.clearSkyNight()
        case .fewClouds: return R.image.fewCloudsNight()
        case .scatteredClouds: return R.image.scatteredCloudsNight()
        case .brokenClouds,
             .overcastClouds: return R.image.brokenCloudsNight()
        }
    }
    
}
