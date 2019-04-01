#import "RomanTranslator.h"

@implementation RomanTranslator

-(NSString *)romanFromArabic:(NSString *)arabicString {
    NSArray *arabicValues = @[@1, @5, @10, @50, @100, @500, @1000];
    NSArray *romeSymbols = @[@"I", @"V", @"X", @"L", @"C", @"D", @"M"];
    NSInteger arabicNumber = [arabicString integerValue];
    NSMutableString *romanString = [[@"" mutableCopy] autorelease];
    NSInteger index = [arabicValues count] - 1;
    BOOL decade = YES;
    while (arabicNumber > 0) {
        double quantity = (double)arabicNumber / (double)[arabicValues[index] integerValue];
        if (decade) {
            if ((quantity >= 4) && (quantity < 5)) {
                NSString *pair = [NSString stringWithFormat:@"%@%@", romeSymbols[index], romeSymbols[index + 1]];
                [romanString appendString:pair];
            } else if ((quantity >= 1) && (quantity < 4)) {
                for (NSInteger times = 1; times <= quantity; times++) {
                    [romanString appendString:romeSymbols[index]];
                }
            }
            arabicNumber = arabicNumber % [arabicValues[index] integerValue];
        } else {
            if ((quantity >= 1.8) && (quantity <= 2)) {
                NSString *pair = [NSString stringWithFormat:@"%@%@", romeSymbols[index - 1], romeSymbols[index + 1]];
                [romanString appendString:pair];
                arabicNumber = arabicNumber % ([arabicValues[index - 1] integerValue] + 4 * [arabicValues[index + 1] integerValue]);
            } else if (quantity >= 1) {
                [romanString appendString:romeSymbols[index]];
                arabicNumber = arabicNumber % [arabicValues[index] integerValue];
            }
        }
        decade = !decade;
        index--;
    }
    return romanString;
}

-(NSString *)arabicFromRoman:(NSString *)romanString { //M CM XC IV 1994
    NSDictionary *romanArabicSymbols = @{
                                  @"I" : @1,
                                  @"V" : @5,
                                  @"X" : @10,
                                  @"L" : @50,
                                  @"C" : @100,
                                  @"D" : @500,
                                  @"M" : @1000
                                  };
    NSInteger number = 0;
    NSInteger index = 0;
    BOOL subtract = NO;
    while (index < [romanString length]) {
        if (!subtract && (index + 1 < [romanString length])) {
            if ((([romanString characterAtIndex:index] == 'I') && (([romanString characterAtIndex:index + 1] == 'V') || ([romanString characterAtIndex:index + 1] == 'X'))) || (([romanString characterAtIndex:index] == 'X') && (([romanString characterAtIndex:index + 1] == 'L') || ([romanString characterAtIndex:index + 1] == 'C'))) || (([romanString characterAtIndex:index] == 'C') && (([romanString characterAtIndex:index + 1] == 'D') || ([romanString characterAtIndex:index + 1] == 'M')))) {
                subtract = YES;
                index++;
                continue;
            }
        }
        for (NSString *symbol in romanArabicSymbols) {
            if ([symbol isEqualToString:[NSString stringWithFormat:@"%c", [romanString characterAtIndex:index]]]) {
                NSInteger subtrahend = 0;
                if (subtract) {
                    subtrahend = [[romanArabicSymbols valueForKey:[NSString stringWithFormat:@"%c", [romanString characterAtIndex:index - 1]]] integerValue];
                    subtract = NO;
                }
                number += [romanArabicSymbols[symbol] integerValue] - subtrahend;
                break;
            }
        }
        index++;
    }
    return [NSString stringWithFormat:@"%ld", number];
}

@end
