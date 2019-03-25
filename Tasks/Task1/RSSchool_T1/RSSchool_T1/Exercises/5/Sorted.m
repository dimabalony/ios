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
    
    if (isPossibleToSort) {
        value.status = YES;
        NSString *detail = [NSString new];
        if (rightBorder - leftBorder == 1) {
            detail = @"swap";
        } else if (rightBorder - leftBorder > 1) {
            detail = @"reverse";
        }
        value.detail =  [NSString stringWithFormat:@"%@ %ld %ld", detail, leftBorder + 1, rightBorder + 1];
    } else {
        value.status = NO;
    }

    return value;
}

@end

////swap
////    BOOL isSwapable = NO;
//NSInteger inconsistencies = 0;
//NSMutableString *result = [[NSMutableString alloc] init];
//NSMutableArray *arrayToSwap = [[NSMutableArray alloc] initWithArray:arrayToReverse];
//BOOL isSorted = NO;
//while (!isSorted) {
//    isSorted = YES;
//    for (NSInteger index = 0; index < [arrayToSwap count] - 1; index++) {
//        if ([arrayToSwap[index] integerValue] > [arrayToSwap[index + 1] integerValue]) {
//            if (inconsistencies == 0) { //попробовать упростить
//                [result appendString:[NSString stringWithFormat:@"swap %ld %ld", index, index + 1]];
//            }
//            isSorted = NO;
//            inconsistencies++;
//            id temp = arrayToSwap[index];
//            arrayToSwap[index] = arrayToSwap[index + 1];
//            arrayToSwap[index + 1] = temp;
//        }
//    }
//    //если несостыковка 2+ выходить
//}
//
//if (inconsistencies > 1) {
//    result = [@"" mutableCopy];
//    NSInteger index = 0;
//    BOOL isReversed = NO;
//    while (index < [arrayToReverse count] - 1) {
//        if (([arrayToReverse[index] integerValue] > [arrayToReverse[index + 1] integerValue]) && !isReversed) {
//            [result appendString:[NSString stringWithFormat:@"reverse %ld ", index + 1]];
//            isReversed = YES;
//            NSInteger reverseIndex = index;
//            while (reverseIndex < [arrayToReverse count] - 1) {
//                if ([arrayToReverse[reverseIndex] integerValue] < [arrayToReverse[reverseIndex + 1] integerValue]) {
//                    break;
//                }
//                reverseIndex++;
//            }
//            [result appendString:[NSString stringWithFormat:@"%ld", reverseIndex + 1]];
//            index = reverseIndex;
//        } else if (([arrayToReverse[index] integerValue] > [arrayToReverse[index + 1] integerValue]) && isReversed) {
//            isReversed = NO;
//            break;
//        }
//        index++;
//    }
//
//    if (isReversed) {
//        value.status = YES;
//        value.detail = result;
//    }
//}
//// 1 2 6 5 4 3 7 8
//// 2 5
////проверить swap
////если 1 несостыковка - решение
////пропустить reverse
////если 2+ несостыковка - нет решения
////искать reverse
////если нет решения и 0 несостыковок
////массив отсортирован


