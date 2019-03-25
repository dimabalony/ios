#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    NSMutableArray *array = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] mutableCopy];
    
    NSInteger leftBorder = 0;
    NSInteger rightBorder = 0;
    NSInteger index = 0;
    BOOL isPossibleToSort = YES;
    BOOL isSwapable = NO;
    while (index < [array count] - 1) {
        if ([array[index] integerValue] > [array[index + 1] integerValue]) {
            if (leftBorder + rightBorder > 0) {
                isPossibleToSort = NO;
                break;
            }
            leftBorder = index;
            while (index < [array count] - 1) {
                if ([array[index] integerValue] < [array[index + 1] integerValue]) {
                    break;
                }
                index++;
            }
            rightBorder = index;
            for (NSInteger indexToReverse = 0; indexToReverse + leftBorder <= (leftBorder + rightBorder) / 2; indexToReverse++) {
                id temp = array[leftBorder + indexToReverse];
                array[leftBorder + indexToReverse] = array[rightBorder - indexToReverse];
                array[rightBorder - indexToReverse] = temp;
            }
            index = -1;
        }
        index++;
    }
    
    //if isPossibleToSort == NO && (rightBorder - leftBorder == 1)
    //найти второе несоответствие
    //поменять их
    //1 2 3 7 5 6 4 8 9
    //1 2 3 5 7 6 4 8 9
    
    if (!isPossibleToSort && (rightBorder - leftBorder == 1)) {
        
        id temp = array[leftBorder];
        array[leftBorder] = array[rightBorder];
        array[rightBorder] = temp;
        
        NSInteger index = rightBorder;
        
        while (index < [array count] - 1) {
            if ([array[index] integerValue] > [array[index + 1] integerValue]) {
                rightBorder = index + 1;
                temp = array[leftBorder];
                array[leftBorder] = array[rightBorder];
                array[rightBorder] = temp;
            }
            index++;
        }
        
        index = 0;
        isPossibleToSort = YES;
        while (index < [array count] - 1) {
            if ([array[index] integerValue] > [array[index + 1] integerValue]) {
                isPossibleToSort = NO;
            }
            index++;
        }
        isSwapable = YES;
    }
    
    if (isPossibleToSort) {
        value.status = YES;
        NSString *detail = [NSString new];
        if (isSwapable || (rightBorder - leftBorder == 1)) {
            detail = @"swap";
        } else if (rightBorder - leftBorder > 1) {
            detail = @"reverse";
        }
        if (rightBorder + leftBorder > 0) {
            value.detail =  [NSString stringWithFormat:@"%@ %ld %ld", detail, leftBorder + 1, rightBorder + 1];
        }
    } else {
        value.status = NO;
    }

    return value;
}

@end
