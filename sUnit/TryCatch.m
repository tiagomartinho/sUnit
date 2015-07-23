#import "TryCatch.h"

@implementation TryCatch

+ (void) try:(void(^)())try{
    [self try:try catch:nil finally:nil];
}

+ (void) try:(void(^)())try catch:(void(^)(NSException *exception))catch{
    [self try:try catch:catch finally:nil];
}

+ (void) try:(void(^)())try catch:(void(^)(NSException *exception))catch finally:(void(^)())finally{
    
    @try {
        try ? try() : nil;
    }
    @catch (NSException *exception) {
        catch ? catch(exception) : nil;
    }
    @finally {
        finally ? finally() : nil;
    }
}

@end