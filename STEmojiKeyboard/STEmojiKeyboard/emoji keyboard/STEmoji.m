//
//  STEmoji.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STEmoji.h"

#define EMOJI_JSON_PATH [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"json"]

@implementation STEmoji
@end

static STEmojiStore *__emojiStoreInstance = nil;

@implementation STEmojiStore {
    NSArray *emojiStaticSections;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

+ (instancetype)instance
{
    @synchronized (self) {
        if (!__emojiStoreInstance) {
            __emojiStoreInstance = [[self alloc] init];
        }
    }
    return __emojiStoreInstance;
}

- (NSArray *)emojiJsonObjectFromPath:(NSString *)path
{
    NSData *emojiData = [[NSData alloc] initWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:emojiData options:NSJSONReadingAllowFragments error:nil];
}

- (NSArray *)buildEmojiSectionsWithJSONObject:(NSArray *)emojiJSON
{
    NSMutableArray *emojiList = [NSMutableArray new];
    for (NSDictionary *section in emojiJSON) {
        STEmoji *emoji = [STEmoji new];
        emoji.title = [section[@"title"] uppercaseString];
        emoji.icon = section[@"icon"];
        emoji.emojis = section[@"characters"];
        if (!emoji.icon) {
            emoji.icon = (emoji.emojis.count) ? emoji.emojis[0] : @"";
        }
        [emojiList addObject:emoji];
    }
    return emojiList;
}

- (NSArray *)allEmojis {

    if (!emojiStaticSections) {
        NSArray *emojiJSON = [self emojiJsonObjectFromPath:EMOJI_JSON_PATH];
        emojiStaticSections = [self buildEmojiSectionsWithJSONObject:emojiJSON];
    }
    return emojiStaticSections;
}

@end
