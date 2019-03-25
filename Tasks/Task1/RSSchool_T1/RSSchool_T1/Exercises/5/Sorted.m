#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [[ResultObject new] autorelease];
    NSMutableArray *array = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] mutableCopy];
    
    NSInteger leftBorder = -1;
    NSInteger index = 0;
    BOOL possibleToReverse = NO;
    while (index < [array count] - 1) {
        if ([array[index] integerValue] > [array[index + 1] integerValue]) {
            if (leftBorder == -1) {
                leftBorder = index;
            } else if (index - leftBorder == 1) {
                possibleToReverse = YES;
                break;
            }
        } else if ((leftBorder != -1) && (index - leftBorder != 1)) {
            break;
        }
        index++;
    }
    
    if (leftBorder != -1) {
        NSInteger rightBorder = 0;
        NSInteger index = [array count] - 2;
        while (index >= 0) {
            if ([array[index] integerValue] > [array[index + 1]  integerValue]) {
                rightBorder = index + 1;
                break;
            }
            index--;
        }
        if (rightBorder != 0) {
            if (possibleToReverse) {
                for (index = leftBorder; index <= (leftBorder + rightBorder) / 2; index++) {
                    id temp = array[index];
                    array[index] = array[rightBorder + leftBorder - index];
                    array[rightBorder + leftBorder - index] = temp;
                }
            } else {
                id temp = array[leftBorder];
                array[leftBorder] = array[rightBorder];
                array[rightBorder] = temp;
            }
            index = 0;
            BOOL isSorted = YES;
            while (index < [array count] - 1) {
                if ([array[index] integerValue] > [array[index + 1] integerValue]) {
                    isSorted = NO;
                }
                index++;
            }
            if (isSorted) {
                value.status = YES;
                NSString *swapOrReverse = @"";
                if (possibleToReverse) {
                    swapOrReverse = @"reverse";
                } else {
                    swapOrReverse = @"swap";
                }
                value.detail = [NSString stringWithFormat:@"%@ %ld %ld", swapOrReverse, leftBorder + 1, rightBorder + 1];
            } else {
                value.status = NO;
            }
        } else {
            value.status = NO;
        }
    } else {
        value.status = YES;
    }
    [array release];
    return value;
}

@end
