#import "KidnapperNote.h"

@implementation KidnapperNote
-(BOOL)checkMagazine:(NSString *)magazine note:(NSString *)note {
    NSMutableArray *magazineNotes = [[[magazine lowercaseString] componentsSeparatedByString:@" "] mutableCopy];
    NSArray *notes = [[note lowercaseString] componentsSeparatedByString:@" "];
    
    for (NSString *noteWord in notes) {
        BOOL found = NO;
        for (NSString *magazineWord in magazineNotes) {
            if ([noteWord isEqualToString:magazineWord]) {
                found = YES;
                [magazineNotes removeObject:magazineWord];
                break;
            }
        }
        if (!found) {
            return NO;
        }
    }
    
    return YES;
}
@end
