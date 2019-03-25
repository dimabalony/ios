#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    NSInteger sum = 0;
    for (NSNumber* element in array) {
        NSInteger number = [element integerValue];
        sum = sum + number;
    }
    return @(sum);
}

@end
