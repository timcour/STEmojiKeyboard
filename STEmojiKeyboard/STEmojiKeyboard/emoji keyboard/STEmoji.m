//
//  STEmoji.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STEmoji.h"

#define EMOJI_JSON_PATH [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"json"]

#define MAX_RECENT_EMOJI_COUNT 5
static NSString *kPrefsKeyEmojiRecent = @"prefsKeyEmojiRecent";

@implementation STEmoji
@end

@implementation STEmojiRecent

+ (void)addRecentEmoji:(NSString *)emoji
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recent = [[prefs arrayForKey:kPrefsKeyEmojiRecent] mutableCopy];
    recent = (recent) ?: [@[] mutableCopy];
    [recent removeObject:emoji];
    while (recent.count >= MAX_RECENT_EMOJI_COUNT) {
        [recent removeLastObject];
    }
    [recent insertObject:emoji atIndex:0];
    [prefs setObject:recent forKey:kPrefsKeyEmojiRecent];
    // TODO(TIM): should we synchronize?
}

- (NSString *)icon
{
    return @"🕒";
}

- (NSString *)title
{
    return @"RECENT";
}

- (NSArray *)emojis
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPrefsKeyEmojiRecent];
}

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
    [emojiList addObject:[STEmojiRecent new]];
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
