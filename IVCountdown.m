//
//  IVTimeInterval.m
//
//  Created by Michael Bates on 3/20/13.
//  mklbtz.com
//  

#import "IVCountdown.h"

@interface IVCountdown ()

@property (nonatomic, retain) NSTimer * timer;
@property (nonatomic, retain) NSInvocation * invocation;

@end

@implementation IVCountdown

# pragma mark Creating and Initializing

+ (IVCountdown *)countdownWithSeconds:(int)seconds invocation:(NSInvocation *)anInvocation {
	return [[IVCountdown alloc] initWithSeconds:seconds invocation:anInvocation];
}

+ (IVCountdown *)countdownWithMinutes:(int)minutes invocation:(NSInvocation *)anInvocation {
	return [[IVCountdown alloc] initWithMinutes:minutes invocation:anInvocation];
}

+ (IVCountdown *)countdownWithMinutes:(int)minutes andSeconds:(int)seconds invocation:(NSInvocation *)anInvocation {
	return [[IVCountdown alloc] initWithMinutes:minutes andSeconds:seconds invocation:anInvocation];
}

+ (IVCountdown *)countdownWithSeconds:(int)seconds target:(id)target selector:(SEL)selector {
	return [[IVCountdown alloc] initWithSeconds:seconds target:target selector:selector];
}

+ (IVCountdown *)countdownWithMinutes:(int)minutes target:(id)target selector:(SEL)selector {
	return [[IVCountdown alloc] initWithMinutes:minutes target:target selector:selector];
}

+ (IVCountdown *)countdownWithMinutes:(int)minutes andSeconds:(int)seconds target:(id)target selector:(SEL)selector {
	return [[IVCountdown alloc] initWithMinutes:minutes andSeconds:seconds target:target selector:selector];
}


- (IVCountdown *)init{ _duration = 0; return self; }  // this should not be called. It is worthless.

- (IVCountdown *)initWithSeconds:(int)seconds invocation:(NSInvocation *)anInvocation {
	return [self initWithMinutes:0 andSeconds:seconds invocation:anInvocation];
}

- (IVCountdown *)initWithMinutes:(int)minutes invocation:(NSInvocation *)anInvocation {
	return [self initWithMinutes:minutes andSeconds:0 invocation:anInvocation];
}

- (IVCountdown *)initWithMinutes:(int)minutes andSeconds:(int)seconds invocation:(NSInvocation *)anInvocation {
	self = [super init];
	
	if (self) {
		_duration = 60*minutes + seconds;
		[anInvocation setArgument:&self atIndex:2];
		[self setInvocation:anInvocation];
		_isPaused = YES;
	}
	return self;
}

- (IVCountdown *)initWithSeconds:(int)seconds target:(id)target selector:(SEL)selector {
	return [self initWithMinutes:0 andSeconds:seconds target:target selector:selector];
}

- (IVCountdown *)initWithMinutes:(int)minutes target:(id)target selector:(SEL)selector {
	return [self initWithMinutes:minutes andSeconds:0 target:target selector:selector];
}

- (IVCountdown *)initWithMinutes:(int)minutes andSeconds:(int)seconds target:(id)target selector:(SEL)selector {
	NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	return [self initWithMinutes:minutes andSeconds:seconds invocation:invocation];
}


# pragma mark Timer Control
- (void)start {
	if (_duration > 0 && _isPaused) {
		_isPaused = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
}

- (void)pause {
    [_timer invalidate];
    _timer = nil;
	_isPaused = YES;
}

- (void)resume {
    [self start];
}

- (void)cancel {
    [_timer invalidate];
    _timer = nil;
    _duration = 0;
	_isPaused = YES;
}

- (void)timerFireMethod:(NSTimer*)timer {
    _duration = _duration - 1;
	if (_duration == 0) {
		[self cancel];
	}
	[_invocation invoke];
}


# pragma mark Comparing
- (NSComparisonResult)compare:(IVCountdown *)anotherInterval {
    // I'm converting to NSNumber so I can use it's compare: method
    // that way I don't have to worry incorrectly comparing them.
    return [[NSNumber numberWithInt:_duration] compare:[NSNumber numberWithInt:anotherInterval.duration]];
}

- (BOOL)isEqualToCountdown:(IVCountdown *)anotherInterval {
    return _duration == anotherInterval.duration;
}

- (IVCountdown *)longerCountdown:(IVCountdown *)anotherInterval {
    if ([self compare:anotherInterval] == NSOrderedAscending) {
        return anotherInterval;
    }
    else return self;
}

- (IVCountdown *)shorterCountdown:(IVCountdown *)anotherInterval {
    if ([self compare:anotherInterval] == NSOrderedAscending) {
        return self;
    }
    else return anotherInterval;
}


# pragma mark Accessing the Remaining Duration
- (NSString *)description {
	int minutes = _duration / 60;
	int seconds = _duration % 60;
	if (seconds < 10)
		return [NSString stringWithFormat:@"%d:0%d", minutes, seconds];
	else return [NSString stringWithFormat:@"%d:%d", minutes, seconds];
}

- (NSString *)simpleDescription {
	int minutes = _duration / 60;
	int seconds = _duration % 60;
	if (minutes > 0) return [self description];
	else return [NSString stringWithFormat:@"%d", seconds];
}

@end
