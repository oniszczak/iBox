//
//  ComplicationController.swift
//  iBox Watch Extension
//
//  Created by ALEKSANDER ONISZCZAK on 2019-10-22.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
        // handler ([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
//       switch  complication . family  {
//
//       case  . modularSmall :
//           let  template  =  CLKComplicationTemplateModularSmallRingText ()
//           template . textProvider  =  CLKSimpleTextProvider ( text :  String(Int.random(in: 1 ..< 10)) )
//           template . fillFraction  =  self . randomNumber
//           handler ( CLKComplicationTimelineEntry ( date :  Date (),  complicationTemplate :  template ))
//
//       case  . utilitarianSmall :
//           let  template  =  CLKComplicationTemplateUtilitarianSmallRingText ()
//           template . textProvider  =  CLKSimpleTextProvider ( text :  String(Int.random(in: 1 ..< 10)) )
//           template . fillFraction  =  self .randomNumber
//           handler ( CLKComplicationTimelineEntry ( date :  Date (),  complicationTemplate :  template ))
//
//       default :
//           handler ( nil )
//       }
        
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        if  complication . family  ==  . utilitarianSmall  {
            let  template  =  CLKComplicationTemplateUtilitarianSmallRingText ()
            template . textProvider  =  CLKSimpleTextProvider ( text :  String(Int.random(in: 1 ..< 10)) )
            template . fillFraction  =  self . randomNumber
            handler ( template )
//        } else if  complication . family  ==  . modularSmall  {
//            let  template  =  CLKComplicationTemplateUtilitarianSmallRingText ()
//            template . textProvider  =  CLKSimpleTextProvider ( text :  String(Int.random(in: 1 ..< 10)) )
//            template . fillFraction  =  self . randomNumber
//            handler ( template )
        }  else  {
            handler ( nil )
        }
        
    }
    
    // MARK: - Update Scheduling

//    func  getNextRequestedUpdateDate ( handler :  @ escaping  ( Date ?)  ->  void )  {
//        handler ( Date ( timeIntervalSinceNow :  TimeInterval ( 10 * 60 )))
//    }
    
    
    var randomNumber : Float {
        //return Float.random(in: 1 ..< 10)
        return Float(4)
    }
    
}
