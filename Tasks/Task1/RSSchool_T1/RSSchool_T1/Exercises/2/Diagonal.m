#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    unsigned long count = [array count];
    NSInteger index = 0;
    NSInteger primaryDiagonal = 0;
    NSInteger secondaryDiagonal = 0;
    for (NSString* element in array) {
        NSArray *row = [element componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        primaryDiagonal = primaryDiagonal + [[row objectAtIndex:index] integerValue];
        secondaryDiagonal = secondaryDiagonal + [[row objectAtIndex:(count - index - 1)] integerValue];
        index++;
    }
    NSInteger result = labs(primaryDiagonal - secondaryDiagonal);
    return @(result);
}

@end
