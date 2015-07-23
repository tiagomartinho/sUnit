#import <Foundation/Foundation.h>

@interface TryCatch : NSObject

+ (void) try:(void(^)())try catch:(void(^)(NSException *exception))catch finally:(void(^)())finally;
+ (void) try:(void(^)())try catch:(void(^)(NSException *exception))catch;
+ (void) try:(void(^)())try;
@end