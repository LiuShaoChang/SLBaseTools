//
//  NSString+emjoy.m
//  Yjyx
//
//  Created by yjyx-iOS2 on 16/10/12.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "NSString+emjoy.h"

@implementation NSString (emjoy)


+ (NSString *)filterEmojis:(NSString *)string {
    __block NSString *filteredString = string;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f || ls ==0xd83c) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
         }
     }];
    return filteredString;
}

@end
