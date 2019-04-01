#import "RomanTranslator.h"

@implementation RomanTranslator

-(NSString *)romanFromArabic:(NSString *)arabicString { //1994 - 1000 - 900 - 90 - 4
    NSDictionary *romanArabicSymbols = @{
                                         @"I" : @1,
                                         @"V" : @5,
                                         @"X" : @10,
                                         @"L" : @50,
                                         @"C" : @100,
                                         @"D" : @500,
                                         @"M" : @1000
                                         };
    NSInteger arabicNumber = [arabicString integerValue];
    NSMutableString *romanString = [@"" mutableCopy];
    while (arabicNumber > 0) {
        for (NSString *symbol in romanArabicSymbols) {
            NSInteger subtrahend = [[romanArabicSymbols valueForKey:symbol] integerValue];
            if ((arabicNumber - subtrahend >= -subtrahend / 10 - 1) && (arabicNumber - subtrahend <= subtrahend)){ //4 - 5 = -1
                NSArray *allNumbers = [romanArabicSymbols allValues];
                NSInteger previousIndex = [allNumbers indexOfObject:[NSString stringWithFormat:@"%ld", subtrahend]];
                NSInteger previousNumber = [[allNumbers objectAtIndex: previousIndex] integerValue];
                NSString *previousSymbol = [[romanArabicSymbols allKeysForObject:[NSString stringWithFormat:@"%ld", previousIndex]] firstObject];
                [romanString appendString:previousSymbol];
                [romanString appendString:symbol];
                arabicNumber -= subtrahend - previousNumber;
                break;
            } else if ((arabicNumber - subtrahend >= 0) && (arabicNumber - subtrahend <= subtrahend / 2)) {
                [romanString appendString:symbol];
                arabicNumber -= subtrahend;
                break;
            }
        }
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
