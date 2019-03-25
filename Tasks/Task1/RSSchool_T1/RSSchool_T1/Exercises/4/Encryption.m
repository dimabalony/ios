#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    NSString *sourceString = [[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *encryptedString = [[[NSMutableString alloc] init] autorelease];
    NSInteger floorL = floor(sqrt([string length]));
    NSInteger ceilL = ceil(sqrt([string length]));
    if (floorL * ceilL < [sourceString length]) {
        floorL++;
    }
    
    for (NSInteger column = 0; column < ceilL; column++) {
        NSInteger index = column;
        while (index < [sourceString length]) {
            [encryptedString appendString:[sourceString substringWithRange:NSMakeRange(index, 1)]];
            index += ceilL;
        }
        [encryptedString appendString:@" "];
    }
    [encryptedString deleteCharactersInRange:NSMakeRange([encryptedString length] - 1, 1)];
    return encryptedString;
}

@end
