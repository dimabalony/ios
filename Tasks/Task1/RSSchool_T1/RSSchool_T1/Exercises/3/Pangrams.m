#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSMutableString *alphabet = [[[NSMutableString alloc] initWithString:@"abcdefghijklmnopqrstuvwxyz"] autorelease];
    NSString *stringToCheck = [[NSString alloc] initWithString:[[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    for (NSInteger charIndex = 0; charIndex < stringToCheck.length; charIndex++) {
        NSString *character = [stringToCheck substringWithRange:NSMakeRange(charIndex, 1)];
        [alphabet replaceOccurrencesOfString:character withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [alphabet length])];
    }
    [stringToCheck release];
    return ![alphabet length];
}

@end
