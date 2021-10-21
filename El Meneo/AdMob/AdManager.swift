//
//  AdManager.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 9/28/21.
//

import GoogleMobileAds

class AdManager {
    static let shared = AdManager()
    private var interstitial: GADInterstitialAd?
    private var adCounter = 0
    
    func loadInterstitialAd(controller: UIViewController) {
        //prod-- ca-app-pub-6174585484194945/5331847683
        //debug -- ca-app-pub-3940256099942544/4411468910
//        if(adCounter == 0){
//        let request = GADRequest()
//            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-6174585484194945/5331847683", request: request,
//                                   completionHandler: { [self] ad, error in
//                if let error = error {
//                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                    return
//                }
//                interstitial = ad
//                ad?.present(fromRootViewController: controller)
//            }
//            )
//        }
//        adCounter += 1
//        print("adCounter: \(adCounter)")
//        if(adCounter == 3) {
//            adCounter = 0
//        }
    }
}
