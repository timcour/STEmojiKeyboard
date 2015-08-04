//
//  STEmoji.h
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STEmoji : NSObject

@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *emojis;

@end

@interface STEmojiStore : NSObject
+ (instancetype)instance;
- (NSArray *)allEmojis;
@end
