//
//  Header.h
//  iOSGuide
//
//  Created by odyang on 2017/10/8.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Peregrine/Peregrine.h>

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

#if DEBUG

#define NSLog(frmt, ...) DDLogVerbose(frmt,__func__,__LINE__, ##__VA_ARGS__);

#define LogInfo(frmt, ...) DDLogInfo(@"" frmt, ##__VA_ARGS__);
#define LogDebug(frmt, ...) DDLogDebug(@"" frmt, ##__VA_ARGS__);
#define LogWarn(frmt, ...) DDLogWarn(@"" frmt, ##__VA_ARGS__);
#define LogError(frmt, ...) DDLogError(@"" frmt, ##__VA_ARGS__);

#else
#define LogInfo(frmt, ...)
#define LogDebug(frmt, ...)
#define LogWarn(frmt, ...)
#define LogError(frmt, ...)
#define NSLog(...)
#endif

#endif /* Header_h */
