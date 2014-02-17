# Countdown Timer

## About

This is a class which allows you to to easily create timers with a sense of remaining time and a human-readable output. Trying to build a game with a coutdown, I found it frustrating that NSTimer did not have a way to just behave like a stop watch; it seemed like such a simple task. So, rather than have the game controller in my project manage the time, I built this class handle it.

## Features

I wanted to make IVCountdown as flexible as possible for others to use, so I modeled it after NSTimer, the Apple-provided class for invoking timed methods. In fact, NSTimer is how IVCountdown operates underneath.

- Can be initialized with any number of minutes and seconds.
- Can be initialized to fire a method using NSInvocation or using the target, selector method.
- Can be instantiated through class methods or with alloc & init.
- Can be compared to other IVCountdown instances; return value works the same way as with NSNumber.
- Human-readable and numeric representatin of the remaining time.
- Can be paused/resumed or canceled. Especially useful in games.
