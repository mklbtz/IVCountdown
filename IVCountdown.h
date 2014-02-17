//
//  IVTimeInterval.h
//
//  Created by Michael Bates on 3/20/13.
//  mklbtz.com
//  

#import <Foundation/Foundation.h>

@interface IVCountdown : NSObject
@property BOOL isPaused;
@property (readonly) int duration;  // in seconds

# pragma mark Creating and Initializing
+ (IVCountdown *)countdownWithSeconds:(int)seconds invocation:(NSInvocation *)anInvocation;
+ (IVCountdown *)countdownWithMinutes:(int)minutes invocation:(NSInvocation *)anInvocation;
+ (IVCountdown *)countdownWithMinutes:(int)minutes andSeconds:(int)seconds invocation:(NSInvocation *)anInvocation;

+ (IVCountdown *)countdownWithSeconds:(int)seconds target:(id)target selector:(SEL)selector;
+ (IVCountdown *)countdownWithMinutes:(int)minutes target:(id)target selector:(SEL)selector;
+ (IVCountdown *)countdownWithMinutes:(int)minutes andSeconds:(int)seconds target:(id)target selector:(SEL)selector;

- (IVCountdown *)initWithSeconds:(int)seconds invocation:(NSInvocation *)anInvocation;
- (IVCountdown *)initWithMinutes:(int)minutes invocation:(NSInvocation *)anInvocation;
- (IVCountdown *)initWithMinutes:(int)minutes andSeconds:(int)seconds invocation:(NSInvocation *)anInvocation;

- (IVCountdown *)initWithSeconds:(int)seconds target:(id)target selector:(SEL)selector;
- (IVCountdown *)initWithMinutes:(int)minutes target:(id)target selector:(SEL)selector;
- (IVCountdown *)initWithMinutes:(int)minutes andSeconds:(int)seconds target:(id)target selector:(SEL)selector;

# pragma mark Comparing
- (NSComparisonResult)compare:(IVCountdown *)anotherInterval;
- (BOOL)isEqualToCountdown:(IVCountdown *)anotherInterval;
- (IVCountdown *)longerCountdown:(IVCountdown *)anotherInterval;
- (IVCountdown *)shorterCountdown:(IVCountdown *)anotherInterval;

# pragma mark Accessing the Remaining Duration
- (NSString *)description;
- (NSString *)simpleDescription;
- (int)duration;

# pragma mark Timer Control
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;
- (void)timerFireMethod:(NSTimer*)timer;

@end
