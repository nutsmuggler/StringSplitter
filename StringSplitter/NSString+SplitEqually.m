//
//  NSString+SplitEqually.m
//  StringSplitter
//
//  Created by Davide Benini on 21/01/16.
//  Copyright © 2016 NtNext. All rights reserved.
//

#import "NSString+SplitEqually.h"

@implementation NSString (SplitEqually)

-(NSString*)splitEquallyWithTextAttributes:(NSDictionary*)attributes {
    
    // Return with empty string
    //
    if ([self isEqualToString:@""]) {
        return @"";
    }
    
    // return if line has no whitespace
    //
    NSInteger whitespacesCount = [[self componentsSeparatedByString:@" "] count] - 1;
    if (whitespacesCount < 1) {
        return self;
    }
    
    // Calculate deltas splitting at different whitspaces
    //
    NSMutableArray* deltas = [[NSMutableArray alloc] init];
    for (int i = 0; i < whitespacesCount; i++) {
        NSArray* lines = [self componentsSplittingAtWhitespace:i];
        
        // Return if we just have one line
        //
        if ([lines count] == 1) {
            return lines[0];
        }

        CGFloat line_0_w = [lines[0] sizeWithAttributes:attributes].width;
        
        CGFloat line_1_w = [lines[1] sizeWithAttributes:attributes].width;
        CGFloat delta = fabs(line_1_w - line_0_w);
        [deltas addObject:@(delta)];
    }
    
    // Get minimum delta and corresponding whitespace
    //
    NSNumber *min=[deltas valueForKeyPath:@"@min.doubleValue"];
    NSInteger position = [deltas indexOfObject:min];
    
    // Segment at corresponding string
    //
    NSArray* lines = [self componentsSplittingAtWhitespace:position];
    
    // Return with newline in between
    //
    NSString* result = [NSString stringWithFormat:@"%@\n%@",lines[0],lines[1]];
    return result;
    
}

-(NSArray*)componentsSplittingAtWhitespace:(NSInteger)whitespace {
    return [NSString componentsSplittingString:self atWhitespace:whitespace];
}

+(NSArray*)componentsSplittingString:(NSString*)input atWhitespace:(NSInteger)position {
    
    NSArray* words = [input componentsSeparatedByString:@" "];
    if ([words count] < position) {
        return words;
    }
    
    NSMutableArray* firstLineWords = [[NSMutableArray alloc] init];
    NSMutableArray* lastLineWords = [[NSMutableArray alloc] initWithArray:words];
    
    for (NSInteger i = 0; i <= position; i++) {
        if ([words count] > i) {
            [firstLineWords addObject:[words objectAtIndex:i]];
            [lastLineWords removeObjectAtIndex:0];
        }
    }
    NSString* firstLine = [firstLineWords componentsJoinedByString:@" "];
    NSString* lastLine = [lastLineWords componentsJoinedByString:@" "];
    return @[firstLine,lastLine];
}


@end
